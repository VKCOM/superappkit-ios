//
//  Copyright (c) 2020 - present, LLC “V Kontakte”
//
//  1. Permission is hereby granted to any person obtaining a copy of this Software to
//  use the Software without charge.
//
//  2. Restrictions
//  You may not modify, merge, publish, distribute, sublicense, and/or sell copies,
//  create derivative works based upon the Software or any part thereof.
//
//  3. Termination
//  This License is effective until terminated. LLC “V Kontakte” may terminate this
//  License at any time without any without any negative consequences to our rights.
//  You may terminate this License at any time by deleting the Software and all copies
//  thereof. Upon termination of this license for any reason, you shall continue to be
//  bound by the provisions of Section 2 above.
//  Termination will be without prejudice to any rights LLC “V Kontakte” may have as
//  a result of this agreement.
//
//  4. Disclaimer of warranty and liability
//  THE SOFTWARE IS MADE AVAILABLE ON THE “AS IS” BASIS. LLC “V KONTAKTE” DISCLAIMS
//  ALL WARRANTIES THAT THE SOFTWARE MAY BE SUITABLE OR UNSUITABLE FOR ANY SPECIFIC
//  PURPOSES OF USE. LLC “V KONTAKTE” CAN NOT GUARANTEE AND DOES NOT PROMISE ANY
//  SPECIFIC RESULTS OF USE OF THE SOFTWARE.
//  UNDER NO SIRCUMSTANCES LLC “V KONTAKTE” BEAR LIABILITY TO THE LICENSEE OR ANY
//  THIRD PARTIES FOR ANY DAMAGE IN CONNECTION WITH USE OF THE SOFTWARE.
//

import SuperAppKit
import UIKit

// MARK: - AuthViewController

final class AuthViewController: UIViewController {

    private let button = OneTapRegistrationButton()

    private var appConfiguration: AuthApplicationConfiguration {
        let legalTextConfiguration: LegalTextConfiguration
        legalTextConfiguration = LegalTextConfiguration(
            termsOfUsageUrl: URL(string: "https://id.vk.com/terms")!,
            privacyPolicyUrl: URL(string: "https://id.vk.com/privacy")!
        )

        return AuthApplicationConfiguration(
            applicationName: "SAK Platform Demo", // pass your app name here
            applicationIcon: Bundle.main.appIcon ?? UIImage(), // pass your app icon here
            legalTextConfiguration: legalTextConfiguration, // pass legal texts configuration of your app if present
            migrationConfiguration: nil,
            oAuthItems: nil,
            flowSource: nil
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = VAColor.va.backgroundContent

        button.onTap = { [weak self] in
            self?.showExternalAuth()
        }
        button.accessibilityIdentifier = "start_screen.auth_button"

        view.addSubview(button)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        button.frame = .init(
            origin: .zero,
            size: .init(
                width: min(335, view.bounds.width - 12 * 2),
                height: 48
            )
        )
        button.center = view.center
    }

    private func showExternalAuth() {
        let configuration = AuthConfiguration.externalConfiguration(with: appConfiguration)
        configuration.delegate = self
        guard let viewController = AuthFactory.viewController(for: configuration) else {
            return
        }
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: false)
    }
}

// MARK: AuthProcessDelegate

extension AuthViewController: AuthProcessDelegate {

    func processSilentToken(
        with silentToken: String?,
        uuid: String?,
        success: @escaping (Int, String) -> Void,
        failure: @escaping () -> Void
    ) {
        guard let silentTokenExchangeURLString = Bundle.main.infoDictionary?["SilentTokenExchangeURL"] as? String else {
            //  Exchange silent token for access token — perform a back-to-back request. To do this, in the demo app configuration file (Info.plist) add your backend URL in SilentTokenExchangeURL field.
            VAHUD.success("You received silent token")
            return
        }

        guard let silentToken = silentToken, let uuid = uuid else {
            failure()
            return
        }

        var components = URLComponents(string: silentTokenExchangeURLString)

        var queryItems = components?.queryItems ?? []
        // Maybe you will need other parameters for your URL
        queryItems.append(contentsOf: [
            URLQueryItem(name: "silent_token", value: silentToken),
            URLQueryItem(name: "uuid", value: uuid),
        ])
        components?.queryItems = queryItems

        guard let url = components?.url else {
            failure()
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, _ in
            DispatchQueue.main.async {
                guard
                    let data = data,
                    let exchangeResponse = try? JSONDecoder().decode(ExchangeSilentTokenResponse.self, from: data)
                else {
                    failure()
                    return
                }
                success(exchangeResponse.response.userId, exchangeResponse.response.accessToken)
            }
        }
        task.resume()
    }

    func exchageSilentToken(with state: AuthState, success: @escaping (Int, String) -> Void, failure: @escaping () -> Void) {
        //  You should exchange silent token and uuid from state. Call `success` block with received userID and access token. If request fails call `failure` block
        processSilentToken(
            with: state.silentToken,
            uuid: state.silentUUID,
            success: success,
            failure: failure
        )
    }

    func authComplete(with state: AuthState) {
        dismiss(animated: true) {
            guard let token = state.token, state.userId > 0 else {
                VAHUD.error("Did not receive access token")
                return
            }

            let userId = state.userId
            var components = URLComponents(string: "https://api.vk.com/method/users.get")
            components?.queryItems = [
                URLQueryItem(name: "access_token", value: token),
                URLQueryItem(name: "user_ids", value: "\(userId)"),
                URLQueryItem(name: "v", value: "5.141"),
            ]

            guard let url = components?.url else {
                return
            }

            let request = URLRequest(url: url)

            let task = URLSession.shared.dataTask(with: request) { data, response, _ in
                DispatchQueue.main.async {
                    guard
                        let data = data,
                        let usersResponse = try? JSONDecoder().decode(UsersInfoResponse.self, from: data),
                        let userInfo = usersResponse.response.first
                    else {
                        VAHUD.error("Error while getting user info for id: \(userId)")
                        return
                    }
                    VAHUD.success("You received access token of \(userInfo.firstName) \(userInfo.lastName) with id \(userId)")
                }
            }
            task.resume()
        }
    }

    func closedByUser() {
        dismiss(animated: true)
    }
}

extension AuthViewController {

    struct ExchangeSilentTokenResponse: Codable {
        let response: TokenData
    }

    struct TokenData: Codable {
        let userId: Int
        let accessToken: String

        private enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case accessToken = "access_token"
        }
    }

    struct UsersInfoResponse: Codable {
        let response: [UserInfo]
    }

    struct UserInfo: Codable {
        let firstName: String
        let lastName: String

        private enum CodingKeys: String, CodingKey {
            case firstName = "first_name"
            case lastName = "last_name"
        }
    }
}
