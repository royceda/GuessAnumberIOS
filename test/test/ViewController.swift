//
//  ViewController.swift
//  test
//
//  Created by Da on 5/6/16.
//  Copyright © 2016 Da. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var rangeLbl: UILabel!
    @IBOutlet weak var numberTxtField: UITextField!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var numGuessesLbl: UILabel!
    
    private var lb = 0;
    private var ub = 100;
    private var num = 0;
    private var secret = 0;
    
    @IBAction func onOkPressed(sender: AnyObject){
        let number = Int(numberTxtField.text!)
        if let number = number{
            selectedNumber(number);
        } else {
            var alert = UIAlertController(title: nil, message: "Entrez un nombre", preferredStyle: UIAlertControllerStyle.Alert);
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil));
            self.presentViewController(alert, animated: true, completion: nil);
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         numberTxtField.keyboardType = UIKeyboardType.NumberPad
        // Do any additional setup after loading the view, typically from a nib.
        numberTxtField.becomeFirstResponder()
        reset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//logic of the game
private extension ViewController{
    enum Comparison{
        case Smaller
        case Greater
        case Equals
    }
    
    func selectedNumber(number: Int){
        switch compareNumber(number, secret: secret){
        case .Smaller:
            lb = max(lb, number)
            messageLbl.text = "Trop petit \(secret)"
            numberTxtField.text = ""
            num += 1
            renderRange()
            renderNumGuesses()
        case .Greater:
            ub = min(ub, number)
            messageLbl.text = "Trop grand \(secret)"
            numberTxtField.text = ""
            num += 1
            renderRange()
        case .Equals:
            messageLbl.text = "Bien Joué \(secret)"
            //reset()
        }
    }
    
    func compareNumber(number: Int, secret: Int) -> Comparison{
        if number > secret {
            return .Greater
        }else if secret > number{
            return .Smaller
        }else if secret == number{
            return .Equals
        }
        return .Equals
    }
}


//render other label
 private extension ViewController{
    func extractSecretNumber(){
        let diff = ub - lb
        let randomNumber = Int(arc4random_uniform(UInt32(diff)))
        secret = randomNumber + Int(lb)
    }
    
    func renderRange(){
        rangeLbl.text = "\(lb) et \(ub)"
    }
    
    func renderNumGuesses(){
        numGuessesLbl.text = "\(num)"
    }
    
    func resetData(){
        lb = 0
        ub = 100
        secret = 0
    }
    
    func resetMsg(){
        messageLbl.text = " "
    }
    
    func reset(){
        resetData()
        renderRange()
        renderNumGuesses()
        extractSecretNumber()
        resetMsg()
    }
}

