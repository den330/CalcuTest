//
//  recordViewController.swift
//  CalcuTest
//
//  Created by Yaxin Yuan on 2016-02-29.
//  Copyright © 2016 Yaxin Yuan. All rights reserved.
//

import UIKit



class recordViewController: UIViewController {
    var dictRecord: DataFile!
    @IBOutlet weak var recordLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordLabel.text = "\(dictRecord.CorrectLst)"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearHist() {
        dictRecord.clearHist()
        recordLabel.text = "\(dictRecord.CorrectLst)"
    }

    
    


}
