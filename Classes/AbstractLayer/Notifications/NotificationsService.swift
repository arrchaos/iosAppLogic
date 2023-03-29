//
//  Notifications.swift
//  WidgetX
//
//  Created by Илья on 21.03.2023.
//

import OneSignal
import UIKit

public struct NotificationsService {
    
    public static func initializeNotificationService(options: [UIApplication.LaunchOptionsKey : Any]? = nil) {
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        
        OneSignal.initWithLaunchOptions(options)
        let config = NotificationsConfig.parseConfig()
        OneSignal.setAppId(config.appIdentifire)
        
        OneSignal.promptForPushNotifications(userResponse: { accepted in
          print("User accepted notifications: \(accepted)")
        })
    }
    
    public static func didReceiveNotificationExtensionRequest(request:UNNotificationRequest,
                                                      content:UNMutableNotificationContent,
                                                      contentHandler:@escaping ((UNNotificationContent) -> Void)) {
        OneSignal.didReceiveNotificationExtensionRequest(request, with:content, withContentHandler:contentHandler)
    }
    
    public static func serviceExtensionTimeWillExpireRequest(request:UNNotificationRequest,
                                                          content:UNMutableNotificationContent) {
        OneSignal.serviceExtensionTimeWillExpireRequest(request, with: content)
    }
}

public struct NotificationsConfig: Decodable {
    let appIdentifire: String
    
    private enum CodingKeys: String, CodingKey {
        case appIdentifire = "OneSignalApplicationIdentifare"
    }
    
    public static func parseConfig() -> NotificationsConfig {
        let url = Bundle.main.url(forResource: "OneServiceInfo", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try! decoder.decode(NotificationsConfig.self, from: data)
    }
}
