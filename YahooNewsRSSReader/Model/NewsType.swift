//
//  NewsType.swift
//  YahooNewsRSSReader
//
//  Created by 水谷純也 on 2020/06/24.
//  Copyright © 2020 水谷純也. All rights reserved.
//

import Foundation

enum NewsType: CaseIterable{
    case main
    case grobal
    case entertainment
    case informationTechnology
    case local
    case domestic
    case economics
    case sports
    case science
    
    var urlStr: String {
        switch self {
        case .main:
        return "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fnews.yahoo.co.jp%2Fpickup%2Frss.xml&api_key=hybg4dcph35nb1dukcxlctpevjn8hb2fvibpuhzd"
        case .grobal:
        return "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fnews.yahoo.co.jp%2Fpickup%2Fworld%2Frss.xml&api_key=hybg4dcph35nb1dukcxlctpevjn8hb2fvibpuhzd"
        case .entertainment:
        return "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fnews.yahoo.co.jp%2Fpickup%2Fentertainment%2Frss.xml&api_key=hybg4dcph35nb1dukcxlctpevjn8hb2fvibpuhzd"
        case .informationTechnology:
        return "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fnews.yahoo.co.jp%2Fpickup%2Fcomputer%2Frss.xml&api_key=hybg4dcph35nb1dukcxlctpevjn8hb2fvibpuhzd"
        case .local:
        return "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fnews.yahoo.co.jp%2Fpickup%2Flocal%2Frss.xml&api_key=hybg4dcph35nb1dukcxlctpevjn8hb2fvibpuhzd"
        case .domestic:
        return "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fnews.yahoo.co.jp%2Fpickup%2Fdomestic%2Frss.xml&api_key=hybg4dcph35nb1dukcxlctpevjn8hb2fvibpuhzd"
        case .economics:
        return "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fnews.yahoo.co.jp%2Fpickup%2Feconomy%2Frss.xml&api_key=hybg4dcph35nb1dukcxlctpevjn8hb2fvibpuhzd"
        case .sports:
        return "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fnews.yahoo.co.jp%2Fpickup%2Fsports%2Frss.xml&api_key=hybg4dcph35nb1dukcxlctpevjn8hb2fvibpuhzd"
        case .science:
        return "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fnews.yahoo.co.jp%2Fpickup%2Fscience%2Frss.xml&api_key=hybg4dcph35nb1dukcxlctpevjn8hb2fvibpuhzd"
        }
    }
    
    var itemInfo:String{
        switch self {
        case .main: return "主要"
        case .grobal: return "国際"
        case .entertainment: return "エンタメ"
        case .informationTechnology: return "IT"
        case .local: return "地域"
        case .domestic: return "国内"
        case .economics: return "経済"
        case .sports: return "スポーツ"
        case .science: return "科学"
        }
    }

}
