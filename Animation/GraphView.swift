//
//  GraphView.swift
//  Animation
//
//  Created by Tejaswini on 15/03/18.
//  Copyright © 2018 Tejaswini. All rights reserved.
//

import UIKit

@IBDesignable class GraphView: UIView {
    @IBInspectable var startColor : UIColor = .red
    @IBInspectable var endColor : UIColor = .green
//added
    private struct Constants{
        static let cornerRadiusSize = CGSize(width: 8.0, height: 8.0)
        static let topBorder : CGFloat =  60.0
        static let bottomBorder : CGFloat = 50.0
        static let colorAlpha : CGFloat = 0.3
        static let circleDiameter : CGFloat = 5.0
        static let margin : CGFloat = 20.0
    }
    var graphPoints = [4,6,2,4,3,2,1]
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: Constants.cornerRadiusSize)
        path.addClip()
        
       let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.cgColor,endColor.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations : [CGFloat] = [0.0,1.0]
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations)
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0.0, y: bounds.height)
        context?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: [])
        
        let margin = Constants.margin
        let graphWidth = width - margin * 2 - 4
        let columnXPoint = { (column: Int) -> CGFloat in
            //Calculate the gap between points
            let spacing = graphWidth / CGFloat(self.graphPoints.count - 1)
            return CGFloat(column) * spacing + margin + 2
        }
        
        let topBorder = Constants.topBorder
        let bottomBorder = Constants.bottomBorder
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = graphPoints.max()!
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
            let y = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            return graphHeight + topBorder - y // Flip the graph
        }
        UIColor.white.setFill()
        UIColor.white.setStroke()
        
        // set up the points line
        let graphPath = UIBezierPath()
        
        // go to start of line
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
        
        // add points for each item in the graphPoints array
        // at the correct (x, y) for the point
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            graphPath.addLine(to: nextPoint)
        }
        
        graphPath.stroke()
        context?.saveGState()
        
        let clipingPath = graphPath.copy() as! UIBezierPath
        clipingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count - 1), y: height))
        clipingPath.addLine(to: CGPoint(x: columnXPoint(0), y: height))
        clipingPath.close()
        clipingPath.addClip()
        
        UIColor.green.setFill()
        let rectPath = UIBezierPath(rect: rect)
        rectPath.fill()

        let highestPoint = columnYPoint(maxValue)
        let startHeighestPoint = CGPoint(x: margin, y: highestPoint)
        let endHeighestPoint = CGPoint(x: margin, y: bounds.height)
        context?.drawLinearGradient(gradient!, start: startHeighestPoint, end: endHeighestPoint, options: [])
        context?.restoreGState()
        
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        
        for i in 0..<graphPoints.count{
            var point = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            point.x -= Constants.circleDiameter / 2
            point.y -= Constants.circleDiameter / 2
            let circle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: Constants.circleDiameter, height: Constants.circleDiameter)))
            circle.fill()
        }
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: topBorder))
        
        linePath.move(to: CGPoint(x: margin, y: graphHeight/2 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight/2 + topBorder))
        
        linePath.move(to: CGPoint(x: margin, y: height - bottomBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: Constants.colorAlpha)
        color.setStroke()
        
        linePath.lineWidth = 1.0
        linePath.stroke()
    }

}
