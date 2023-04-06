//
//  WMarcetingService.swift
//  WidgetX
//
//  Created by Илья on 22.03.2023.
//

import Foundation
import AppsFlyerLib

class WMarketingService: NSObject {
    
    private var model: MarcetingModel = MarcetingModel()
    private var completion: CommandWith<MarcetingModel>?
    
    public func configurate(completion: CommandWith<MarcetingModel>) {
        self.completion = completion
        let appFlayerConfig = MarketingConfig.parseConfig()
        AppsFlyerLib.shared().appsFlyerDevKey = appFlayerConfig.appFlayerId
        AppsFlyerLib.shared().appleAppID = appFlayerConfig.appleAppId
        AppsFlyerLib.shared().delegate = self
    }
    
    public func start() {
        AppsFlyerLib.shared().start(completionHandler: { (dictionary, error) in
                    if (error != nil){
                        self.model.error = error
                        return
                    } else {
                        print(dictionary ?? "")
                        return
                    }
                })
    }
}

extension WMarketingService: AppsFlyerLibDelegate {
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        self.model.conversionInfo = conversionInfo
        self.model.uuid = AppsFlyerLib.shared().getAppsFlyerUID()
        self.completion!.perform(with: self.model)
    }
    
    func onConversionDataFail(_ error: Error) {
        self.model.error = error
        self.completion!.perform(with: self.model)
    }
}
