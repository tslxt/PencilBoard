//
//  CircleBrush.swift
//  TestPencilBoard
//
//  Created by LxT on 2018/8/3.
//  Copyright © 2018年 LxT. All rights reserved.
//

import Foundation
import UIKit

public class CircleBrush: BaseBrush {
    
    override func supportedContinuousDrawing() -> Bool {
        return false
    }
    
    override func drawInContext(context: CGContext) {
        
        context.setStrokeColor(strokeColor)
        
        context.addEllipse(in: CGRect(x: min(beginPoint.x, endPoint.x), y: min(beginPoint.y, endPoint.y), width: abs(endPoint.x - beginPoint.x), height: abs(endPoint.y - beginPoint.y)))
        context.strokePath()
    }
    
}
