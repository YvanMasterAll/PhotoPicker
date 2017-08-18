//
//  PhotoDrawView.swift
//  PhotoPicker
//
//  画板，用于绘制各种自定义线条
//
//  Created by liangqi on 2017/8/15.
//  Copyright © 2017年 dailyios. All rights reserved.
//

import UIKit
//import QuartzCore

class PhotoDrawView: UIView {
    
    var lines = [PhotoLine]()
    
    // 线条宽度
    var lineWith: CGFloat = 5
    
    // 当前线条颜色
    var lineColor: UIColor = UIColor.green
    
    private var previousPoint: CGPoint?
    private var previousPreviousPoint: CGPoint?
    private var currentPoint: CGPoint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 禁止多点触控
        self.isMultipleTouchEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let point = touch?.location(in: self) {
            let path = PhotoLine(color: self.lineColor)
            path.move(to: point)
            self.lines.append(path)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first;
        let previousPoint = touch?.previousLocation(in: self)
        let currentPoint = touch?.location(in: self)
        if currentPoint != nil && previousPoint != nil {
            let midB = midPoint(pointOne: currentPoint!, pointTwo: previousPoint!);
            self.lines[self.lines.count - 1].addQuadCurve(to: midB, controlPoint: previousPoint!)
            setNeedsDisplay()
        }
    }
    
    private func midPoint(pointOne: CGPoint, pointTwo: CGPoint) -> CGPoint{
        return CGPoint(x: (pointOne.x + pointTwo.x) * 0.5, y: (pointOne.y + pointTwo.y) * 0.5)
    }
    
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.clear(rect)
        
        for line in self.lines {
            line.color.setStroke()
            line.lineWidth = self.lineWith
            line.lineCapStyle = .round
            line.lineJoinStyle = .round
            line.stroke()
        }
    }
    
    // 撤销返回前一步
    func undo() -> Bool {
        if self.lines.isEmpty {
            return false
        }
        _ = self.lines.removeLast()
        setNeedsDisplay()
        return true
    }
    
    // 清除所有操作
    func clear() {
        self.lines.removeAll()
        setNeedsDisplay()
    }
    
}
