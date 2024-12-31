//
//  SignInfoModel.swift
//  ps
//
//  Created by chen on 2024/12/3.
//

import Foundation


struct SignInfoModel: Codable {
    let accid: String
    let token: String
    let account: String
    
    enum CodingKeys: String, CodingKey {
        case accid = "accid"
        case token = "token"
        case account
    }
}
