//
//  LineBrush.swift
//  TestPencilBoard
//
//  Created by LxT on 2018/7/27.
//  Copyright © 2018年 LxT. All rights reserved.
//

import Foundation
import UIKit

public class LineBrush: BaseBrush {
    
    override func supportedContinuousDrawing() -> Bool {
        return false
    }
    
    override func drawInContext(context: CGContext) {
        
        
        context.setLineCap(lineCap)
        context.setStrokeColor(strokeColor)
        context.setLineWidth(strokeWidth)
        
        context.move(to: beginPoint)
        context.addLine(to: endPoint)
        
        context.strokePath()
        
        
    }
    
    
}
