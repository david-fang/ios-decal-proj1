//
//  AlphaButton.swift
//  Hangman
//
//  Created by David Fang on 2/17/17.
//  Copyright © 2017 Shawn D'Souza. All rights reserved.
//

import UIKit

class AlphaButton: UIButton {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(UIColor(red: 212/255, green: 175/255, blue: 55/255, alpha: 1.0), for: .disabled)
    }
    
    func disableButton() {
        self.isEnabled = false
    }
    
    func enableButton() {
        self.isEnabled = true
    }
    
    func getLetter() -> Character? {
        return self.titleLabel?.text?.characters.first
    }
}
