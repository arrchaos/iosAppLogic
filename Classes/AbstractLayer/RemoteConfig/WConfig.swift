//
//  WConfig.swift
//  WidgetX
//
//  Created by Илья on 22.03.2023.
//

import Foundation

public struct WConfig: Codable {

    public var urlStr: String
    public var error: Error!
    
    init() {
        self.urlStr = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case urlStr = "castomization"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.urlStr = try container.decode(String.self, forKey: .urlStr)
    }
}
