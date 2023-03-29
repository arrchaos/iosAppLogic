//
//  WRemoteConfig.swift
//  WidgetX
//
//  Created by Илья on 22.03.2023.
//

import Foundation
import FirebaseCore
import FirebaseRemoteConfig
import FirebaseRemoteConfigSwift

open class WRemoteConfigService {
    private let remoteConfig: RemoteConfig = RemoteConfig.remoteConfig()
    private var wConfig: WConfig = WConfig()
    
    
    public class func configure() {
        FirebaseApp.configure()
    }
    
    public func fetchAndActivate(completion: CommandWith<WConfig>) {
        self.remoteConfig.fetchAndActivate { [weak self] status, error in
            guard let self = self else { return }
            guard error == nil else {
                self.wConfig.error = error
                completion.perform(with: self.wConfig)
                return
            }
            print("Remote config successfully fetched & activated!")
            do {
                self.wConfig = try self.remoteConfig.decoded()
                completion.perform(with: self.wConfig)
            } catch {
                self.wConfig.error = error
                completion.perform(with: self.wConfig)
                return
            }
        }
        
    }
}
