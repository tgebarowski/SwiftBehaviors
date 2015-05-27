//
// BlurredViewBehavior.swift
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

/**
 * Behavior adding blur effect to UIViewController's view
 * Works on both iOS 7 (UIImage+Effects) and iOS 8 (UIVisualEffectView)
 */
class BlurredViewBehavior : ViewBehavior {

    @IBOutlet var targetVC: UIViewController?

    override func targetViewDidLoad(targetView: UIView) {

        if let presentedVC = targetVC {
            // iOS 8
            if NSClassFromString("UIVisualEffectView") != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    presentedVC.view.backgroundColor = UIColor.clearColor()
                    let blurEffect = UIBlurEffect(style: .Dark)
                    let effectView = UIVisualEffectView(effect: blurEffect)
                    effectView.frame = presentedVC.view.frame
                    presentedVC.view.insertSubview(effectView, atIndex: 0)
                })
            // iOS 7
            } else {
                if let presentingView = presentedVC.presentingViewController?.view {
                    dispatch_async(dispatch_get_main_queue(), {
                        if let screen = presentingView.takeSnapshot(presentedVC.view.bounds) {
                            let blurredView = UIImageView(frame: presentedVC.view.bounds)
                            let blurredImage = screen.applyDarkEffect()
                            blurredView.image = blurredImage
                            presentedVC.view.insertSubview(blurredView, atIndex: 0)
                        }
                    })
                }
            }
        }
    }
}