//
//  NewsViewController.swift
//  YahooNewsRSSReader
//
//  Created by 水谷純也 on 2020/06/24.
//  Copyright © 2020 水谷純也. All rights reserved.
//

import UIKit
import SDWebImage
import XLPagerTabStrip

class NewsViewController: UITableViewController,IndicatorInfoProvider {
        
    private enum CellInfo{
        case topArticleCell
        case articleCell
        var nibName:String{
            switch self {
            case .topArticleCell:
                return "TopArticleCell"
            default:
                return "ArticleCell"
            }
        }
        var cellId:String{
            switch self {
            case .topArticleCell:
                return "TopArticleCell"
            default:
                return "ArticleCell"
            }
        }
    }
    
    private var itemInfo=IndicatorInfo(title: "タブ名")
    private var newsType:NewsType = .main
    private var items:[Item]=[]{
        didSet{
            tableView.reloadData()
        }
    }
    
    init(newsType:NewsType,style:UITableView.Style,itemInfo:IndicatorInfo){
        self.newsType=newsType
        self.itemInfo=itemInfo
        super.init(style: style)
    }
    
    required init?(coder aDeoder: NSCoder) {
        super.init(coder: aDeoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight=UITableView.automaticDimension
        tableView.estimatedRowHeight=600
        tableView.register(UINib(nibName: CellInfo.articleCell.nibName, bundle: nil), forCellReuseIdentifier: CellInfo.articleCell.cellId)
        tableView.register(UINib(nibName: CellInfo.topArticleCell.nibName, bundle: nil), forCellReuseIdentifier: CellInfo.topArticleCell.cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        RssClient.fetchItems(urlString: self.newsType.urlStr, completion: {(response) in
            switch response{
            case .success(let items):
                DispatchQueue.main.async(){()->Void in
                    self.items=items
                }
            case .failure(let err):
                print("記事の取得に失敗しました：reason(\(err))")
            }
        })
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // トップ記事用のセルを生成します。
        func configureTopArticleCell() -> TopArticleCell {
            let topArticleCell = tableView.dequeueReusableCell(withIdentifier: CellInfo.topArticleCell.cellId, for: indexPath) as! TopArticleCell
            topArticleCell.titleLabel.text = items.first?.title
            topArticleCell.pubDateLabel.text = items.first?.pubDate
            let link = items.first?.link ?? ""
            RssClient.fetchThumnImgUrl(urlStr: link, completion: { response in
                switch response {
                case .success(let url):
                     // TODO: 画像のロードが遅すぎる。キャッシュに画像持たせるように修正したい。
                    topArticleCell.articleImage.sd_setImage(with: url, completed: nil)
                case .failure(let err):
                    print("HTMLの取得に失敗しました: reason(\(err))")
                    topArticleCell.articleImage.image = UIImage()
                }
            })
            return topArticleCell
        }
        
        // 記事表示用のセルを生成します。
        func configureArticleCell() -> ArticleCell {
            let articleCell = tableView.dequeueReusableCell(withIdentifier: CellInfo.articleCell.cellId, for: indexPath) as! ArticleCell
            
            articleCell.titleLabel.text = items[indexPath.row].title
            articleCell.pubDateLabel.text = items[indexPath.row].pubDate
            
            let link = items[indexPath.row].link
            RssClient.fetchThumnImgUrl(urlStr: link, completion: { response in
                switch response {
                case .success(let url):
                     // TODO: 画像のロードが遅すぎる。キャッシュに画像持たせるように修正したい。
                    articleCell.articleImage.sd_setImage(with: url, completed: nil)
                case .failure(let err):
                    print("HTMLの取得に失敗しました: reason(\(err))")
                    articleCell.articleImage.image = UIImage()
                }
            })
            return articleCell
        }
        
        // トップ記事のセルかどうか
        var isTopArticleCell: Bool {
            return indexPath.row == 0
        }
        
        guard isTopArticleCell else {
            return configureArticleCell()
        }
        return configureTopArticleCell()
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = items[indexPath.row].link
        let vc = DetailWebViewController(urlStr: link)
        //self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // トップ記事のセルかどうか
        var isTopArticleCell: Bool {
            return indexPath.row == 0
        }
        return isTopArticleCell ? 165 : 50
    }
    
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
}

extension UIImage {
    public convenience init(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)!
            return
        } catch let err {
            print("UIImageの初期化に失敗しました: reason(\(err))")
        }
        self.init()
    }
}
