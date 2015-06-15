//
// MenuViewController.swift
//
// MenuViewController.swift
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

import UIKit

class MenuViewController: UITableViewController {

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0): openCollectionViewTransitionDemo()
        case (0, 1): openTableViewTransitionDemo()
        case (1, 0): openTranslucentViewDemo()
        case (1, 1): openBeatingCircleDemo()
        case (1, 2): openFadeOutViewDemo()
        case (2, 0): openSonarButtons()
        case (2, 1): openExclusiveButtons()
        default: return;
        }
    }


    // MARK: - IBActions

    func openCollectionViewTransitionDemo() {
        if let vc = UIStoryboard.collectionViewStoryboard().instantiateInitialViewController() {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func openTableViewTransitionDemo() {
        if let vc = UIStoryboard.tableViewStoryboard().instantiateInitialViewController() {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func openTranslucentViewDemo() {
        let vc = UIStoryboard.examplesStoryboard().instantiateViewControllerWithIdentifier("TranslucentViewController")
        self.presentViewController(vc, animated: true, completion: nil)
    }

    func openBeatingCircleDemo() {
        let vc = UIStoryboard.examplesStoryboard().instantiateViewControllerWithIdentifier("BeatingCircleViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func openFadeOutViewDemo() {
        let vc = UIStoryboard.examplesStoryboard().instantiateViewControllerWithIdentifier("FadeOutViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func openSonarButtons() {
        let vc = UIStoryboard.examplesStoryboard().instantiateViewControllerWithIdentifier("SonarButtonsViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func openExclusiveButtons() {
        let vc = UIStoryboard.examplesStoryboard().instantiateViewControllerWithIdentifier("ExclusiveButtonsViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

