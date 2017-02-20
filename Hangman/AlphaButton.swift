//
//  AlphaButton.swift
//  Hangman
//
//  Created by David Fang on 2/17/17.
//  Copyright © 2017 Shawn D'Souza. All rights reserved.
//

import UIKit

class AlphaButton: UIButton {

    func disableButton() {
        self.isEnabled = false
        self.titleLabel?.textColor = UIColor.gray
    }
    
    func enableButton() {
        self.isEnabled = false
        self.titleLabel?.textColor = UIColor.blue       // change this to the new default
    }
    
    func getLetter() -> String? {
        return self.titleLabel?.text
    }
}
