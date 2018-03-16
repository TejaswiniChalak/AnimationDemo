//
//  PushButton.swift
//  Animation
//
//  Created by Tejaswini on 14/03/18.
//  Copyright © 2018 Tejaswini. All rights reserved.
//

import UIKit
@IBDesignable

class PushButton: UIButton {

    private var halfWidth: CGFloat {
        return bounds.width / 2
    }
    private var halfHeight: CGFloat {
        return bounds.height / 2
    }
    private struct Constants{
        static let plusLineWidth: CGFloat = 3.0
        static let plusButtonScale: CGFloat = 0.6
        static let halfPointShift: CGFloat = 0.5
    }
    @IBInspectable var fillColor : UIColor = UIColor.green
    @IBInspectable var isAddButton : Bool = true
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
       let path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
        
        let plusWidth : CGFloat = min(bounds.width, bounds.height) * Constants.plusButtonScale
        let halfPlusWidth : CGFloat = plusWidth/2
        
        let plusPath = UIBezierPath()
        plusPath.lineWidth = Constants.plusLineWidth
        
        plusPath.move(to: CGPoint(x: halfWidth - halfPlusWidth + Constants.halfPointShift, y: halfHeight + Constants.halfPointShift))
        
        plusPath.addLine(to: CGPoint(
            x: halfWidth + halfPlusWidth + Constants.halfPointShift,
            y: halfHeight + Constants.halfPointShift))
        
        if isAddButton{
        plusPath.move(to: CGPoint(
            x: halfWidth + Constants.halfPointShift,
            y: halfHeight - halfPlusWidth + Constants.halfPointShift))
        
        plusPath.addLine(to: CGPoint(
            x: halfWidth + Constants.halfPointShift,
            y: halfHeight + halfPlusWidth + Constants.halfPointShift))
        }
        
        //set the stroke color
        UIColor.white.setStroke()
        
        //draw the stroke
        plusPath.stroke()
    }

}

