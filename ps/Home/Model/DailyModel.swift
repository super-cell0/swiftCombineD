//
//  DailyModel.swift
//  ps
//
//  Created by chen on 2024/11/19.
//

import Foundation

struct Welcome: Codable {
    let reason: String
    let result: Result
    let errorCode: Int

    enum CodingKeys: String, CodingKey {
        case reason, result
        case errorCode = "error_code"
    }
}

struct Result: Codable {
    let stat: String
    let data: [DailyModel]
    let page: String
    let pageSize: String
}

struct DailyModel: Codable {
    let uniquekey: String
    let title: String
    let date: String
    let category: String
    let authorName: String
    let url: String
    let thumbnailPicS: String
    let thumbnailPicS02: String
    let thumbnailPicS03: String?
    let isContent: String

    enum CodingKeys: String, CodingKey {
        case uniquekey
        case title
        case date
        case category
        case authorName = "author_name"
        case url
        case thumbnailPicS = "thumbnail_pic_s"
        case thumbnailPicS02 = "thumbnail_pic_s02"
        case thumbnailPicS03 = "thumbnail_pic_s03"
        case isContent = "is_content"
    }
}
