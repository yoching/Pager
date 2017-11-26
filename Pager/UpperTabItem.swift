//
//  UpperTabItem.swift
//  Pager
//
//  Created by Yoshikuni Kato on 11/26/17.
//  Copyright © 2017 Yoshikuni Kato. All rights reserved.
//

import UIKit

protocol UpperTabItemDelegate: class {
    func upperTabItemDidSelect(_ sender: UpperTabItem)
}

final class UpperTabItem: UIView {

    weak var delegate: UpperTabItemDelegate?

    @IBOutlet weak var button: UIButton!

    @IBAction func buttonTapped(_ sender: AnyObject) {
        delegate?.upperTabItemDidSelect(self)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    fileprivate func commonInit() {
        let nib = UINib(nibName: "UpperTabItem", bundle: nil)
        guard let viewFromXib = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        addFilledSubview(viewFromXib)
    }

    func configure(name: String?) {
        button.setTitle(name, for: UIControlState())
    }

}
