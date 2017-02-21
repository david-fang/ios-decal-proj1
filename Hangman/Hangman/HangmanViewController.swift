//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {


    @IBOutlet weak var hangmanImgView: UIImageView!
    @IBOutlet weak var phraseLabel: UILabel!
    @IBOutlet var alphaButtons: [AlphaButton]!
    

    let hangmanPhrases = HangmanPhrases()
    var gameState: GameState!

    let gameoverAlert = UIAlertController(title: "Default", message: "", preferredStyle: .alert)
    
    var dPhrase: String!
    var phrase: String! {
        didSet {
            self.phraseLabel.text = self.parsePhrase()
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "chalkboard"))
        gameoverAlert.addAction(UIAlertAction(title: "New Game", style: .default, handler: {(alert: UIAlertAction!) in self.newGame()}))
        newGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Game Logic Utils
    
    /** Starts a new game by reenabling all buttons in custom keyboard
        and creating a new GameState */
    private func newGame() {
        for btn in self.alphaButtons {
            btn.enableButton()
        }
        
        hangmanImgView.image = #imageLiteral(resourceName: "hangman1")
        
        self.phrase = self.hangmanPhrases.getRandomPhrase()
        self.gameState = GameState(phrase: self.phrase)
    }

    /** If the current state is a winning state, show the win popup */
    private func checkForWin() {
        if (self.gameState.isWinState(got: self.dPhrase, expected: self.phrase)) {
            gameoverAlert.title = "You've won!"
            gameoverAlert.message = winMessage
            self.present(gameoverAlert, animated: true)
        }
    }

    /** If the current state is a winning state, show the loss popup */
    private func checkForLoss() {
        if (self.gameState.isLoseState(got: self.dPhrase, expected: self.phrase)) {
            gameoverAlert.title = "You've lost..."
            gameoverAlert.message = loseMessage
            self.present(gameoverAlert, animated: true)
        }
    }


    /** Checks if SELECTED CHAR exists in the given phrase. If so, updates
        the phrase label. If not, updates the hangman image. After update,
        checks to see if the user has guessed the phrase or lost the game. */
    private func checkLetter(selectedChar: Character) {
        if gameState.isValidLetter(char: selectedChar) {
            updateDisplayedPhrase(char: selectedChar)
            checkForWin()
        } else {
            self.gameState.incrementInvalidAttempts()
            updateHangmanImg()
            checkForLoss()
        }
    }


    /** Parses the newly generated phrase and replaces all spaces
     with a carriage return */
    private func parsePhrase() -> String {
        var initLabel = ""
        let wordArray = self.phrase.components(separatedBy: " ")
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

        self.dPhrase = initLabel
        return initLabel
    }


    // MARK: - Label and Image Updating Utils


    /** Updates the hangman image appropriately, based on the number of player's
        invalid attempts */
    private func updateHangmanImg() {
        switch gameState.invalidAttempts {
        case 0:
            hangmanImgView.image = #imageLiteral(resourceName: "hangman1")
        case 1:
            hangmanImgView.image = #imageLiteral(resourceName: "hangman2")
        case 2:
            hangmanImgView.image = #imageLiteral(resourceName: "hangman3")
        case 3:
            hangmanImgView.image = #imageLiteral(resourceName: "hangman4")
        case 4:
            hangmanImgView.image = #imageLiteral(resourceName: "hangman5")
        case 5:
            hangmanImgView.image = #imageLiteral(resourceName: "hangman6")
        case 6:
            hangmanImgView.image = #imageLiteral(resourceName: "hangman7")
        default:
            print("ERROR: Invalid attempts went over 6")
        }
    }


    /** Changes all indices that are hiding CHAR to display CHAR */
    private func updateDisplayedPhrase(char: Character) {
        for i in 0..<self.phrase.characters.count {
            if self.phrase[i] == char {
                let index: String.Index = self.phrase.index(phrase.startIndex, offsetBy: i)
                updateCharAt(index, char)
            }
        }
    
        self.phraseLabel.text = self.dPhrase
    }

    /** Updates the text displayed in the phrase label by replacing the
        current character at INDEX with CHAR */
    private func updateCharAt(_ index: String.Index, _ char: Character) {
        self.dPhrase.remove(at: index)
        self.dPhrase.insert(char, at: index)
    }


    // MARK: - Alphakeyboard Handling


    /** Handles user selection for custom keyboard */
    @IBAction func userSelectedLetter(_ sender: AlphaButton) {
        sender.disableButton()
        checkLetter(selectedChar: sender.getLetter()!)
    }


    /** For UI testing purposes only; removed prior to release */
    @IBAction func refresh(_ sender: Any) {
        newGame()
    }
}



