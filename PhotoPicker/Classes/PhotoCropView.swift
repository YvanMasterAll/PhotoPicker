//
//  PhotoCropView.swift
//  PhotoPicker
//
//  Created by liangqi on 2017/8/15.
//  Copyright © 2017年 dailyios. All rights reserved.
//

import UIKit
import Photos

class PhotoCropView: UIView {

    var editImage: PHAsset?
    var topbar: UIView?
    var bottom: UIView?
    
    init(image: PHAsset, frame: CGRect) {
        super.init(frame: frame)
        self.editImage = image
        self.setupView()
    }
    
    required  init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        let canvas = PhotoDrawBoard(frame: self.bounds)
        self.addSubview(canvas)
    }
}
