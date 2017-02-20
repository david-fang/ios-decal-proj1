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
    }
    
    func enableButton() {
        self.isEnabled = true
    }
    
    func getLetter() -> Character? {
        return self.titleLabel?.text?.characters.first
    }
}
