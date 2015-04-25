//
//  ViewController.swift
//  ticTacToe
//
//  Created by Scott Yoshimura on 4/10/15.
//  Copyright (c) 2015 west coast dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //for this app we need an outlet and a action for each possible tile
    //we also need to describe the behavior of the game
    
    //let's start describing the logic of the game
        //activePlayer 1 = circles, activePlayer 2 = crosses
        //we are going to use activePlayer to describe the position of each player relative to the board
    //initialize activePlayer with value 1(player 1)
    var activePlayer = 1
    
    var gameActive = true
    
    //with an array for gamestate, the board state is represented. when a button is pressed, we will update the game state with which user is occuping each space on the board game. and when a user selects a button, we know what tag is pressed, so  the gamesState array is aligned (by design) with the tags available, and then we update the gamestate array position with the active player number.
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    //let's create an array with lists of arrays of combinations
    var winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    //initialize the button
    @IBOutlet weak var btn: UIButton!
    
    //initialize the game won label
    @IBOutlet weak var lblGameWon: UILabel!
    
    //initalize the play again button
    @IBOutlet weak var btnPlayAgain: UIButton!
    
    //initialize the play again button press
    @IBAction func btnPlayAgainPressed(sender: AnyObject) {
        
        //we want to reset all the gamestate variables
        
        activePlayer = 1
        gameActive = true
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        
        //we want to get rid of the two labels
        lblGameWon.hidden = true
        btnPlayAgain.hidden = true
        
        //we will create the lblGameWon and put it 400 pixels to the left
        lblGameWon.center = CGPointMake(lblGameWon.center.x-400, lblGameWon.center.y)
        //we will create the btnPlayAgain and put it 400 pixels to the right
        btnPlayAgain.center = CGPointMake(btnPlayAgain.center.x-400, btnPlayAgain.center.y)
        
        //we want reset all the senders. we can access all the senders by referenceing their tags and setting hte image back to nil
            //lets start by creating a new variable type UIButton
            //then we can set the UIButton to represent a button with a certain tag by accessing the view and find a viewWithTag. Start with tag 0. and specifiy it is a UIButton. Force it to happen, we know that viewWithTag is a Button, then set the image of hte btn to i. Then set up a for loop.
        var btn : UIButton
        for var i = 0; i < 9; i++ {
            btn = view.viewWithTag(i) as! UIButton
            btn.setImage(nil, forState: .Normal)
        }
        
        
    }
    
    //give the button an action
    @IBAction func btnPress(sender: AnyObject) {
        //let's create the image to be updated after the press, and check to make sure that the gameState slot that aligns with the UIElement's tag is empty. remember, we are accessing the the button tag, using sender.tag 
        //also check to see if someone has not won the game
        if gameState[sender.tag] == 0 && gameActive == true{
            
            var image = UIImage()
            
            //we don't want to have to copy the code from above fro every button. so we can go into the storyboard properties and, and drag each representation of button to the btnPress function, and xcode will create an action for each.
            //we can go into the attributes for each button and assign it a tag. and because it is tagged we can figure out which one is being pressed.
            //sender is the UI element that is the cause of the action to take place.
            gameState[sender.tag] = activePlayer

            if activePlayer == 1{
                //now we need to alter the variable btn,
               
                image = UIImage(named: "nought.png")!
                activePlayer = 2
            } else {
                //we need to force unwrap each of the images with ! *we know they are legit and there, so no worries here
                image = UIImage(named: "X.png")!
                activePlayer = 1
            }
            
       //sender is the UI element that has been tapped on that caused this function to take place. we can set the image to the image variable, and because buttons can have different states based on if they are pressed or not, we just want normal and use .Normal
            sender.setImage(image, forState: .Normal)
        
        //now we can start checking gameState to see if there are any winners
        // first we can check manually by seeing if gameState 0, 1, 2, (the first winning combination array value in winningCombinations) are not zero and are all the same value
            //if gameState[0] != 0 && gameState[0] == gameState[1] && gameState[1] == gameState[2] than we have a winner
            //but we want to do this without having to check manually, so we wnat to loop through winningCombinations:
                //note combinationNumber[0],[1],[2] represent the first three numbers in the array values of winningCombinations
                    //combinationNumber[0] represents the first number in the array values of winningCombinations
                    //combinationNumber[1] represents the second number in the array values of winningCombinations
                    //combinationsNumber[2] represents the third number in the array values of winningCombinations
                //**we are checking to see if the values in each array value of winningCombinations align with a winning combination in winningCombinations
            for combinationNumber in winningCombinations{
                if gameState[combinationNumber[0]] != 0 && gameState[combinationNumber[0]] == gameState[combinationNumber[1]] && gameState[combinationNumber[1]] == gameState[combinationNumber[2]]
                    //if the first number in gameState is not zero, and the second and third number are the same as the first
                    {
                        var lblText = "circles have won!"
                        
                        if gameState[combinationNumber[0]]==2{
                            lblText = "crosses have won!"
                            println(combinationNumber)
                        }
                        
                        lblGameWon.text = lblText
                        
                    //now that someone has won the game, let's bring in the lblGameWon and btnPlayAgain
                        //we will bring it in in a half a second, with +400 pixels
                    
                        lblGameWon.hidden = false
                        btnPlayAgain.hidden = false
                        
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.lblGameWon.center = CGPointMake(self.lblGameWon.center.x+400, self.lblGameWon.center.y)
                        self.btnPlayAgain.center = CGPointMake(self.btnPlayAgain.center.x+400, self.btnPlayAgain.center.y)
                    })
                    
                    gameActive = false
                }
            }
        //we can access the tag, by using sender.tag

        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblGameWon.hidden = true
        btnPlayAgain.hidden = true
        
        //we will create the lblGameWon and put it 400 pixels to the left
        lblGameWon.center = CGPointMake(lblGameWon.center.x-400, lblGameWon.center.y)
        //we will create the btnPlayAgain and put it 400 pixels to the right
        btnPlayAgain.center = CGPointMake(btnPlayAgain.center.x-400, btnPlayAgain.center.y)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //the below function is called when everything is created but not yet displayed to the user
    override func viewDidLayoutSubviews() {

    }

}

