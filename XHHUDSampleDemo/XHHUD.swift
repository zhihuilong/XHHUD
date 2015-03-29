//
//  XHHUD.swift
//  XHHUD
//
//  Created by Sunny on 15/3/28.
//  Copyright (c) 2015年 Sunny. All rights reserved.
//

import UIKit

private let HUDWidth:CGFloat  = 40
private let HUDRadius:CGFloat = 3.5
private let HUDTag            = 10010

extension UIColor {
    class func kColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1)
    }
    class func aColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor{
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
}

class XHHUD: UIView {
    
    private(set) var animating = false
    
    override init() {
        super.init()
        self.bounds = CGRect(origin: CGPointZero, size: CGSize(width: HUDWidth , height: HUDWidth * 2.0 / sqrt(3)))
        self.backgroundColor = UIColor.clearColor()
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.bounds = CGRect(origin: CGPointZero, size: CGSize(width: HUDWidth , height: HUDWidth * 2.0 / sqrt(3)))
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        drawCircle(CGPointMake(rect.width / 2, HUDRadius), color: UIColor.kColor(246, green: 173, blue: 11))
        drawCircle(CGPointMake(rect.width - HUDRadius, rect.height / 4 + HUDRadius/2), color: UIColor.kColor(45, green: 136, blue: 254))
        drawCircle(CGPointMake(rect.width - HUDRadius, rect.height / 4 * 3 - HUDRadius/2), color: UIColor.kColor(44 , green: 155 , blue: 118 ))
        
        drawCircle(CGPointMake(rect.width / 2, rect.height - HUDRadius), color: UIColor.kColor(239 , green: 0 , blue: 102 ))
        drawCircle(CGPointMake(HUDRadius, rect.height / 4 * 3 - HUDRadius/2), color: UIColor.kColor(240 , green: 64 , blue: 11))
        drawCircle(CGPointMake(HUDRadius, rect.height / 4 + HUDRadius/2), color: UIColor.kColor(44 , green: 166 , blue: 10))
    }
    
    private func drawCircle(point:CGPoint,color:UIColor) {
        let path = UIBezierPath()
        path.addArcWithCenter(point , radius: HUDRadius, startAngle: 0, endAngle: 360, clockwise: true)
        color.set()
        path.fill()
    }
    
    //show HUD
    func show(view:UIView) {
        removeFromSuperview()
        view.addSubview(self)
        if animating == true {
            return
        }
        animating = true
        center = superview!.center
        bounds = CGRect(origin: CGPointZero, size: CGSize(width: HUDWidth , height: HUDWidth * 2.0 / sqrt(3)))
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = M_PI * 2
        rotationAnimation.duration = 1
        rotationAnimation.repeatCount = MAXFLOAT
        layer.addAnimation(rotationAnimation, forKey: "rotationAnimation")
    }
    
    //hide HUD
    func hide() {
        if animating == false {
            return
        }
        animating = false
        layer.removeAnimationForKey("rotationAnimation")
        UIView.animateWithDuration(0.4, animations: {
            self.bounds = CGRectZero
        })
    }
}
