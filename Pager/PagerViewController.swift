//
//  PagerViewController.swift
//  Pager
//
//  Created by Yoshikuni Kato on 11/26/17.
//  Copyright © 2017 Yoshikuni Kato. All rights reserved.
//

import UIKit

final class PagerViewController: UIViewController {

    var dataSource: PagerDataSource?

    @IBOutlet weak var pageViewControllerContainerView: UIView!
    @IBOutlet weak var upperTabsView: UIStackView!

    @IBOutlet weak var upperTabIndicatorBarContainerView: UIView!
    weak var upperTabIndicatorBar: UIView? // will be made by code

    private let pageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal,
        options: nil
    )
    lazy var scrollViewInPageViewController: UIScrollView! = {
        for view in pageViewController.view.subviews {
            if let scrollView = view as? UIScrollView {
                return scrollView
            }
        }
        return nil
    }()

    private var currentContentVC: UIViewController?

    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let dataSource = dataSource else {
            return
        }
        configurePageViewController(with: dataSource)
        configureUpperTabsView(with: dataSource)
        configureIndicatorBar(numberOfItems: dataSource.numberOfItems(in: self))
    }
}

// MARK: - Private Methods
private extension PagerViewController {

    func configurePageViewController(with dataSource: PagerDataSource) {

        pageViewController.dataSource = dataSource
        pageViewController.delegate = self
        scrollViewInPageViewController?.delegate = self

        addChildViewController(pageViewController)
        pageViewControllerContainerView.addFilledSubview(pageViewController.view)
        pageViewController.didMove(toParentViewController: self)

        currentContentVC = dataSource.pagerViewController(self, viewControllerForPageAt: 0)
        if let currentContentVC = currentContentVC {
            pageViewController.setViewControllers(
                [currentContentVC],
                direction: .forward,
                animated: true,
                completion: nil
            )
        }
    }

    func configureUpperTabsView(with dataSource: PagerDataSource) {
        for index in 0..<dataSource.numberOfItems(in: self) {
            let item = dataSource.pagerViewController(self, upperTabItemForPageAt: index)
            item.delegate = self
            upperTabsView.addArrangedSubview(item)
        }
    }

    func configureIndicatorBar(numberOfItems: Int) {
        let indicatorBar = UIView()
        indicatorBar.backgroundColor = UIColor(rgb: 0xAAAAAA)

        // add bar to container view
        upperTabIndicatorBarContainerView.addSubview(indicatorBar)
        indicatorBar.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            indicatorBar.topAnchor.constraint(equalTo: upperTabIndicatorBarContainerView.topAnchor),
            indicatorBar.bottomAnchor.constraint(equalTo: upperTabIndicatorBarContainerView.bottomAnchor),
            indicatorBar.leadingAnchor.constraint(equalTo: upperTabIndicatorBarContainerView.leadingAnchor),
            indicatorBar.widthAnchor.constraint(
                equalTo: upperTabIndicatorBarContainerView.widthAnchor,
                multiplier: 1.0 / CGFloat(numberOfItems)
            )
        ]
        constraints.forEach { $0.isActive = true }

        upperTabIndicatorBar = indicatorBar
    }

    func moveIndicatorBar(to portion: CGFloat) {
        guard let bar = upperTabIndicatorBar else {
            return
        }
        bar.transform = CGAffineTransform(translationX: bar.bounds.width * portion, y: 0.0)
    }
}

// MARK: - UIScrollViewDelegate
extension PagerViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let currentContentVC = currentContentVC,
            let currentContentVCIndex = dataSource?.pagerViewController(self, indexOf: currentContentVC) else {
                return
        }
        let pagePortion = scrollView.contentOffset.x / scrollView.bounds.width
            + CGFloat(currentContentVCIndex - 1)
        moveIndicatorBar(to: pagePortion)
    }
}

// MARK: - UIPageViewControllerDelegate
extension PagerViewController: UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
        ) {
        guard completed else {
            return
        }
        currentContentVC = pageViewController.viewControllers?.first
    }
}

// MARK: - UpperTabItemDelegate
extension PagerViewController: UpperTabItemDelegate {
    func upperTabItemDidSelect(_ sender: UpperTabItem) {
        guard let index = upperTabsView.arrangedSubviews.index(of: sender) else {
            return
        }
        currentContentVC = dataSource?.pagerViewController(self, viewControllerForPageAt: index)
        if let currentContentVC = currentContentVC {
            pageViewController.setViewControllers(
                [currentContentVC],
                direction: .forward,
                animated: false,
                completion: nil
            )
            moveIndicatorBar(to: CGFloat(index))
        }
    }
}
