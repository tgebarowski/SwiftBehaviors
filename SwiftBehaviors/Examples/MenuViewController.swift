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

class MenuViewController: UITableViewController, UITableViewDelegate {

/*
    override func viewDidLoad() {
        super.viewDidLoad()

        //counter.intValue = 50

        let c1 = UIColor(red: 77/255.0, green: 219/255, blue: 178/255, alpha: 1.0);
        let c2 = UIColor(red: 77/255.0, green: 184/255, blue: 172/255, alpha: 1.0);
        let c3 = UIColor(red: 77/255.0, green: 157/255, blue: 162/255, alpha: 1.0);
        let c4 = UIColor(red: 255/255.0, green: 240/255, blue: 24/255, alpha: 1.0);

        chart.animated = true
        chart.components = [DonutChart.Component(caption: "Value 1", value: 10, color: c1),
                            DonutChart.Component(caption: "Value 2", value: 25, color: c2),
                            DonutChart.Component(caption: "Value 3", value: 30, color: c3),
                            DonutChart.Component(caption: "Value 3", value: 15, color: c4)]

        NSTimer.scheduledTimerWithTimeInterval(0.15, target: self, selector: Selector("addSample"),
                                               userInfo: nil, repeats: true)

        // Do any additional setup after loading the view, typically from a nib.
    }
*/
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
        if let vc = UIStoryboard.collectionViewStoryboard().instantiateInitialViewController() as? UIViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func openTableViewTransitionDemo() {
        if let vc = UIStoryboard.tableViewStoryboard().instantiateInitialViewController() as? UIViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func openTranslucentViewDemo() {
        if let vc = UIStoryboard.examplesStoryboard().instantiateViewControllerWithIdentifier("TranslucentViewController") as? UIViewController {
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }

    func openBeatingCircleDemo() {
        if let vc = UIStoryboard.examplesStoryboard().instantiateViewControllerWithIdentifier("BeatingCircleViewController") as? UIViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func openFadeOutViewDemo() {
        if let vc = UIStoryboard.examplesStoryboard().instantiateViewControllerWithIdentifier("FadeOutViewController") as? UIViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func openSonarButtons() {
        if let vc = UIStoryboard.examplesStoryboard().instantiateViewControllerWithIdentifier("SonarButtonsViewController") as? UIViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func openExclusiveButtons() {
        if let vc = UIStoryboard.examplesStoryboard().instantiateViewControllerWithIdentifier("ExclusiveButtonsViewController") as? UIViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

