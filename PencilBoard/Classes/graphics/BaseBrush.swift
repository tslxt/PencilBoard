//
//  BaseBrush.swift
//  TestPencilBoard
//
//  Created by LxT on 2018/7/27.
//  Copyright © 2018年 LxT. All rights reserved.
//

import UIKit


protocol PaintBrush {
    
    func supportedContinuousDrawing() -> Bool
    
    func drawInContext(context: CGContext)
}

public class BaseBrush: PaintBrush {
  
    public var strokeWidth:CGFloat
    
    public var strokeColor:CGColor
    
    
    public var beginPoint:CGPoint!
    
    public var endPoint:CGPoint!
    
    public var lastPoint:CGPoint!
    
    public var lineCap:CGLineCap = CGLineCap.round
    
    public var isReDraw:Bool = false
    
    
    public init(strokeWidth: CGFloat, strokeColor: CGColor, beginPoint: CGPoint, endPoint:CGPoint, isReDraw:Bool = false) {
        self.strokeWidth = strokeWidth
        self.strokeColor = strokeColor
        
        self.beginPoint = beginPoint
        self.endPoint = endPoint
        
        self.isReDraw = isReDraw
    }
    
    public convenience init(strokeWidth: CGFloat, strokeColor: CGColor) {
        self.init(strokeWidth: strokeWidth, strokeColor: strokeColor, beginPoint: CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint(x: 0.0, y: 0.0))
    }
    
    func supportedContinuousDrawing() -> Bool {
        return false
    }
    
    func drawInContext(context: CGContext) {
        assert(false, "must implements in subclass.")
    }
    
    
    
}
