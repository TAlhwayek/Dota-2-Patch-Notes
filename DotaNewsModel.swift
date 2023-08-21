//
//  DotaNewsModel.swift
//  Dota 2 Patch Notes
//
//  Created by Tony Alhwayek on 8/21/23.
//

import Foundation

struct NewsItem: Decodable {
    let gid: String
    let title: String
    let url: String
    let contents: String
    let author: String
    let date: Int
    // Add other properties if needed
}

struct AppNewsResponse: Decodable {
    let appnews: AppNews
}

struct AppNews: Decodable {
    let appid: Int
    let newsitems: [NewsItem]
}
