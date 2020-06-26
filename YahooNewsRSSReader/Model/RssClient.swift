//
//  RssClient.swift
//  YahooNewsRSSReader
//
//  Created by 水谷純也 on 2020/06/24.
//  Copyright © 2020 水谷純也. All rights reserved.
//

import Foundation
import HTMLReader

class RssClient {

    static func fetchFeed(urlString:String,completion:@escaping (Result<Feed,Error>)->()){
        guard let url=URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task=URLSession.shared.dataTask(with: url,completionHandler: {data,response,error in
            if let error=error{
                completion(.failure(error))
                return
            }
            guard let data=data else{
                completion(.failure(NetworkError.unknown))
                return
            }
            let decoder=JSONDecoder()
            guard let articleList=try?decoder.decode(ArticleList.self, from: data) else{
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            completion(.success(articleList.feed))
        })
        task.resume()
    }
    
    static func fetchItems(urlString: String, completion: @escaping (Result<[Item], Error>) -> ()) {
        
         // URL型に変換できない文字列の場合は弾く
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.unknown))
                return
            }
            
            let decoder = JSONDecoder()
            guard let articleList = try?decoder.decode(ArticleList.self, from: data) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            completion(.success(articleList.items))
        })
        task.resume()
    }
    
    static func fetchThumnImgUrl(urlStr: String, completion: @escaping (Result<URL, Error>) -> ()) {
        // 入力したURLからHTMLのソースを取得する。
        guard let targetURL = URL(string: urlStr) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        do {
            // 入力したURLのページから、HTMLのソースを取得します。
            let sourceHTML = try String(contentsOf: targetURL, encoding: String.Encoding.utf8)
            
            let html = HTMLDocument(string: sourceHTML)
            // サムネイルの入ったエレメントを抜き出します。
            let htmlElement = html.firstNode(matchingSelector: "p[class^=\"tpcHeader_thumb_img\"]")
            // styleからサムネイルのurlを取得します。
            guard let style = htmlElement?.attributes["style"] else {
                completion(.failure(ApplicationError.unknown))
                return
            }
            // 無駄な文字列を削除して整形します。
            let imageUrlStr: String = {
                let startIndex = style.index(style.startIndex, offsetBy: 23)
                let endIndex = style.index(style.endIndex, offsetBy: -3)
                return String(style[startIndex..<endIndex])
            }()
            
            guard let imageUrl = URL(string: imageUrlStr) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            
            completion(.success(imageUrl))
        }
        catch {
            completion(.failure(error))
        }
    }

}

enum NetworkError:Error{
    case invalidURL
    case invalidResponse
    case unknown
}

enum ApplicationError:Error{
    case parseFailed
    case unknown
}
