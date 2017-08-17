//
//  PhotoDrawBoard.swift
//  PhotoPicker
//
//  画板，包括绘制颜色菜单
//  Created by liangqi on 2017/8/16.
//  Copyright © 2017年 dailyios. All rights reserved.
//

import UIKit

class PhotoDrawBoard: UIView {
    
    var canvas: PhotoDrawView?;
    var colorBtns = [ColorButtonModel]();
    
    let bottomMenuHeight: CGFloat = 64
    
    // 画笔颜色，可自定义
    var colors = ["#ffffff", "#454545", "#ff6600" , "#ff3399" , "#00cc33" ,"#33ccff", "#B23AEE"];
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    func setupView() {
        self.canvas = PhotoDrawView.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height - bottomMenuHeight))
        self.addSubview(self.canvas!)
        self.bottomColorMenu()
    }
    
    func bottomColorMenu(){
        let btnColorWidth: CGFloat = 22
        let btnColorHeight: CGFloat = 22
        let marginleft: CGFloat = 15
        let y = self.bounds.height - btnColorHeight - 21;
        
        for (index, item) in colors.enumerated() {
            let x = (btnColorWidth + marginleft) * CGFloat(index) + marginleft
            let button = UIButton(frame: CGRect.init(x: x, y: y, width: btnColorWidth, height: btnColorHeight))
            let buttonColor = UIColor.hexColor(item)
            
            let layer = CALayer()
            layer.frame = button.bounds
            layer.backgroundColor = buttonColor!.cgColor
            layer.cornerRadius = btnColorWidth * 0.5
            layer.borderWidth = 1
            layer.borderColor = UIColor.hexColor("#eeeeee")!.cgColor
            button.layer.addSublayer(layer)
            button.addTarget(self, action: #selector(colorSelected(btn:)), for: .touchUpInside)
            button.tag = index
            
            self.colorBtns.append(ColorButtonModel(color: buttonColor!, button: button))
            self.addSubview(button)
        }
        
        // undo 操作按钮
        let btnUndoWith: CGFloat = 50
        let btnUndoHeight: CGFloat = 30
        let btnUndoMarginRight: CGFloat = 20;
        let btnY = self.bounds.height - bottomMenuHeight + (bottomMenuHeight - btnUndoHeight) * 0.5
        let btnX = self.bounds.width - btnUndoMarginRight - btnUndoWith
        let btnUndo = UIButton.init(frame: CGRect.init(x: btnX, y: btnY, width: btnUndoWith, height: btnUndoHeight))
        btnUndo.setTitle("撤销", for: .normal)
        btnUndo.setTitleColor(UIColor.white, for: .normal)
        btnUndo.addTarget(self, action: #selector(undo), for: .touchUpInside)
        self.addSubview(btnUndo)
    }
    
    func undo() {
        _ = self.canvas?.undo()
    }
    
    func colorSelected(btn: UIButton) {
        if !btn.isSelected {
            for model in colorBtns {
                if model.button.isSelected {
                    model.button.isSelected = false
                    model.button.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                }
            }
            
            btn.isSelected = true
            let model = self.colorBtns[btn.tag]
            // 当前按钮放大选中效果
            let scaleAnimation = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 6, options: .curveEaseIn, animations: {
                btn.transform = scaleAnimation
            }, completion: nil)
            
            // 设置画笔颜色
            self.canvas?.lineColor = model.color
        }
    }
    

}
