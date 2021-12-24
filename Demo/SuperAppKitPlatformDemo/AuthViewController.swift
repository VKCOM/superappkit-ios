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

import UIKit
import SuperAppKit

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
        let configuration = AuthConfiguration(
            configuration: appConfiguration,
            nativeAuth: true
        )
        configuration.delegate = self
        guard let viewController = AuthFactory.viewController(for: configuration) else {
            return
        }
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: false)
    }
}

extension AuthViewController: AuthProcessDelegate {
    
    func processSilentToken(with silentToken: String?, uuid: String?, success: @escaping (Int, String) -> Void, failure: @escaping () -> Void) {
        
        // You should use your own backend to exchange silent token with backend-to-backend request and call `success` block with userID and received access token. If request failed call `failure` block
        dismiss(animated: true) {
            VAHUD.success("Silent token received. You can exchange it to access token using your own backend")
        }
    }

    func exchageSilentToken(with state: AuthState, success: @escaping (Int, String) -> Void, failure: @escaping () -> Void) {
        processSilentToken(
            with: state.silentToken,
            uuid: state.silentUUID,
            success: success,
            failure: failure
        )
    }

    func authComplete(with state: AuthState) {
        dismiss(animated: true) {
            if let _ = state.token {
                VAHUD.success("You are authorized as user with id: \(state.userId)")
            }
        }
    }

    func closedByUser() {
        dismiss(animated: true)
    }
}
