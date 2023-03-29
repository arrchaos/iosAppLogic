//
//  WWebViewModel.swift
//  WidgetX
//
//  Created by Илья on 24.03.2023.
//

import Foundation

let urlKey = "urlKey"

open class WWebViewModel: ObservableObject {
    let baseURLStr: String
    let conversionInfo: [AnyHashable: Any]
    let uuid: String
    let idfa: UUID
    
    @Published open var loading: Bool = false
    
    public init(baseURLStr: String, conversionInfo: [AnyHashable: Any], uuid: String, idfa: UUID) {
        self.baseURLStr = baseURLStr
        self.conversionInfo = conversionInfo
        self.uuid = uuid
        self.idfa = idfa
    }
    
    open func endURL() -> URL {
        var endUrlString: String
        guard UserDefaults.standard.dictionary(forKey: urlKey) == nil else {
            endUrlString = UserDefaults.standard.string(forKey: urlKey)!
            return URL(string: endUrlString)!
        }
        
        endUrlString = String(format: "%@?", self.baseURLStr)
        
        let keys = conversionInfo.keys
        for key in keys {
            let keyStr:String = key as! String
            let valueStr: String = conversionInfo[key] as! String
            endUrlString = endUrlString.appending(String(format: "%@=%@&", keyStr.encodeUrl()!, valueStr.encodeUrl()!))
        }
        
        endUrlString = endUrlString.appending(String(format: "uuid=%@&", self.uuid))
        endUrlString = endUrlString.appending(String(format: "idfa=%@", self.idfa.uuidString))
        
        UserDefaults.standard.set(endUrlString, forKey: urlKey)
        
        return URL(string: endUrlString)!
//        /*For TEst Only*/return URL(string: "https://google.com?some=query")!
    }
}
