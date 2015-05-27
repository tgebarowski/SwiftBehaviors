//
// BeatingCircleAnimationBehavior.swift
//
// Copyright (c) 2015 Tomasz Gebarowski <gebarowski at gmail com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import UIKit

class BeatingCircle : UIView {
    var color : UIColor = UIColor.redColor()
    var path : UIBezierPath
    var animating: Bool = false

    override init(frame: CGRect) {
        self.path = UIBezierPath(ovalInRect: frame)
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }

    convenience init (radius: CGFloat, color: UIColor)
    {
        self.init(frame: CGRect(x: 0, y: 0, width: radius, height: radius))
        self.color = color
    }

    required init(coder aDecoder: NSCoder) {
        self.path = UIBezierPath(ovalInRect: CGRect(x: 0, y:0, width:0, height:0))
        super.init(coder: aDecoder)
    }

    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext();
        color.set(); path.fill()
    }

    func animate() {
        self.hidden = false
        self.animating = true
        animationLoop()
    }

    func animationLoop() {

        UIView.animateWithDuration(0.25, delay: 0.0, options: .CurveEaseOut, animations: {
            self.transform = CGAffineTransformMakeScale(1.75, 1.75)
            self.alpha = 0.5;
            }, completion: { finished in
                UIView.animateWithDuration(0.25, delay: 0.0, options: .CurveEaseIn, animations:
                    {
                        self.transform = CGAffineTransformMakeScale(0.75, 0.75)
                        self.alpha = 1
                    }, completion: { finished in
                        if (self.animating) {
                            self.animationLoop()
                        }
                })
        })
    }

    func stop() {
        self.hidden = true
        self.animating = false
    }
}

class BeatingCircleAnimationBehavior : ViewBehavior {

    @IBInspectable var zoomInDuration: Double = 0.25
    @IBInspectable var zoomOutDuration: Double = 0.5
    @IBInspectable var circleColor: UIColor = UIColor.greenColor()
    @IBInspectable var scalePositionX: CGFloat = 2
    @IBInspectable var scalePositionY: CGFloat = 3
    @IBInspectable var radius: CGFloat = 25
    @IBInspectable var caption: String = ""

    var circleView: BeatingCircle?
    var captionLabel: UILabel?


    override func targetViewDidLoad(targetView: UIView) {
        self.circleView = BeatingCircle(radius: self.radius,
            color: self.circleColor)

        self.circleView!.setTranslatesAutoresizingMaskIntoConstraints(false)
        targetView.addSubview(circleView!)

        if (!caption.isEmpty) {
            captionLabel = UILabel()
            captionLabel?.text = self.caption
            captionLabel?.setTranslatesAutoresizingMaskIntoConstraints(false)
            captionLabel?.hidden = true
            targetView.addSubview(captionLabel!)

            let xLabelCenterConstraint = NSLayoutConstraint(item: captionLabel!,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: circleView!,
                attribute: .CenterX,
                multiplier: 1.0, constant: 0)
            let yLabelBottomConstraint = NSLayoutConstraint(item: captionLabel!,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: circleView,
                attribute: .Bottom,
                multiplier: 1.0, constant: 10)
            targetView.addConstraint(xLabelCenterConstraint)
            targetView.addConstraint(yLabelBottomConstraint)
        }

        let xCenterConstraint = NSLayoutConstraint(item: circleView!,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: targetView,
            attribute: .CenterX,
            multiplier: 1.0, constant: 0)
        let yCenterConstraint = NSLayoutConstraint(item: circleView!,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: targetView,
            attribute: .CenterY,
            multiplier: 1.0, constant: 0)

        let widthConstraint = NSLayoutConstraint(item: circleView!,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .NotAnAttribute,
            multiplier: 1.0, constant: radius)
        let heightConstraint = NSLayoutConstraint(item: circleView!,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .NotAnAttribute,
            multiplier: 1.0, constant: radius)

        targetView.addConstraint(xCenterConstraint)
        targetView.addConstraint(yCenterConstraint)
        targetView.addConstraint(widthConstraint)
        targetView.addConstraint(heightConstraint)
        
        start()
    }

    func start() {
        circleView!.animate()
        captionLabel?.hidden = false
    }

    func stop() {
        circleView!.stop()
        captionLabel?.hidden = true
    }
}