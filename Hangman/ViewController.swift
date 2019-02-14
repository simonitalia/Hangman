//
//  ViewController.swift
//  Challenge9App
//
//  Created by Simon Italia on 12/14/18.
//  Copyright © 2018 SDI Group Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Storyboard / UI outlets
    @IBOutlet weak var wordLengthLabel: UILabel!
    @IBOutlet weak var lettersSubmittedTextField: UITextField!
    @IBOutlet weak var guessesRemainingLabel: UILabel!
    
    //MARK: Properties
    var letterButtons = [UIButton]()
    var letterButtonsSubmitted = [UIButton]()
    
    //Randomly fetched word user needs to guess
    var wordToGuess = String()
    
    //Random word represented as an array of letters
    var wordToGuessLetters = [String]()
    
    //Masked word as an array of Letters
    var maskedWordLetters = [String]() {
        didSet {
            if maskedWordLetters == wordToGuessLetters {
                gameInProgress = false
            }
        }
    }
    
    //Masked word as String (constructed from maskedWordLetters String)
    var maskedWord = String()
    
    //Store letters submitted not contained in guess word
    var incorrectLetters = [String]()
    
    //Guesses user has left before losing
    var guessesRemaining = 7 {
        didSet {
            //Update guesses remaining label
            guessesRemainingLabel.text = "Guesses remaining before being HANGED: \(guessesRemaining)"
            
            if guessesRemaining == 0 {
                gameInProgress = false
            }
        }
    }
    
    //Flag to track when game ends
    var gameInProgress = true {
        didSet {
            
            if gameInProgress == false {
                endGame()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Start Game
        getRandomWord()
        
        //Map all alphabet letters from file to letter buttons in the view
        getLetterButtons()
        
        print("wordToGuess: \(wordToGuess)")
        print("wordToGuessLetters: \(wordToGuessLetters)")
        
        print("maskedWord: \(maskedWord)")
        print("maskedWordLetters: \(maskedWordLetters)")
        
    }//End viewDidLoad() method
    
    //MARK: Methods
    
    //Create the letterButtons, by assigning a letter to each button in the view
    func getLetterButtons() {
        
        for subview in view.subviews where subview.tag == 100 {
            let letterButton = subview as! UIButton
            letterButtons.append(letterButton)
            letterButton.addTarget(self, action: #selector(letterButtonTapped), for: .touchUpInside)
        }

    }//End of letterButtons() method
    
    //Display letter tapped in Text field, add it to an array to track
    @objc func letterButtonTapped(letterButton: UIButton) {
 
        //Handle if tapped letter is in word or not
        let letter = letterButton.titleLabel!.text!
        
        if wordToGuess.contains(letter) == true {
            
            for (index, letter) in wordToGuessLetters.enumerated() {
                if letterButton.titleLabel!.text! == letter {
                maskedWordLetters[index] = letter
                }
            }
            
            maskedWord = maskedWordLetters.joined(separator: ". ")
            
            print("maskedWordLetters: \(maskedWordLetters)")
            print("maskedWord: \(maskedWord)")
        
        } else if wordToGuess.contains(letter) == false {
            
            if incorrectLetters.contains(letter) == true {
               return
            }
            
            incorrectLetters.append(letter)
            guessesRemaining -= 1
            print("incorrectLetters: \(incorrectLetters)")

        }
        
        //Inactivate Button since it's been used
        letterButton.isEnabled = false
        
        //Show the corrrect letters
        lettersSubmittedTextField.text = maskedWord

    }// End of letterButtonTapped() method

    //Load word file from the file system
    func getRandomWord() {
        
        //Locate the file path on the file system
        if let wordFilePath = Bundle.main.path(forResource: "words", ofType: "txt") {
            
            //Load the contents of the file into one long String. Use try? to exit execution if nil is found
            if let wordFileContents = try? String(contentsOfFile: wordFilePath) {
                
                //Capitalize words
                let wordFileContentsCapitalized = wordFileContents.uppercased()
                
                //Place words from String object into an Array object, elements seperated by line break
                let allWordsCapitalized = wordFileContentsCapitalized.components(separatedBy: "\n")
                
                //Pull out a random word from allWordsArray
                wordToGuess = allWordsCapitalized.randomElement()!
                
                //Create an array containing wordToGuess letters
                for letter in wordToGuess {
                    
                    wordToGuessLetters.append(String(letter))
                }
                
                //Set the hint
                let wordLength = wordToGuess.count
                wordLengthLabel.text = "Hint: Word to guess has \(wordLength) letters"
                
                //Show word as masked at start of game
                for _ in 0..<wordLength {
                    maskedWord += "_ . "
                    maskedWordLetters.append("_")
                }
                
                lettersSubmittedTextField.text = maskedWord
                guessesRemainingLabel.text = "Guesses remaining before being HANGED: \(guessesRemaining)"
                
            //Error handling, if file loaded succesfully, but creating String object failed
            } else {
                print("Failed to load contents of words.txt file")
                failedToLoadAlert(errorMessage: "Failed to load contents of words.txt file")
                return
                
            }
            
        //Error handling if file loading failed
        } else {
            print("Failed to load words.txt file")
            failedToLoadAlert(errorMessage: "Failed to load words.txt file")
            return
        }

    }//End of loadWordsFile() method
    
    //Error handler if file failed to load, or a word failed to load
    func failedToLoadAlert(errorMessage: String) {
        
        //Create an error alert
        let errorAlert = UIAlertController(title: "Warning!", message: errorMessage, preferredStyle: .alert)
        
        //Display the error Alert
        present(errorAlert, animated: true)
    }
    
    //Handle when user wins or loses
    func endGame() {
        
        var alertTitle: String
        var alertMessage: String
        //var alertController: UIAlertController?
        
        //If user loses
        if guessesRemaining == 0 {
            alertTitle = "Oh Nooooo!"
            alertMessage = "You've been HANGED!! 💀"
            
            //Create an Alert
            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            
            //Add Dimiss alert action
            alertController.addAction(UIAlertAction(title: "Play again?", style: .default, handler: {
                action in self.startNewGame()
            }))
            
            //Display the Alert
            present(alertController, animated: true)
        }
        
        //If user wins
        if maskedWordLetters == wordToGuessLetters {
            alertTitle = "Phew!"
            alertMessage = "You survied getting HANGED! 🙏"
            
            //Create an Alert
            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            
            //Add Dimiss alert action
            alertController.addAction(UIAlertAction(title: "Play again?", style: .default, handler: {
                action in self.startNewGame()
            }))
            
            //Display the Alert
            present(alertController, animated: true)
        }
        
    } //End go endGame() method
    
    //Reset and Start new game
    func startNewGame() {

/*
        //Reset guesses remaining
        guessesRemaining = 7
        
        //Enable all LetterButtons
        for button in letterButtons {
            button.isEnabled = true
        }
        
        //Start new game
        viewDidLoad()
*/
    }
    
}
