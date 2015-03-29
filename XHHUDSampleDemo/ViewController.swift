//
//  ViewController.swift
//  XHHUDSampleDemo
//
//  Created by Sunny on 15/3/29.
//  Copyright (c) 2015年 Sunny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let HUD = XHHUD()
    
    @IBAction func start(sender: AnyObject) {
        HUD.show(view)
    }

    @IBAction func end(sender: AnyObject) {
        HUD.hide()
    }
}

