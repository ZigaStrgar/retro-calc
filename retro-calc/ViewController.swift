//
//  ViewController.swift
//  retro-calc
//
//  Created by Žiga Strgar on 23. 06. 16.
//  Copyright © 2016 Žiga Strgar. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String{
        case Devide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl : UILabel!
    
    var btnSound: AVAudioPlayer!
    
    
    var runningNumber = ""
    var leftVal = ""
    var rightVal = ""
    var result = ""
    var currentOperation: Operation = Operation.Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let ex as NSError{
            print(ex.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOpearation(Operation.Devide)
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOpearation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOpearation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOpearation(Operation.Add)
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        processOpearation(currentOperation)
    }
    
    func processOpearation(op: Operation){
        playSound()
        
        if currentOperation != Operation.Empty{
            // Do math
            rightVal = runningNumber
            
            if runningNumber != "" {
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftVal)! * Double(rightVal)!)"
                } else if currentOperation == Operation.Devide {
                    result = "\(Double(leftVal)! / Double(rightVal)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftVal)! - Double(rightVal)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftVal)! + Double(rightVal)!)"
                }
            }
            
            runningNumber = ""
            leftVal = result
            currentOperation = op
            
            outputLbl.text = result
        } else {
            // First time an operator has been pressed
            leftVal = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        runningNumber = ""
        leftVal = ""
        rightVal = ""
        result = ""
        currentOperation = Operation.Empty
    }

    
    func playSound(){
        if btnSound.playing{
            btnSound.play()
        }
        
        btnSound.play()
    }
    

}

