//
//  ViewController.swift
//  Pager
//
//  Created by Yoshikuni Kato on 11/26/17.
//  Copyright © 2017 Yoshikuni Kato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let vc = UIStoryboard(
            name: String(describing: PagerViewController.self),
            bundle: nil
            )
            .instantiateInitialViewController() as? PagerViewController else {
                return
        }

        let vc1 = UIViewController()
        vc1.title = "vc1"
        vc1.view.backgroundColor = .red
        let vc2 = UIViewController()
        vc2.title = "vc2"
        vc2.view.backgroundColor = .blue
        let vc3 = UIViewController()
        vc3.title = "vc3"
        vc3.view.backgroundColor = .green

        let dataSource = PagerContentViewControllers(contentViewControllers: [vc1, vc2, vc3])
        vc.dataSource = dataSource

        addChildViewController(vc)
        containerView.addFilledSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }
}
