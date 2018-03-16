//
//  CounterView.swift
//  Animation
//
//  Created by Tejaswini on 14/03/18.
//  Copyright © 2018 Tejaswini. All rights reserved.
//

import UIKit

@IBDesignable class CounterView: UIView {

    private struct Constants{
        static let numberOfGlass = 8
        static let lineWidth : CGFloat = 5.0
        static let arcWidth : CGFloat = 76.0
    
        static var halfLineWidth : CGFloat{
        return Constants.lineWidth/2
    }
}
    @IBInspectable var counter: Int = 5 {
        didSet {
            if counter <=  Constants.numberOfGlass {
                
                setNeedsDisplay()
            }
        }
    }
   @IBInspectable var outlineColor : UIColor = UIColor.blue
   @IBInspectable var counterColor : UIColor = UIColor.orange
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        let center : CGPoint = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let radius : CGFloat = max(bounds.width, bounds.height)
        let startAngle : CGFloat = 3 * .pi/4
        let endAngle : CGFloat = .pi/4
        let path = UIBezierPath(arcCenter: center, radius: radius/2 - Constants.arcWidth/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        path.lineWidth = Constants.arcWidth
        counterColor.setStroke()
        path.stroke()
        
       
        let angleDifference: CGFloat = 2 * .pi - startAngle + endAngle
       
        let arcLengthPerGlass = angleDifference / CGFloat(Constants.numberOfGlass)
      
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
       
        let outlinePath = UIBezierPath(arcCenter: center,
                                       radius: bounds.width/2 - Constants.halfLineWidth,
                                       startAngle: startAngle,
                                       endAngle: outlineEndAngle,
                                       clockwise: true)
        
       
        outlinePath.addArc(withCenter: center,
                           radius: bounds.width/2 - Constants.arcWidth + Constants.halfLineWidth,
                           startAngle: outlineEndAngle,
                           endAngle: startAngle,
                           clockwise: false)
        
       
        outlinePath.close()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = Constants.lineWidth
        outlinePath.stroke()
        
    }
    

}
