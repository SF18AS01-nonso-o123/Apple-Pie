//
//  ViewController.swift
//  Apple Pie
//
//  Created by Chinonso Obidike on 1/24/19.
//  Copyright © 2019 Chinonso Obidike. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var treeImage: UIImageView!
    
    //MARK: - Define variables
    var listOfWords: [String] = [
    "apple", "orange", "grape", "lemon", "cake",
    "skating", "hiking", "reading", "soccer", "basketball",
    "swimming", "table", "chair", "pantry", "grocery", "shopping",
    "skyscraper", "shower", "bathingsuit", "education", "math",
    "physics", "programming", "biology", "sociology", "beach"
    ]
    
    var incorrectMovesAllowed: Int = 7
    var totalWins: Int = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses: Int = 0 {
        didSet {
            newRound()
        }
    }
    var currentGame: Game!
    
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newRound()
        updateUI()
      
    }
    
    
    //MARK: - Other Functions
    //Buttons function
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        if let letterString: String = sender.title(for: .normal){
            let letter: Character = Character(letterString.lowercased())
            currentGame.playerGuessed(letter: letter)
            updateGameState()
            updateUI()
        }
    }
    
    
    //New round
    func newRound() {
        if !listOfWords.isEmpty{
        let newWord: String = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
        updateUI()
        }else{
            enableLetterButtons(false)
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedText{
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        correctLabel.text = wordWithSpacing
        treeImage.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    
    func updateGameState(){
         print("Line 93 was executed.")
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        }else if currentGame.word == currentGame.formattedText {
            totalWins += 1
           
        }else {
            updateUI()
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
}

