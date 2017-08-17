//
//  PhotoLine.swift
//  PhotoPicker
//
//  Created by liangqi on 2017/8/15.
//  Copyright © 2017年 dailyios. All rights reserved.
//

import UIKit

class PhotoLine: UIBezierPath {
    var color: UIColor
    
    init(color: UIColor) {
        self.color = color
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.color = UIColor.black
        super.init(coder: aDecoder)
    }
}
