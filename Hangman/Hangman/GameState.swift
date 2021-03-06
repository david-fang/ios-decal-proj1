//
//  GameState.swift
//  Hangman
//
//  Created by David Fang on 2/20/17.
//  Copyright © 2017 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameState {

    var invalidAttempts: Int
    var phrase: String
    
    init(phrase: String) {
        self.invalidAttempts = 0
        self.phrase = phrase
    }

    /** Checks to see if the current game state is a win state */
    func isWinState(got displayedPhrase: String, expected phrase: String) -> Bool {
        var rawDisplayedPhrase = ""
        let wordArray = displayedPhrase.components(separatedBy: "\r")
        
        for wordInd in 0..<wordArray.count {
            let word = wordArray[wordInd]
            rawDisplayedPhrase.append(word)
            
            if (wordInd < wordArray.count - 1) {
                rawDisplayedPhrase.append(" ")
            }
        }
     
        return rawDisplayedPhrase == phrase
    }

    /** Checks to see if the current game state is a lose state */
    func isLoseState(got displayedPhrase: String, expected phrase: String) -> Bool {
        return self.invalidAttempts == 6
    }

    /** Checks to see if CHAR is a valid character in the phrase */
    func isValidLetter(char: Character) -> Bool {
        return self.phrase.contains("\(char)")
    }

    /** Increments the number of user attempts by one */
    func incrementInvalidAttempts() {
        self.invalidAttempts += 1
    }
    
    func getHangmanImg() -> UIImage? {
        switch invalidAttempts {
        case 0:
            return #imageLiteral(resourceName: "hangman1")
        case 1:
            return #imageLiteral(resourceName: "hangman2")
        case 2:
            return #imageLiteral(resourceName: "hangman3")
        case 3:
            return #imageLiteral(resourceName: "hangman4")
        case 4:
            return #imageLiteral(resourceName: "hangman5")
        case 5:
            return #imageLiteral(resourceName: "hangman6")
        case 6:
            return #imageLiteral(resourceName: "hangman7")
        default:
            print("Error: More than six invalid attempts were made")
            return nil
        }
    }
}

