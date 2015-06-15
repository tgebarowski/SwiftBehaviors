//
// SwiftBehavior.swift
//
// This is a Swift version of KZBehavior from:
// https://github.com/krzysztofzablocki/BehavioursExample
//
// described in objc.io #13 (http://www.objc.io/issue-13/behaviors.html)
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

public class SwiftBehavior : UIControl {
    private var AssociatedObjectHandle: UInt8 = 0
    private var _owner: AnyObject?

    @IBOutlet var owner: AnyObject! {
        willSet {
            if _owner != nil {
                releaseLifetimeFromObject(_owner!)
            }
            bindLifetimeToObject(newValue)
            _owner = newValue
        }
    }

    func bindLifetimeToObject(object: AnyObject) -> Void {
        objc_setAssociatedObject(object, &_owner, self,
                                 .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    func releaseLifetimeFromObject(object: AnyObject) -> Void {
        objc_setAssociatedObject(object, &_owner, nil,
                                 .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
