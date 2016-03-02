//
//  operationSelectionController.swift
//  CalcuTest
//
//  Created by Yaxin Yuan on 2016-02-28.
//  Copyright © 2016 Yaxin Yuan. All rights reserved.
//

import UIKit

class operationSelectionController: UITableViewController, Calrecord {
    var historyList = ["Correct": 0, "False": 0]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder:aDecoder)
        loadHist()
    }
    
    func loadHist(){
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path){
            if let data = NSData(contentsOfFile: path){
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                historyList = unarchiver.decodeObjectForKey("history") as! [String: Int]
                unarchiver.finishDecoding()
            }
        }
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
            mainController.recordLst = historyList
        }
    }
    
    func documentDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    
    func dataFilePath() -> String{
        return (documentDirectory() as NSString).stringByAppendingPathComponent("history.plist")
    }
    
    func saveCalrecord(){
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(historyList, forKey: "history")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func savetherecord(addRecord:Bool){
        if addRecord{
            historyList["Correct"]! += 1
        }else{
            historyList["False"]! += 1
        }
        saveCalrecord()
    }


}
