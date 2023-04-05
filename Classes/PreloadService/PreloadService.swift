//
//  PreloadService.swift
//  WidgetX
//
//  Created by Илья on 23.03.2023.
//

import Foundation
import UIKit

open class PreloadService: NSObject {
    private var remoteConfigService: WRemoteConfigService
    private var marketingService: WMarketingService
    private var idfaService: IDFAService
    
    private var isLoadedRemoteConfig: Bool = false
    private var isLoadedMarketingConfig: Bool = false
    private var isLoadedIDFA: Bool = false
    
    private let completionAtion: CommandWith<Bool>
    
    public var preloadModel: PreloadModel = PreloadModel()
    
    public init(completionAction: CommandWith<Bool>) {
        self.remoteConfigService = WRemoteConfigService()
        self.marketingService = WMarketingService()
        self.idfaService = IDFAService()
        self.completionAtion = completionAction
    }
    
    public func loadData() {
        self.remoteConfigService.fetchAndActivate(completion: CommandWith.init(action: { wConfig in
            self.isLoadedRemoteConfig = true
            self.preloadModel.wConfig = wConfig
            guard self.isLoaded() else { return }
            self.completionAtion.perform(with: self.isLoaded())
        }))
        self.marketingService.configurate(completion: CommandWith.init(action: { marketingModel in
            self.isLoadedMarketingConfig = true
            self.preloadModel.marketingModel = marketingModel
            guard self.isLoaded() else { return }
            self.completionAtion.perform(with: self.isLoaded())
        }))
        self.marketingService.start()
        self.idfaService.requestTrackingAuthorization(completion: CommandWith.init(action: { idfaModel in
            self.isLoadedIDFA = true
            self.preloadModel.idfaModel = idfaModel
            guard self.isLoaded() else { return }
            self.completionAtion.perform(with: self.isLoaded())
        }))
    }
    
    private func isLoaded() -> Bool {
        let loaded = (self.isLoadedRemoteConfig && self.isLoadedMarketingConfig && self.isLoadedIDFA)
        return loaded
    }
}
