//
//  IDFAService.swift
//  WidgetX
//
//  Created by Илья on 23.03.2023.
//

import Foundation

import AppTrackingTransparency
import AdSupport
import FBSDKCoreKit

class IDFAService: NSObject {
    
    private var idfaModel: IDFAModel = IDFAModel()
    
    public func requestTrackingAuthorization(completion: CommandWith<IDFAModel>) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { [weak self] status in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch status {
                    case .authorized:
                        self.idfaModel.idfa =  ASIdentifierManager.shared().advertisingIdentifier
                        Settings.shared.isAdvertiserIDCollectionEnabled = true
                        self.idfaModel.error = nil
                        completion.perform(with: self.idfaModel)
                    case .denied, .restricted:
                        self.idfaModel.error = NSError.errorWith(message: "Пользователь запретил доступ к IDFA.")
                        completion.perform(with: self.idfaModel)
                    case .notDetermined:
                        self.idfaModel.error = NSError.errorWith(message: "Пользователь ещё не получил запрос на авторизацию для доступа к IDFA.")
                        completion.perform(with: self.idfaModel)
                    @unknown default:
                        break
                    }
                }
            })
        })
    }
}
