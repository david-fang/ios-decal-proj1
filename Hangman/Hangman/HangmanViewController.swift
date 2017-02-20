//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    
    
    @IBOutlet weak var phraseLabel: UILabel!
    @IBOutlet var alphaButtons: [AlphaButton]!

    let hangmanPhrases = HangmanPhrases()

    var displayedPhrase: String!
    var curPhrase: String! {
        didSet {
            self.phraseLabel.text = parsePhrase()
        }
    }
    
    // var curPhraseIndex = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Game Logic Utils
    
    private func newGame() {
        for btn in self.alphaButtons {
            btn.enableButton()
        }
        self.curPhrase = self.hangmanPhrases.getRandomPhrase()
    }
    
    private func checkForWin() {
        var rawDisplayedPhrase = ""
        let wordArray = self.displayedPhrase.components(separatedBy: "\r")
        
        for wordInd in 0..<wordArray.count {
            let word = wordArray[wordInd]
            rawDisplayedPhrase.append(word)
            
            if (wordInd < wordArray.count - 1) {
                rawDisplayedPhrase.append(" ")
            }
        }

        if (rawDisplayedPhrase == self.curPhrase) {
            print("You win!")
        }
    }
    
    /** Checks if SELECTEDCHAR exists in the given phrase. If so, updates
        the phrase label. If not, updates the hangman image. After update,
        checks to see if the user has guessed the phrase. */
    private func checkLetter(selectedChar: Character) {
        for i in 0..<self.curPhrase.characters.count {
            if self.curPhrase[i] == selectedChar {
                let index: String.Index = self.curPhrase.index(curPhrase.startIndex, offsetBy: i)
                updateCharAt(index, selectedChar)
            }
        }
        
        self.phraseLabel.text = self.displayedPhrase
        checkForWin()
    }
    
    // MARK: - UI Update Utils
    
    /** Parses the newly generated phrase and replaces all spaces
        with a carriage return */
    private func parsePhrase() -> String {
        var initLabel = ""
        let wordArray = self.curPhrase.components(separatedBy: " ")
        self.phraseLabel.numberOfLines = wordArray.count
        
        for wordInd in 0..<wordArray.count {
            let word = wordArray[wordInd]
            for _ in 0..<word.characters.count {
                initLabel.append("-")
            }
            
            if (wordInd != wordArray.count - 1) {
                initLabel.append("\r")
            }
        }

        self.displayedPhrase = initLabel
        return initLabel
    }

    /** Updates the text displayed in the phrase label by replacing the
        current character at INDEX with CHAR */
    private func updateCharAt(_ index: String.Index, _ char: Character) {
        self.displayedPhrase.remove(at: index)
        self.displayedPhrase.insert(char, at: index)
    }

    // MARK: - Alphakeyboard Handling
    
    /** Handles user selection for custom keyboard */
    @IBAction func userSelectedLetter(_ sender: AlphaButton) {
        sender.disableButton()
        checkLetter(selectedChar: sender.getLetter()!)
    }
    
    /** For UI testing purposes only; removed prior to release */
    @IBAction func refresh(_ sender: Any) {
        // self.curPhrase = hangmanPhrases.getNextPhrase(ind: curPhraseIndex)
        // print(self.curPhrase)
        // curPhraseIndex += 1
        newGame()
    }
}
