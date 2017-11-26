//
//  PagerDataSource.swift
//  Pager
//
//  Created by Yoshikuni Kato on 11/26/17.
//  Copyright © 2017 Yoshikuni Kato. All rights reserved.
//

import UIKit

protocol PagerDataSource: UIPageViewControllerDataSource {
    func numberOfItems(in pagerViewController: PagerViewController) -> Int
    func pagerViewController(_ pagerViewController: PagerViewController,
                             upperTabItemForPageAt index: Int) -> UpperTabItem

    func pagerViewController(_ pagerViewController: PagerViewController,
                             viewControllerForPageAt index: Int) -> UIViewController

    func pagerViewController(_ pagerViewController: PagerViewController,
                             indexOf viewController: UIViewController) -> Int?
}
