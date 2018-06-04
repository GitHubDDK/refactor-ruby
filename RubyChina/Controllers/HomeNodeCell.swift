//
//  HomeNodeCell.swift
//  RubyChina
//
//  Created by 沈玉丽(YuLi Shen)-顺丰科技 on 2018/6/4.
//  Copyright © 2018年 Jianqiu Xiao. All rights reserved.
//

import UIKit

class HomeNodeCell: UICollectionViewCell {
    let width = UIScreen.main.bounds.size.width//获取屏幕宽
    
    var titleLabel:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initView() {
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (width - 50)/4, height: 40))
        titleLabel?.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1.0)
        titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        titleLabel?.layer.cornerRadius = 4
        titleLabel?.layer.borderWidth = 0.5
        titleLabel?.layer.borderColor = UIColor.lightGray.cgColor
        titleLabel?.textAlignment = NSTextAlignment.center
        titleLabel?.layoutMargins = UIEdgeInsets(top:0, left:0, bottom:0, right:0)
        self .addSubview(titleLabel!)
    }
    
}
