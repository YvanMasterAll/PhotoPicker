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
                    let imageBg = UIImageView.init(frame: CGRect.init(x: 0, y: 64, width: self.bounds.width, height: self.bounds.height - 128))
                    debugPrint(imageData.size)
                    // imageBg.image = imageData
                    // self.addSubview(imageBg)
                }
            });
            
        }
//        let canvas = PhotoDrawBoard(frame: self.bounds)
//        canvas.backgroundColor = UIColor.clear
//        self.addSubview(canvas)
    }

}
