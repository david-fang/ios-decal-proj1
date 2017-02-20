//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    
    var curPhraseIndex = 0;
    @IBOutlet weak var phraseLabel: UILabel!
    
    let hangmanPhrases = HangmanPhrases()
    var curPhrase: String! {
        didSet {
            self.phraseLabel.text = parseAndDisplay()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Generate a random phrase for the user to guess
        self.curPhrase = self.hangmanPhrases.getRandomPhrase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func parseAndDisplay() -> String {
        var initLabel = ""
        let wordArray = self.curPhrase.components(separatedBy: " ")
        self.phraseLabel.numberOfLines = wordArray.count
        
        for word in wordArray {
            for _ in 0..<word.characters.count {
                initLabel.append("-")
            }
            initLabel.append("\r")
        }

        return initLabel
    }

    // MARK: - Alphakeyboard Handling
    
    @IBAction func checkLetter(_ sender: AlphaButton) {
        sender.disableButton()
    }
    
    
    
    @IBAction func refresh(_ sender: Any) {
        self.curPhrase = hangmanPhrases.getNextPhrase(ind: curPhraseIndex)
        print(self.curPhrase)
        curPhraseIndex += 1
    }
}
