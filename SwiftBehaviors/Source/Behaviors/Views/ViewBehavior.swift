//
// ViewBehavior.swift
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

public class ViewBehavior : SwiftBehavior {
    private let kViewFrame = NSStringFromSelector(Selector("targetView.frame"))

    @IBOutlet var targetView: UIView? {
        didSet {
            targetViewDidSet(targetView!)
        }
    }

    public func targetViewDidSet(target: UIView) {}
    public func targetViewDidLoad(target: UIView) {}

    override public func awakeFromNib() -> Void {
        super.awakeFromNib()
        addObserver(self, forKeyPath: kViewFrame,
                    options: NSKeyValueObservingOptions.New,
                    context: nil)
    }

    /*
     * This is invoked after view frame is set (after target's viewDidLoad)
     */
    override public func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject,
        change: [NSObject : AnyObject],
        context: UnsafeMutablePointer<Void>)
    {
        removeObserver(self, forKeyPath: kViewFrame)
        targetViewDidLoad(targetView!)
    }
}