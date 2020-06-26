//
//  ArticleCell.swift
//  YahooNewsRSSReader
//
//  Created by 水谷純也 on 2020/06/24.
//  Copyright © 2020 水谷純也. All rights reserved.
//

import UIKit
import AVFoundation

class ArticleCell: UITableViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pubDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func read(_ sender: UIButton) {
        if let text=self.titleLabel.text{
            let utterance=AVSpeechUtterance(string: text)
            utterance.voice=AVSpeechSynthesisVoice(language: "ja-JP")
            utterance.rate=0.5
            let synthesizer=AVSpeechSynthesizer()
            synthesizer.speak(utterance)
        }
        
    }
}
