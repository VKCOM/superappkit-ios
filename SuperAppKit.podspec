Pod::Spec.new do |s|
  s.name = 'SuperAppKit'
  s.version = '0.79.8330967'
  s.summary = 'SuperAppKit'
  s.authors = 'VK.com'
  
  s.homepage = 'https://vk.com/superappkit'
  s.license = { :type => 'Copyright (c) 2020 - present, LLC “V Kontakte”', :text => <<-LICENSE
1. Permission is hereby granted to any person obtaining a copy of this Software to
use the Software without charge.

2. Restrictions
You may not modify, merge, publish, distribute, sublicense, and/or sell copies,
create derivative works based upon the Software or any part thereof.

3. Termination
This License is effective until terminated. LLC “V Kontakte” may terminate this
License at any time without any negative consequences to our rights.
You may terminate this License at any time by deleting the Software and all copies
thereof. Upon termination of this license for any reason, you shall continue to be
bound by the provisions of Section 2 above.
Termination will be without prejudice to any rights LLC “V Kontakte” may have as
a result of this agreement.

4. Disclaimer of warranty and liability
THE SOFTWARE IS MADE AVAILABLE ON THE “AS IS” BASIS. LLC “V KONTAKTE” DISCLAIMS
ALL WARRANTIES THAT THE SOFTWARE MAY BE SUITABLE OR UNSUITABLE FOR ANY SPECIFIC
PURPOSES OF USE. LLC “V KONTAKTE” CAN NOT GUARANTEE AND DOES NOT PROMISE ANY
SPECIFIC RESULTS OF USE OF THE SOFTWARE.
UNDER NO SIRCUMSTANCES LLC “V KONTAKTE” BEAR LIABILITY TO THE LICENSEE OR ANY
THIRD PARTIES FOR ANY DAMAGE IN CONNECTION WITH USE OF THE SOFTWARE.
    LICENSE
  }

  s.ios.deployment_target = '11.4'
  s.swift_version = '5.0'
  s.cocoapods_version = '>= 1.9.0'

  s.subspec 'APILayer' do |ss|
    ss.ios.dependency 'SuperAppKit/Kulibin'
    ss.ios.dependency 'SuperAppKit/KulibinNetworking'
    ss.ios.dependency 'SuperAppKit/KulibinPersistency'
    ss.ios.dependency 'SuperAppKit/Nestor'
    ss.resources = 'APILayer.bundle'
    ss.vendored_frameworks = 'APILayer.xcframework'
  end
    
  s.subspec 'BrowserBridge' do |ss|
    ss.ios.dependency 'SuperAppKit/APILayer'
    ss.ios.dependency 'SuperAppKit/Kulibin'
    ss.ios.dependency 'SuperAppKit/KulibinNetworking'
    ss.ios.dependency 'SuperAppKit/KulibinPersistency'
    ss.ios.dependency 'SuperAppKit/Nestor'
    ss.ios.dependency 'SuperAppKit/Orwell'
    ss.ios.dependency 'SuperAppKit/Susanin'
    ss.ios.dependency 'SuperAppKit/VKSVGImage'
    ss.ios.dependency 'SuperAppKit/ValetteKit'
    ss.ios.dependency 'SuperAppKit/Warhol'
    ss.ios.dependency 'SSZipArchive', '~> 2.1'
    ss.ios.dependency 'SuperAppKit/SAKLocalShared'
    ss.resources = 'BrowserBridge.bundle'
    ss.vendored_frameworks = 'BrowserBridge.xcframework'
  end
  
  s.subspec 'Kulibin' do |ss|
    ss.libraries = 'sqlite3', 'c++', 'resolv', 'compression'
    ss.resources = 'Kulibin.bundle'
    ss.vendored_frameworks = 'Kulibin.xcframework'
  end
  
  s.subspec 'KulibinNetworking' do |ss|
    ss.ios.dependency 'SuperAppKit/Kulibin'
    ss.ios.dependency 'SuperAppKit/KulibinPersistency'
    ss.ios.dependency 'SuperAppKit/Nestor'
    ss.ios.framework = 'CFNetwork'
    ss.ios.framework = 'Accelerate'
    ss.ios.framework = 'AdSupport'
    ss.ios.framework = 'CloudKit'
    ss.ios.framework = 'CoreServices'
    ss.ios.framework = 'CoreTelephony'
    ss.weak_framework  = 'Network'
    ss.libraries = 'sqlite3', 'c++', 'resolv'
    ss.resources = 'KulibinNetworking.bundle'
    ss.vendored_frameworks = 'KulibinNetworking.xcframework'
  end
  
  s.subspec 'KulibinPersistency' do |ss|
    ss.ios.dependency 'SuperAppKit/Kulibin'
    ss.ios.dependency 'SuperAppKit/Nestor'
    $yapDatabaseVersion = '4.0'
    ss.ios.dependency 'YapDatabase/Standard/Core', $yapDatabaseVersion
    ss.ios.dependency 'YapDatabase/Standard/Extensions/View', $yapDatabaseVersion
    ss.ios.dependency 'YapDatabase/Standard/Extensions/AutoView', $yapDatabaseVersion
    ss.ios.dependency 'YapDatabase/Standard/Extensions/FilteredView', $yapDatabaseVersion
    ss.ios.dependency 'YapDatabase/Standard/Extensions/SecondaryIndex', $yapDatabaseVersion
    ss.ios.dependency 'YapDatabase/Standard/Extensions/Hooks', $yapDatabaseVersion
    ss.libraries = 'sqlite3', 'c++', 'resolv'
    ss.resources = 'KulibinPersistency.bundle'
    ss.vendored_frameworks = 'KulibinPersistency.xcframework'
  end
  
  s.subspec 'Malevich' do |ss|
    ss.ios.framework = 'UIKit'
    ss.resources = 'Malevich.bundle'
    ss.vendored_frameworks = 'Malevich.xcframework'
  end
  
  s.subspec 'Milligan' do |ss|
    ss.ios.dependency 'SuperAppKit/Kulibin'
    ss.ios.dependency 'SuperAppKit/Nestor'
    ss.resources = 'Milligan.bundle'
    ss.vendored_frameworks = 'Milligan.xcframework'
  end
  
  s.subspec 'Nestor' do |ss|
    ss.libraries = 'c++'
    ss.resources = 'Nestor.bundle'
    ss.vendored_frameworks = 'Nestor.xcframework'
  end
  
  s.subspec 'Orwell' do |ss|
    ss.ios.dependency 'SuperAppKit/APILayer'
    ss.ios.dependency 'SuperAppKit/Kulibin'
    ss.ios.dependency 'SuperAppKit/KulibinNetworking'
    ss.ios.dependency 'SuperAppKit/KulibinPersistency'
    ss.ios.dependency 'SuperAppKit/Nestor'
    ss.ios.dependency 'SuperAppKit/ValetteKit'
    ss.resources = 'Orwell.bundle'
    ss.vendored_frameworks = 'Orwell.xcframework'
  end
  
  s.subspec 'SAKLocalShared' do |ss|
    ss.ios.dependency 'SuperAppKit/Kulibin'
    ss.ios.dependency 'SuperAppKit/ValetteKit'
    ss.ios.dependency 'SuperAppKit/Warhol'
    ss.ios.dependency 'SuperAppKit/Malevich'
    ss.resources = 'SAKLocalShared.bundle'
    ss.vendored_frameworks = 'SAKLocalShared.xcframework'
  end
  
  s.subspec 'Susanin' do |ss|
    ss.ios.framework = 'UIKit'
    ss.resources = 'Susanin.bundle'
    ss.vendored_frameworks = 'Susanin.xcframework'
  end
  
  s.subspec 'ValetteKit' do |ss|
    ss.ios.framework = 'UIKit'
    ss.ios.dependency 'SuperAppKit/Malevich'
    ss.resources = 'ValetteKit.bundle'
    ss.vendored_frameworks = 'ValetteKit.xcframework'
  end
  
  s.subspec 'VKAuth' do |ss|
    ss.ios.dependency 'SuperAppKit/Kulibin'
    ss.ios.dependency 'SuperAppKit/KulibinNetworking'
    ss.ios.dependency 'SuperAppKit/Nestor'
    ss.ios.dependency 'SuperAppKit/APILayer'
    ss.ios.dependency 'SuperAppKit/BrowserBridge'
    ss.ios.dependency 'SuperAppKit/Orwell'
    ss.ios.dependency 'SuperAppKit/ValetteKit'
    ss.ios.dependency 'SuperAppKit/Warhol'
    ss.ios.dependency 'SuperAppKit/Milligan'
    ss.ios.dependency 'SuperAppKit/VKAccessibilityIdentifier'
    ss.resources = 'VKAuth.bundle'
    ss.vendored_frameworks = 'VKAuth.xcframework'
  end
  
  s.subspec 'VKSVGImage' do |ss|
    ss.resources = 'VKSVGImage.bundle'
    ss.vendored_frameworks = 'VKSVGImage.xcframework'
  end
  
  s.subspec 'Warhol' do |ss|
    ss.ios.dependency 'SuperAppKit/Kulibin'
    ss.ios.dependency 'SuperAppKit/KulibinNetworking'
    ss.ios.dependency 'SuperAppKit/KulibinPersistency'
    ss.ios.dependency 'SuperAppKit/Nestor'
    ss.resources = 'Warhol.bundle'
    ss.vendored_frameworks = 'Warhol.xcframework'
  end

  s.subspec 'VKAccessibilityIdentifier' do |ss|
    ss.resources = 'VKAccessibilityIdentifier.bundle'
    ss.vendored_frameworks = 'VKAccessibilityIdentifier.xcframework'
  end

  flags = { 'OTHER_LDFLAGS' => '-ObjC -all_load' }
  s.pod_target_xcconfig  = flags
  s.user_target_xcconfig = flags

  s.resources = 'SuperAppKit.bundle'
  s.vendored_frameworks = 'SuperAppKit.xcframework'
  s.source = {
    :http => 'https://artifactory-external.vkpartner.ru/artifactory/superappkit/0.79.8330967/SuperAppKit-0.79.8330967.tar.gz'
  }
end
