//
// SonarButtonBehavior.swift
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

public class SonarButtonBehavior : ViewBehavior {

    @IBInspectable var duration: CFTimeInterval = 2
    @IBInspectable var ringColorStart: UIColor = UIColor.greenColor()
    @IBInspectable var ringColorEnd: UIColor = UIColor.greenColor()
    @IBInspectable var ringWidth: CGFloat = 4
    @IBInspectable var ringsAtOnce: Int = 3

    var ringLayers = [UIButton: [CAShapeLayer]]()

    override public func targetViewDidSet(targetView: UIView) {
    }

    override public func targetViewDidLoad(targetView: UIView) {
    }

    public func startAnimation(sender: UIButton) -> Void {
        buttonPressed(sender)
    }

    public func stopAnimation(sender: UIButton) {
        buttonReleased(sender)
    }

    @IBAction func buttonPressed(sender: AnyObject) {
        if let contentView = targetView {
            for _ in 0 ... ringsAtOnce {
                addSingleRingLayer(sender as! UIButton, contentView: contentView)
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.startSonarAnimation(sender as! UIButton, contentView: contentView)
            })
        }
    }

    @IBAction func buttonReleased(sender: AnyObject) {
        if let layers = ringLayers[sender as! UIButton] {
            for ringLayer in layers {
                ringLayer.removeAllAnimations()
                ringLayer.removeFromSuperlayer()
            }
        }
        ringLayers.removeValueForKey(sender as! UIButton)
    }

    func startSonarAnimation(button: UIButton, contentView: UIView) {
        var timeOffset: CFTimeInterval = 0;

        if let layers = ringLayers[button] {
            for ringLayer in layers {
                let animationGroup = singleRingAnimation(button, ringLayer: ringLayer, contentView: contentView)
                animationGroup.beginTime = CACurrentMediaTime() + timeOffset
                ringLayer.addAnimation(animationGroup, forKey: "ring-\(timeOffset)")
                timeOffset += CFTimeInterval(CGFloat(duration) / CGFloat(ringsAtOnce))
            }
        }
    }

    private func buttonFrameForMainView(button: UIButton, contentView: UIView) -> CGRect {
        if button.superview != contentView &&
           button.superview != nil {
            return contentView.convertRect(button.frame, fromView: button.superview)
        }
        return button.frame
    }

    private func addSingleRingLayer(button: UIButton, contentView: UIView) {
        let ringLayer = CAShapeLayer()


        let buttonFrame = buttonFrameForMainView(button, contentView: contentView)

        let container = CGRect(x: CGRectGetMidX(buttonFrame) - CGRectGetHeight(buttonFrame) / 2,
                               y: CGRectGetMinY(buttonFrame),
                               width: CGRectGetHeight(buttonFrame),
                               height: CGRectGetHeight(buttonFrame))

        ringLayer.path = UIBezierPath(ovalInRect: container).CGPath;

        // Configure the apperence of the circle
        ringLayer.fillColor = UIColor.clearColor().CGColor;
        ringLayer.strokeColor = UIColor.clearColor().CGColor;
        ringLayer.lineWidth = self.ringWidth;
        ringLayer.opacity = 0;

        contentView.layer.addSublayer(ringLayer)
        if (ringLayers[button]?.append(ringLayer) == nil) {
            ringLayers[button] = [ringLayer]
        }
    }

    private func singleRingAnimation(button: UIButton, ringLayer: CAShapeLayer, contentView: UIView) -> CAAnimationGroup {

        let maxSize = CGRectGetWidth(contentView.frame);

        let buttonFrame = buttonFrameForMainView(button, contentView: contentView)

        let container = CGRect(x: CGRectGetMidX(buttonFrame) - CGRectGetHeight(buttonFrame) / 2,
            y: CGRectGetMinY(buttonFrame),
            width: CGRectGetHeight(buttonFrame),
            height: CGRectGetHeight(buttonFrame))

        let newContainer = CGRect(x: CGRectGetMinX(container) - CGFloat(maxSize) / 2,
            y: CGRectGetMinY(container) - CGFloat(maxSize) / 2,
            width: CGRectGetWidth(container) + CGFloat(maxSize),
            height: CGRectGetHeight(container) + CGFloat(maxSize))

        let pathAnim = CABasicAnimation(keyPath: "path")
        pathAnim.toValue = UIBezierPath(ovalInRect: newContainer).CGPath;

        let fadeAnim = CABasicAnimation(keyPath: "opacity")
        fadeAnim.fromValue = 0.7
        fadeAnim.toValue = 0

        let colorAnim = CABasicAnimation(keyPath: "strokeColor")
        colorAnim.fromValue = self.ringColorStart.CGColor;
        colorAnim.fromValue = self.ringColorEnd.CGColor;

        let group = CAAnimationGroup()
        group.animations = [pathAnim, fadeAnim, colorAnim];
        group.duration = duration; /* seconds */
        group.repeatCount = Float.infinity
        group.setValue("sonarAnimation", forKey: "animationName")
        group.setValue(ringLayer, forKey:"animationLayer")
        group.removedOnCompletion = true;

        return group
    }
}