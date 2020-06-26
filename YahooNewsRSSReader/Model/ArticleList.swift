//
//  ArticleList.swift
//  YahooNewsRSSReader
//
//  Created by 水谷純也 on 2020/06/24.
//  Copyright © 2020 水谷純也. All rights reserved.
//

import Foundation

struct ArticleList: Codable {
    let status: String
    let feed:Feed
    let items:[Item]
}

struct Feed:Codable {
    let url: String
    let title: String
    let link: String
    let author: String
    let description: String
}

struct Item:Codable {
    let title:String
    let pubDate:String
    let link:String
    let guid:String
}


