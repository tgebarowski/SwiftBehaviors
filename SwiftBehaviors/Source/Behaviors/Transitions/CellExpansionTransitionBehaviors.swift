//
// CellExpansionTransitionBehaviors.swift
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


public class CollectionViewCellExpansionBehavior : NavigationControllerTransitionBehavior,
                                                   UICollectionViewDelegate
{
    @IBOutlet var collectionViewDelegate: UICollectionViewDelegate?

    init () {
        super.init(animator: CellExpansionTransitionAnimator())
    }

    required public init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    // MARK: UICollectionViewDelegate

    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cellAnimator = animator as? CellExpansionTransitionAnimator {
            cellAnimator.animatedCell = collectionView.cellForItemAtIndexPath(indexPath)
        }
    }

    override public func forwardingTargetForSelector(aSelector: Selector) -> AnyObject? {
        if collectionViewDelegate?.respondsToSelector(aSelector) == true {
            return collectionViewDelegate
        } else {
            return super.forwardingTargetForSelector(aSelector)
        }
    }
}

public class TableViewCellExpansionBehavior : NavigationControllerTransitionBehavior,
    UICollectionViewDelegate
{
    @IBOutlet var tableViewDelegate: UITableViewDelegate?

    init () {
        super.init(animator: CellExpansionTransitionAnimator())
    }

    required public init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    // MARK: UITableViewDelegate

    public func tableView(tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath) {
            if let cellAnimator = animator as? CellExpansionTransitionAnimator {
                cellAnimator.animatedCell = tableView.cellForRowAtIndexPath(indexPath)
                // Frame has to be recalculated because cellForRowAtIndexPath does not know cell size
                cellAnimator.animatedCell?.frame = tableView.rectForRowAtIndexPath(indexPath)
            }
    }

    override public func forwardingTargetForSelector(aSelector: Selector) -> AnyObject? {
        if tableViewDelegate?.respondsToSelector(aSelector) == true {
            return tableViewDelegate
        } else {
            return super.forwardingTargetForSelector(aSelector)
        }
    }
}


private class CellExpansionTransitionAnimator : NSObject, UIViewControllerAnimatedTransitioning {

    var animatedCell: UIView?
    var duration: Double = 1

    @objc func animateTransition(transitionContext: UIViewControllerContextTransitioning) {

        if let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
           let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
           let cell = animatedCell,
           let scrollView = fromVC.view as? UIScrollView ?? (fromVC as? UICollectionViewController)?.collectionView {
                transitionContext.containerView().addSubview(toVC.view)
                toVC.view.alpha = 0

                /* Make UIView which will be used to animate expanding and covering cell */
                var cellCover = UIView(frame: fromVC.view.frame);
                cellCover.backgroundColor = cell.backgroundColor
                transitionContext.containerView().addSubview(cellCover)

                /*
                * Adjust selectedCell frame taking into account parents UIScrollView insets
                */
                var selectedRect = CGRectMake(0, cell.frame.origin.y - scrollView.contentOffset.y ?? 0,
                                              scrollView.bounds.width, cell.frame.height);

                let upperRect = CGRectMake(0, 0,
                                           scrollView.bounds.width,
                                           selectedRect.origin.y)

                let lowerRect = CGRectMake(0, selectedRect.origin.y + selectedRect.size.height,
                                           scrollView.bounds.width,
                                           scrollView.frame.height - upperRect.size.height - selectedRect.height)


                var selectedCell = UIImageView(image: scrollView.takeSnapshot(selectedRect))
                var upperCellsView = UIImageView(image: scrollView.takeSnapshot(upperRect))
                var lowerCellsView = UIImageView(image: scrollView.takeSnapshot(lowerRect))
                selectedCell.frame = selectedRect
                upperCellsView.frame = upperRect
                lowerCellsView.frame = lowerRect

                /* Add animated cell to transition view */
                transitionContext.containerView().addSubview(selectedCell)
                /* Add screenshots of cells which are animated up/down */
                transitionContext.containerView().addSubview(upperCellsView)
                transitionContext.containerView().addSubview(lowerCellsView)

                UIView.animateWithDuration(duration,
                    animations: {
                        selectedCell.alpha = 0
                        toVC.view.alpha = 1
                        /* Set target view background color same as cell color */
                        toVC.view.backgroundColor = cell.backgroundColor
                        /* Animate surrounding cells */
                        upperCellsView.transform = CGAffineTransformMakeTranslation(0, -1.0 * upperCellsView.frame.height)
                        lowerCellsView.transform = CGAffineTransformMakeTranslation(0,lowerCellsView.frame.height)

                    }, completion: { (value: Bool) in
                        fromVC.view.transform = CGAffineTransformIdentity
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                        cellCover.removeFromSuperview()
                        selectedCell.removeFromSuperview()
                        upperCellsView.removeFromSuperview()
                        lowerCellsView.removeFromSuperview()
                });
        }
    }

    @objc func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return duration
    }
}