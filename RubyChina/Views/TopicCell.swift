//
//  TopicCell.swift
//  RubyChina
//
//  Created by Jianqiu Xiao on 5/22/15.
//  Copyright (c) 2015 Jianqiu Xiao. All rights reserved.
//

import SwiftyJSON
import UIKit

class TopicCell: UITableViewCell {

    var topic: JSON = [:]
    var label : UILabel!


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        accessoryType = .disclosureIndicator

        textLabel?.numberOfLines = 4

        detailTextLabel?.font = .preferredFont(forTextStyle: .subheadline)
        detailTextLabel?.textColor = .lightGray
        
        //创建label1
        let screenW = UIScreen.main.applicationFrame.size.width;
        let rect:CGRect = CGRect(x: screenW - 40, y: 5, width: 40, height: 20)
        label = UILabel.init(frame: rect)
        //设置背景色
        label.text = "热门"
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.orange
        //设置字体
        label.font = UIFont.systemFont(ofSize: 15)//正常字体
        //设置字体颜色
        label.textColor = UIColor.white
        self.contentView.addSubview(label)
       
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        textLabel?.frame.origin.y = 11.5
        textLabel?.text = topic["title"].string
        textLabel?.frame.size.height = textLabel!.textRect(forBounds: textLabel!.frame, limitedToNumberOfLines: 3).height

        detailTextLabel?.frame.origin.y = 11.5 + textLabel!.frame.height + 5
        detailTextLabel?.text = "[\(topic["node_name"])] · \(topic["user"]["login"]) · \(Helper.timeAgoSinceNow(topic["replied_at"].string ?? topic["created_at"].string))\(topic["replies_count"].intValue > 0 ? " · \(topic["replies_count"]) ↵" : "")"
    }
}
