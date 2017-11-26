//
//  UIView+FillConstraints.swift
//  Pager
//
//  Created by Yoshikuni Kato on 11/26/17.
//  Copyright © 2017 Yoshikuni Kato. All rights reserved.
//

import UIKit

extension UIView {

    private func addFillConstraints(_ addedView: UIView) {
        addedView.translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: addedView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: addedView.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: addedView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: addedView.trailingAnchor).isActive = true
    }

    func addFilledSubview(_ view: UIView) {
        addSubview(view)
        addFillConstraints(view)
    }

    func insertFilledSubview(_ view: UIView, belowSubview siblingSubview: UIView) {
        insertSubview(view, belowSubview: siblingSubview)
        addFillConstraints(view)
    }
}
