//
//  PencilBoard.swift
//  TestPencilBoard
//
//  Created by LxT on 2018/7/27.
//  Copyright © 2018年 LxT. All rights reserved.
//

import UIKit

public enum DrawingState {
    case Began, Moved, Ended, ReDraw
}

public protocol PencilBoardDelegate {
    func BoardStateChange(state: DrawingState)
}

public class PencilBoard: UIImageView {
    
    public var delegate:PencilBoardDelegate! = nil
    
    public var brush:BaseBrush?
    
    public var defaulWidth:CGFloat = 2.0
    
    public var forceSensitivity:CGFloat = 2.0
    
    public var defaulColor:CGColor = UIColor.black.cgColor
    
    
    private var realImage: UIImage?
    
    private var currentState:DrawingState! = nil
    
    private var drawingState:DrawingState {
        get {
            return currentState
        }
        set {
            currentState = newValue
            delegate.BoardStateChange(state: currentState)
        }
    }
    
    private var undoImages = [UIImage]()


    public func drawingWithTouch(touch: UITouch) {
        
        if let brush = self.brush {
            
            if brush is Brush && touch.force > 0 {
                (brush as! Brush).forceSensitivity = self.forceSensitivity
                brush.strokeWidth = touch.force * (brush as! Brush).forceSensitivity
            } else {
                brush.strokeWidth = defaulWidth
            }
            
            self.drawGraphics(brush: brush)
        }
        
    }
    
    public func drawingWithTouches(touches: [UITouch]) {

        UIGraphicsBeginImageContext(self.bounds.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        UIColor.clear.setFill()
        UIRectFill(self.bounds)
        
        if let realImage = self.realImage {
            realImage.draw(in: self.bounds)
        }
        
        for touch in touches {
            self.brush?.lastPoint = touch.previousLocation(in: self)
            self.brush?.endPoint = touch.location(in: self)
            if self.brush is Brush && touch.force > 0 {
                (self.brush as! Brush).forceSensitivity = self.forceSensitivity
                self.brush?.strokeWidth = touch.force * (self.brush as! Brush).forceSensitivity
            }else {
                self.brush?.strokeWidth = defaulWidth
            }
            self.brush?.drawInContext(context: context!)
        }
        
        image = UIGraphicsGetImageFromCurrentImageContext()
        
        let previewImage = UIGraphicsGetImageFromCurrentImageContext()
        if self.drawingState == DrawingState.Ended || (self.brush?.supportedContinuousDrawing())! || (self.brush?.isReDraw)!{
            self.realImage = previewImage
        }
        
        UIGraphicsEndImageContext()
        
        self.image = previewImage
        
    }
    
    
    public func drawGraphics(brush: BaseBrush) {
        
        UIGraphicsBeginImageContext(self.bounds.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        UIColor.clear.setFill()
        UIRectFill(self.bounds)
        
        if let realImage = self.realImage {
            realImage.draw(in: self.bounds)
        }
        
        brush.drawInContext(context: context!)
        
        image = UIGraphicsGetImageFromCurrentImageContext()
        
        let previewImage = UIGraphicsGetImageFromCurrentImageContext()
        if self.drawingState == DrawingState.Ended || brush.supportedContinuousDrawing() || brush.isReDraw{
            self.realImage = previewImage
        }
        
        UIGraphicsEndImageContext()
        
        if self.drawingState == DrawingState.Began {
            if self.image != nil {
                self.undoImages.append(self.image!)
            }
        }
        
        self.image = previewImage
    }
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let brush = self.brush {
            
            if let touch = touches.first {
                
                brush.lastPoint = nil
                
                brush.beginPoint = (touches.first?.location(in: self))!
                brush.endPoint = brush.beginPoint
                
                self.drawingState = DrawingState.Began
                
                self.drawingWithTouch(touch: touch)
                
            }
            
           
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let brush = self.brush {
            
            if let touch = touches.first {
                self.drawingState = DrawingState.Moved
                
                if let coalesced = event?.coalescedTouches(for: touches.first!) {
                    self.drawingWithTouches(touches: coalesced)
                } else {
                    brush.lastPoint = touch.previousLocation(in: self)
                    brush.endPoint = touch.location(in: self)
                    self.drawingWithTouch(touch: touch)
                }
            }
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let brush = self.brush {
            if let touch = touches.first {
                brush.endPoint = touch.location(in: self)
                self.drawingState = DrawingState.Ended
                self.drawingWithTouch(touch: touch)
            }
        }
    }
    
    private var canUndo: Bool {
        get {
            return self.undoImages.count > 0
        }
    }
    
    public func undo() {
        if self.undoImages.count > 0 {
            let lastImage = self.undoImages.removeLast()
            self.image = lastImage
        }
        
        self.realImage = self.image
    }
    
    public func clear() {
        self.image = nil
        self.undoImages = []
        self.realImage = self.image
    }
}
