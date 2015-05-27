//
// UIView+Snapshot.swift
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
 * UIView extension providing method for taking screenshot of specified 
 * region of the UIView
 */
extension UIView {

    func takeSnapshot(rect: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(UIScreen.mainScreen().bounds.size, false, UIScreen.mainScreen().scale)
        if drawViewHierarchyInRect(UIScreen.mainScreen().bounds, afterScreenUpdates: true) {
            let image = UIGraphicsGetImageFromCurrentImageContext()

            let imageRef = CGImageCreateWithImageInRect(image.CGImage,
                CGRectMake(image.scale * rect.origin.x,
                    image.scale * rect.origin.y,
                    image.scale * rect.size.width,
                    image.scale * rect.size.height))
            let screen = UIImage(CGImage: imageRef, scale: image.scale, orientation: .Up)
            UIGraphicsEndImageContext()
            return screen
        }
        return nil
    }
}