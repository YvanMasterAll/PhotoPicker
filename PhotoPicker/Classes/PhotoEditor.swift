//
//  PhotoEditor.swift
//  PhotoPicker
//
//  Created by liangqi on 2017/8/17.
//  Copyright © 2017年 dailyios. All rights reserved.
//

import UIKit
import Photos

class PhotoEditor: UIView {

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
        // 添加图片
        if let img = self.editImage {
            let requestOptions = PHImageRequestOptions()
            requestOptions.resizeMode = .fast
            requestOptions.deliveryMode = .opportunistic
//            requestOptions.isSynchronous = false
            
            PhotoImageManager.sharedManager.getPhotoByMaxSize(asset: img, size: self.bounds.width, completion: { (image, info) in
                if let imageData = image {
                    self.renderBgImage(imageData)
                }
            });
        }
        
//        let canvas = PhotoDrawBoard(frame: self.bounds)
//        canvas.backgroundColor = UIColor.clear
//        self.addSubview(canvas)
    }
    
    // 计算图片大小，重排图片
    private func renderBgImage(image: UIImage){
//        let imageBg = UIImageView.init(frame: CGRect.init(x: 0, y: 64, width: self.bounds.width, height: self.bounds.height - 128))
        let realheight = self.height - 128 // 去掉上下菜单高度
        if image.size.height / image.size.width > 1  { // 竖图
            var width = image.size.width / (image.size.height / realheight)
            width = min(width, self.width)
            
        } else { // 横图
            
        }
        
        // 计算图片
        
        // imageBg.image = imageData
        // self.addSubview(imageBg)
    }

}
