//
//  recordViewController.swift
//  CalcuTest
//
//  Created by Yaxin Yuan on 2016-02-29.
//  Copyright © 2016 Yaxin Yuan. All rights reserved.
//

import UIKit

protocol dataClear:class{
    func clear()
}

class recordViewController: UIViewController {
    weak var delegate: dataClear?
    @IBOutlet weak var recordLabel: UILabel!
    
    var recordLst = [String:Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        recordLabel.text = "\(recordLst)"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearHist() {
        delegate?.clear()
        recordLabel.text = "['False' : 0, 'Correct': 0]"
    }

    
    


}
