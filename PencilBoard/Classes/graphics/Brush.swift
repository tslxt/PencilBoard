//
//  Brush.swift
//  TestPencilBoard
//
//  Created by LxT on 2018/7/28.
//  Copyright © 2018年 LxT. All rights reserved.
//

import Foundation
import UIKit

public class Brush : BaseBrush {
    
    public var forceSensitivity: CGFloat = 4.0
    
    override func supportedContinuousDrawing() -> Bool {
        return true
    }
    
    override func drawInContext(context: CGContext) {
        context.setLineCap(lineCap)
        context.setStrokeColor(strokeColor)
        context.setLineWidth(strokeWidth)
        
        if let lastPoint = self.lastPoint {
            context.move(to: lastPoint)
            context.addLine(to: endPoint)
        } else {
            context.move(to: beginPoint)
            context.addLine(to: endPoint)
        }
        
        context.strokePath()
    }
}
