//
//  API.swift
//  ps
//
//  Created by chen on 2024/11/17.
//

import Foundation
import Moya
import CryptoSwift


enum API {
    case newDaily(key: String)
}

extension API: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://v.juhe.cn")!
    }
    
    var path: String {
        switch self {
        case .newDaily:
            return "/toutiao/index"
        }
    }
    
    var method: Moya.Method {
        .post
    }
    
    var task: Moya.Task {
        switch self {
        case .newDaily(let key):
            let paramenters: [String: Any] = [
                "key": key
            ]
            return paramenters.requestParameters
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
    
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
}

private extension Dictionary where Key == String, Value == Any  {

    static func += <K, V> (left: inout [K:V], right: [K:V]) {
        for (k, v) in right {
            left[k] = v
        }
    }

//    var requestParameters: Task {
//
//        var signInInfo: SignInfoModel?
//        
//        if let s = LocalInfo.shared.signInfo {
//            signInInfo = s
//        } else if let s = LocalInfo.shared.temporarilySignInfo {
//            signInInfo = s
//        } else {
//            signInInfo = nil
//        }
//        
//        var tempPara: [String: Any] = [
//            "accid": signInInfo?.accid ?? "",
//            "token": signInInfo?.token ?? "",
//            "_timestamp": Int(Date().timeIntervalSince1970)
//        ]
//
//        tempPara += self
//
//        let s = tempPara.signature
//
//        tempPara["_sign"] = s
//
//        return .requestParameters(parameters: tempPara, encoding: JSONEncoding.default)
//    }
    
    var requestParameters: Task {

        var tempPara: [String: Any] = [
            "accid": LocalInfo.shared.signInfo?.accid ?? "",
            "token": LocalInfo.shared.signInfo?.token ?? "",
            "_timestamp": Date().timeIntervalSince1970.int
        ]

        tempPara += self

        let s = tempPara.signature

        tempPara["_signature"] = s

        return .requestParameters(parameters: tempPara, encoding: JSONEncoding.default)
    }

    func requestParameters(signInInfo: SignInfoModel?) -> Task {

        var tempPara: [String: Any] = [
            "accid": signInInfo?.accid ?? "",
            "token": signInInfo?.token ?? "",
            "_timestamp": Date().timeIntervalSince1970.int
        ]

        tempPara += self

        let s = tempPara.signature

        tempPara["_signature"] = s

        return .requestParameters(parameters: tempPara, encoding: JSONEncoding.default)
    }

    var signature: String {

        let s = self.queryString

        let result = "TEST-APP" + ((Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "") + s

        return result.md5()
    }

    var queryString: String {
        var outputArray: [String] = []
        for (key,value) in self {
            outputArray.append("\(key)=\(value)&")
        }
        outputArray.sort(by: <)
        let output = outputArray.reduce("", +)

        return String(output.dropLast())
    }
}

