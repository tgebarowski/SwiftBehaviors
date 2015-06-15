//
// CollectionViewController.swift
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


class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet var cellExpansionBehavior: CollectionViewCellExpansionBehavior?

    let colors = [UIColor.redColor(), UIColor.orangeColor(), UIColor.greenColor(), UIColor.blueColor(), UIColor.darkGrayColor(), UIColor.whiteColor() ];

    var indexPath = NSIndexPath()

    override func viewWillAppear(animated: Bool) {
        navigationController?.delegate = cellExpansionBehavior
        cellExpansionBehavior?.collectionViewDelegate = self
    }

    override func viewWillDisappear(animated: Bool) {
        navigationController?.delegate = nil
    }

    // MARK: UICollectionViewDelegate


    // MARK: UICollectionViewDataSource

    //1
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    //2
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    //3
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
        cell.backgroundColor = self.colors[indexPath.row];
        return cell
    }

    // MARK UICollectionViewDelegateFlowLayout

    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let insets = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInset;
        return CGSizeMake(collectionView.bounds.width - (insets.left + insets.right), 110);
    }

}
