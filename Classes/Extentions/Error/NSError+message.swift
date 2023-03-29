//
//  NSError+message.swift
//  WidgetX
//
//  Created by Илья on 24.03.2023.
//

import Foundation

extension NSError {
    public class func errorWith(message: String) -> Error {
        let userInfo: [String : Any] = ["NSLocalizedDescriptionKey" :  message]
        return NSError(domain: "customDomain", code: 0, userInfo: userInfo)
    }
}
