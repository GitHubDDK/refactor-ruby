//
//  HotCell.swift
//  RubyChina
//
//  Created by 端德坤(DeKun Duan)-顺丰科技 on 2018/6/1.
//  Copyright © 2018年 Jianqiu Xiao. All rights reserved.
//

import UIKit

class HotCell: UICollectionViewCell {
    
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel.init(frame: self.bounds)
        self.addSubview(label)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
