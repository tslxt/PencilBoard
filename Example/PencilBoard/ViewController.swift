//
//  ViewController.swift
//  PencilBoard
//
//  Created by tslxt on 07/26/2018.
//  Copyright (c) 2018 tslxt. All rights reserved.
//

import UIKit

import PencilBoard


class ViewController: UIViewController {

    
    @IBOutlet weak var pencilBoard: PencilBoard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("test")
        
        pencilBoard.brush =  Brush(strokeWidth: pencilBoard.defaulWidth, strokeColor: UIColor.red.cgColor)
        
        
        
        
    }


}

