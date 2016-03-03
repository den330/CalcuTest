//
//  operationSelectionController.swift
//  CalcuTest
//
//  Created by Yaxin Yuan on 2016-02-28.
//  Copyright © 2016 Yaxin Yuan. All rights reserved.
//

import UIKit

class operationSelectionController: UITableViewController, Calrecord {
    var DictList: DataFile!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showmainpage", sender: indexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let identifier = segue.identifier
        if identifier == "showmainpage"{
            let mainController = segue.destinationViewController as! CalcuViewController
            mainController.indexrow = sender as! Int
            mainController.delegate = self
        }else if identifier == "showhistory"{
            let mainController = segue.destinationViewController as! recordViewController
            mainController.recordLst = DictList.CorrectLst
        }
    }
    
    func savetherecord(addRecord:Bool){
        if addRecord{
            DictList.CorrectLst["Correct"]! += 1
        }else{
            DictList.CorrectLst["False"]! += 1
        }
    }
    
    @IBAction func clearHist(sender: UIBarButtonItem) {
        DictList.clearHist()
    }
    
    
}
