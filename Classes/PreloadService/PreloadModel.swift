//
//  PreloadModel.swift
//  WidgetX
//
//  Created by Илья on 24.03.2023.
//

import Foundation

public struct PreloadModel {
    public var idfaModel: IDFAModel!
    public var marketingModel: MarcetingModel!
    public var wConfig: WConfig!
    
    public func errors() -> [Error] {
        var errors: [Error] = []
        if idfaModel.error != nil { errors.append(idfaModel.error) }
        if marketingModel.error != nil { errors.append(marketingModel.error) }
        if wConfig.error != nil { errors.append(wConfig.error) }
        return errors
    }
}
