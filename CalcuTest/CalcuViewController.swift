//
//  ViewController.swift
//  CalcuTest
//
//  Created by Yaxin Yuan on 2016-02-28.
//  Copylower © 2016 Yaxin Yuan. All lowers reserved.
//

import UIKit

protocol Calrecord: class{
    func savetherecord(addRecord: Bool)
}

class CalcuViewController: UIViewController {
    var Cal = Calculator()
    var CorrectRecord = ["Right": 0, "Wrong": 0]
    weak var delegate: Calrecord?
    
    
    var indexrow: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        if indexrow == 0{
            operation.text = "X"
        }else if indexrow == 1{
            operation.text = "+"
        }else if indexrow == 2{
            operation.text = "/"
        }else{
            operation.text = "-"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var began = false
    var correctAns: Int!
    
    func operate(num1: Int, num2: Int) -> Int{
        var result = 0
        switch indexrow{
        case 0: result = Cal.multi(num1, num2: num2)
        case 1: result = Cal.add(num1, num2: num2)
        case 2: result = Cal.divi(num1, num2: num2)
        case 3: result = Cal.minus(num1, num2: num2)
        default: break
        }
        return result
    }
    
    @IBOutlet weak var operation: UILabel!
    @IBOutlet weak var upperLabel: UILabel!
    @IBOutlet weak var lowerLabel: UILabel!
    @IBOutlet weak var UserInput: UITextField!
    @IBOutlet weak var showRight: UILabel!
    
    @IBAction func begin() {
        if !began{
            let upper = (Int(arc4random_uniform(100) + 1))
            let lower = (Int(arc4random_uniform(100) + 1))
            correctAns = operate(upper, num2: lower)
            upperLabel.text = String(upper)
            lowerLabel.text = String(lower)
            began = true
        }
    }
    
    
    @IBAction func next() {
        if began {
            began = false
            begin()
        }
        print("\(CorrectRecord)")
    }
    
    @IBAction func userConfirm(sender: UIButton) {
        if began{
            if UserInput.text! == "\(correctAns)"{
                CorrectRecord["Right"]! += 1
                delegate?.savetherecord(true)
                showRight.text = "You are right"
            }else{
                CorrectRecord["Wrong"]! += 1
                delegate?.savetherecord(false)
                showRight.text = "You are wrong"
            }
        }else{
            showRight.text = "Click 'Begin' first please"
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let identifier = segue.identifier
        if identifier == "showrecord"{
            let recordContro = segue.destinationViewController as! recordViewController
            recordContro.recordLst = CorrectRecord
        }
    }
}

