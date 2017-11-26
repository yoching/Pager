//
//  PagerContentViewControllers.swift
//  Pager
//
//  Created by Yoshikuni Kato on 11/26/17.
//  Copyright © 2017 Yoshikuni Kato. All rights reserved.
//

import UIKit

class PagerContentViewControllers: NSObject {
    let contentViewControllers: [UIViewController]

    init(contentViewControllers: [UIViewController]) {
        self.contentViewControllers = contentViewControllers
    }
}

extension PagerContentViewControllers: PagerDataSource {

    // MARK: PagerDataSource
    func numberOfItems(in pagerViewController: PagerViewController) -> Int {
        return contentViewControllers.count
    }

    func pagerViewController(
        _ pagerViewController: PagerViewController,
        upperTabItemForPageAt index: Int
        ) -> UpperTabItem {
        let item = UpperTabItem(frame: .zero)
        item.configure(name: contentViewControllers[index].title)
        return item
    }

    func pagerViewController(
        _ pagerViewController: PagerViewController,
        viewControllerForPageAt index: Int
        ) -> UIViewController {
        return contentViewControllers[index]
    }

    func pagerViewController(
        _ pagerViewController: PagerViewController,
        indexOf viewController: UIViewController
        ) -> Int? {
        return contentViewControllers.index(of: viewController)
    }

    // MARK: UIPageViewControllerDataSource
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
        ) -> UIViewController? {
        guard let index = contentViewControllers.index(of: viewController),
            (index - 1) >= 0 else {
                return nil
        }
        return contentViewControllers[index - 1]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
        ) -> UIViewController? {
        guard let index = contentViewControllers.index(of: viewController),
            (index + 1) < contentViewControllers.count else {
                return nil
        }
        return contentViewControllers[index + 1]
    }

}
