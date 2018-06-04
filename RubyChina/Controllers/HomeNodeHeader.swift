//
//  HomeNodeHeader.swift
//  RubyChina
//
//  Created by 沈玉丽(YuLi Shen)-顺丰科技 on 2018/6/4.
//  Copyright © 2018年 Jianqiu Xiao. All rights reserved.
//

import UIKit

class HomeNodeHeader: UICollectionReusableView {
    let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    var titleLabel:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        initView()
    }
    func initView(){
        titleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: SCREEN_WIDTH-10, height: 30))
        titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        self .addSubview(titleLabel!)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
}
