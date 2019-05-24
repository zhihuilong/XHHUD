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
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.bounds = CGRect(origin: .zero, size: CGSize(width: HUDWidth , height: HUDWidth * 2.0 / sqrt(3)))
        self.backgroundColor = UIColor.white
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        drawCircle(point: CGPoint(x: rect.width / 2, y: HUDRadius), color: UIColor.kColor(red: 246, green: 173, blue: 11))
        drawCircle(point: CGPoint(x: rect.width - HUDRadius, y: rect.height / 4 + HUDRadius/2), color: UIColor.kColor(red: 45, green: 136, blue: 254))
        drawCircle(point: CGPoint(x: rect.width - HUDRadius, y: rect.height / 4 * 3 - HUDRadius/2), color: UIColor.kColor(red: 44 , green: 155 , blue: 118 ))
        
        drawCircle(point: CGPoint(x: rect.width / 2, y: rect.height - HUDRadius), color: UIColor.kColor(red: 239 , green: 0 , blue: 102 ))
        drawCircle(point: CGPoint(x: HUDRadius, y: rect.height / 4 * 3 - HUDRadius/2), color: UIColor.kColor(red: 240 , green: 64 , blue: 11))
        drawCircle(point: CGPoint(x: HUDRadius, y: rect.height / 4 + HUDRadius/2), color: UIColor.kColor(red: 44 , green: 166 , blue: 10))
    }
    
    private func drawCircle(point:CGPoint,color:UIColor) {
        let path = UIBezierPath()
        path.addArc(withCenter: point , radius: HUDRadius, startAngle: 0, endAngle: 360, clockwise: true)
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
        bounds = CGRect(origin: .zero, size: CGSize(width: HUDWidth , height: HUDWidth * 2.0 / sqrt(3)))
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = Double.pi * 2
        rotationAnimation.duration = 1
        rotationAnimation.repeatCount = MAXFLOAT
        layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    //hide HUD
    func hide() {
        if animating == false {
            return
        }
        animating = false
        layer.removeAnimation(forKey: "rotationAnimation")
        UIView.animate(withDuration: 0.4, animations: {
            self.bounds = .zero
        })
    }
}
