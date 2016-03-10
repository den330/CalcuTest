//
//  ViewController.swift
//  CalcuTest
//
//  Created by Yaxin Yuan on 2016-02-28.
//  Copylower © 2016 Yaxin Yuan. All lowers reserved.
//

import UIKit



class CalcuViewController: UIViewController {
    var Cal: Calculator!
    var dictRec: DataFile!
    var correctAns: Int!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        operation.text = Cal.text
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
    

    
    @IBOutlet weak var operation: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var UserInput: UITextField!
    @IBOutlet weak var showRight: UILabel!
    
    func begin() {
            dictRec.randomize()
            let leftNum = dictRec.Numlst["leftNum"]!
            let rightNum = dictRec.Numlst["rightNum"]!
            correctAns = Cal.calCu(leftNum, num2: rightNum)
            leftLabel.text = String(leftNum)
            rightLabel.text = String(rightNum)
    }
    
    
    @IBAction func next() {
        begin()
        UserInput.text = ""
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
}
    


