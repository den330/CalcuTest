//
//  ViewController.swift
//  CalcuTest
//
//  Created by Yaxin Yuan on 2016-02-28.
//  Copylower © 2016 Yaxin Yuan. All lowers reserved.
//

import UIKit



class CalcuViewController: UIViewController {
    var Cal = Calculator()
    var dictRec: DataFile!
    var correctAns: Int!
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
        if dictRec.flag{
            leftLabel.text = String(dictRec.Numlst["leftNum"]!)
            rightLabel.text = String(dictRec.Numlst["rightNum"]!)
        }else{
            begin()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var UserInput: UITextField!
    @IBOutlet weak var showRight: UILabel!
    
    func begin() {
            dictRec.randomize()
            let leftNum = dictRec.Numlst["leftNum"]!
            let rightNum = dictRec.Numlst["rightNum"]!
            correctAns = operate(leftNum, num2: rightNum)
            leftLabel.text = String(leftNum)
            rightLabel.text = String(rightNum)
    }
    
    
    @IBAction func next() {
        begin()
    }
    
    @IBAction func userConfirm(sender: UIButton) {
            if UserInput.text! == "\(correctAns)"{
                dictRec.CorrectLst["Correct"]! += 1
                showRight.text = "You are right"
            }else{
                dictRec.CorrectLst["False"]! += 1
                showRight.text = "You are wrong"
            }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let identifier = segue.identifier
        if identifier == "showrecord"{
            let controller = segue.destinationViewController as! recordViewController
            controller.dictRecord = dictRec
        }
    }
}

