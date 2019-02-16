# Application Name
Hangman

# Course
Hacking with Swift

# Education supplier
This iOS app is developed as a "self challenge" project in the iBook tutorial "Hacking with Swift" which forms part of the "Hacking with Swift" tutorial series, authored by Paul Hudson. Self challenges are apps developed from scratch, solo and un-assisted. The requirements are provided by the instructor in text base, list form. Some helpful hints are sometimes provided.

# Project Type
Self challenge

# Topics / milestones

- UIKit 

- UI View Tags (subview.tag)

- UIAlertController

- String .components

- String .append

- String .uppercased

- String .contains

- [String] .enumerated

- String .joined

- Git / Github

# Project goals / instructions

•  The challenge is this: make a hangman game using UIKit. As a reminder, this means choosing a random word from a list of possibilities, but presenting it to the user as a series of underscores. So, if your word was “RHYTHM” the user would see “??????”. The user can then guess letters one at a time: if they guess a letter that it’s in the word, e.g. H, it gets revealed to make “?H??H?”; if they guess an incorrect letter, they inch closer to death. If they seven incorrect answers they lose, but if they manage to spell the full word before that they win.
• That’s the game: can you make it? Don’t underestimate this one – it’s called a challenge for a reason – it’s supposed to stretch you!
• The main complexity you’ll come across is that Swift has a special data type for individual letters, called Character. It’s easy to create strings from characters and vice versa, but you do need to know how it’s done.
• First, the individual letters of a string are accessible simply by treating the string like an array – it’s a bit like an array of Character objects that you can loop over, or read its count property, just like regular arrays. When you write for letter in word, the letter constant will be of type Character, so if your usedLetters array contains strings you will need to convert that letter into a string, like this:
let strLetter = String(letter)

Note: unlike regular arrays, you can’t read letters in strings just by using their integer positions
– they store each letter in a complicated way that prohibits this behavior.

• Once you have the string form of each letter, you can use contains() to check whether it’s
inside your usedLetters array.
• That’s enough for you to get going on this challenge by yourself.

</br> <strong> Additional hints: </strong> </br>
As per usual there are some hints below, but it’s always a good idea to try it yourself before reading them:
• You already know how to load a list of words from disk and choose one, because that’s exactly what we did in tutorial 5.
• You know how to prompt the user for text input, again because it was in tutorial 5. Obviously this time you should only accept single letters rather than whole words – use someString.characters.count for that.
• You can display the user’s current word and score using the title property of your view controller.
• You should create a usedLetters array as well as a wrongAnswers integer.
• When the player wins or loses, use UIAlertController to show an alert with a message.

Still stuck? Here’s some example code you might find useful:

let word = "RHYTHM"
var usedLetters = ["R", "T"]
var promptWord = ""
for letter in word.characters {
   let strLetter = String(letter)
   if usedLetters.contains(strLetter) {
      promptWord += strLetter
   } else {
      promptWord += "?"
} }
print(promptWord)

# Stretch goals
Some features included are not part of the guided project, but are added as stretch goals. Stretch goals apply learned knowledge to accomplish and are completed unassisted. Stretch goals may either be suggested by the teaching instructor or self imposed. Strecth goals / features implemented (if any) will be listed here.

- Use subview.tag to create an array of alphabet letter buttons and deactivate letter buttons once letter is pressed (self-imposed)

# Completed
December, 2018

# Deployment information
- <strong>Deployment Target (iOS version): </strong>12.1 and higher
- <strong>Supported Devices: </strong>Universal
- <strong>Optimized for: </strong>iPad
