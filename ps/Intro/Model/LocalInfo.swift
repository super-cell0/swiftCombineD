//
//  LocalInfo.swift
//  ps
//
//  Created by chen on 2024/11/29.
//

import Foundation
import Combine


class LocalInfo {
    
    let temporarilySignInfoCVS = CurrentValueSubject<SignInfoModel?, Never>(nil)
    var temporarilySignInfo: SignInfoModel? {
        temporarilySignInfoCVS.value
    }
    
    let signInfoCVS = CurrentValueSubject<SignInfoModel?, Never>(UserDefaults.standard.object(SignInfoModel.self, with: "signInInfo"))
    var signInfo: SignInfoModel? {
        signInfoCVS.value
    }
    
    var isSignInfo: Bool {
        signInfo != nil
    }
    
    var isShowedPrimaryIntro: Bool {
        get {
            UserDefaults.standard.bool(forKey: "isShowedPrimaryIntro")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isShowedPrimaryIntro")
            UserDefaults.standard.synchronize()
        }
    }
    
    static let shared = LocalInfo()
    
    var subscriptions: [AnyCancellable] = []
    
    private init() {
        
        signInfoCVS
            .sink { model in
                UserDefaults.standard.set(object: model, forKey: "signInInfo")
                UserDefaults.standard.synchronize()
            }
            .store(in: &subscriptions)
        
    }

    
    func cleanUp() {
        signInfoCVS.send(nil)
    }
    
}
