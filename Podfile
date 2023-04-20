# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'
inhibit_all_warnings!
use_frameworks!

target 'IOSAppLogicFramework' do
  # Comment the next line if you don't want to use dynamic frameworks
  
  pod 'FirebaseCore'
  pod 'FirebaseAnalytics'
  pod 'FirebaseCrashlytics'
  pod 'FirebaseRemoteConfig'
  pod 'FirebaseRemoteConfigSwift'
  
  pod 'OneSignalXCFramework'
  
  pod 'AppsFlyerFramework'
  
  pod 'FBSDKCoreKit', '= 16.0.0'
  
  pod 'TikTokOpenSDK', '= 5.0.14'

  # Pods for IOSAppLogicFramework

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      if target.name == 'OneSignalNotificationExtension'
        config.build_settings['CONFIGURATION_BUILD_DIR'] = '$PODS_CONFIGURATION_BUILD_DIR'
      end
    end
  end
end