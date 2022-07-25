//
//  UIView+Additions.swift
//  Things
//
//  Created by Teja on 23/07/22.
//

import Foundation
import UIKit

class TopLeftView: UIView {
    override init(frame: CGRect){
      super.init(frame: frame)
      backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder){
      super.init(coder: aDecoder)
      backgroundColor = UIColor.clear
    }
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        let width = self.frame.size.width
        let height = self.frame.size.height
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: 0.88 * width , y: 0.0))
        path.addQuadCurve(to: CGPoint(x: 0.0, y: height*0.92), controlPoint: CGPoint(x: 0.4 * width, y: height*1.18))
        path.close()
        UIColor.orange.set()
        path.fill()
    }
}

class BottomRightView: UIView {
    override init(frame: CGRect){
      super.init(frame: frame)
      backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder){
      super.init(coder: aDecoder)
      backgroundColor = UIColor.clear
    }
    override func draw(_ rect: CGRect){
        let path = UIBezierPath()
        let width = self.frame.size.width
        let height = self.frame.size.height
        path.move(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0.12 * width , y: height))
        path.addQuadCurve(to: CGPoint(x: width, y: height*0.08), controlPoint: CGPoint(x: 0.6 * width, y: height*(-0.18)))
        path.close()
        UIColor.orange.set()
        path.fill()
    }
}

class BottomLeftView: UIView {
    override init(frame: CGRect){
      super.init(frame: frame)
      backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder){
      super.init(coder: aDecoder)
      backgroundColor = UIColor.clear
    }
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        let width = self.frame.size.width
        let height = self.frame.size.height
        path.move(to: CGPoint(x: 0.0, y: height*0.2))
        path.addQuadCurve(to: CGPoint(x: width, y: 0.66*height), controlPoint: CGPoint(x: 0.5*width, y: (-0.2)*height))
        path.addLine(to: CGPoint(x: width , y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.close()
        UIColor.orange.set()
        path.fill()
    }
}




