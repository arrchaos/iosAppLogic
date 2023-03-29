//
//  MarketingConfig.swift
//  WidgetX
//
//  Created by Илья on 24.03.2023.
//

import Foundation


struct MarketingConfig: Decodable {
    
    let appleAppId: String
    let appFlayerId: String
    
    private enum CodingKeys: String, CodingKey {
        case appleAppId = "AppleAppId"
        case appFlayerId = "AppFlayerDevKey"
    }
    
    public static func parseConfig() -> MarketingConfig {
        let url = Bundle.main.url(forResource: "AppFlayerInfo", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try! decoder.decode(MarketingConfig.self, from: data)
    }
}
