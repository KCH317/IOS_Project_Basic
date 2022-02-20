//
//  RoundButton.swift
//  Calculator
//
//  Created by 권찬호 on 2022/02/20.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {

    @IBInspectable var isRound: Bool = false {
        didSet{
            if isRound{
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }

}
