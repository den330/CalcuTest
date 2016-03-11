//
//  operationSelectionController.swift
//  CalcuTest
//
//  Created by Yaxin Yuan on 2016-02-28.
//  Copyright © 2016 Yaxin Yuan. All rights reserved.
//

import UIKit

class operationSelectionController: UITableViewController,UINavigationControllerDelegate{
    var DictList: DataFile!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = self
        let index = DictList.operationNum
        if index != -1{
            let opera = DictList.OpeLst[index]
            DictList.flag = true
            performSegueWithIdentifier("showmainpage", sender: opera)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = cellForTableView(tableView)
        let index = indexPath.row
        cell.textLabel!.text = DictList.OpeLst[index].text
        return cell
    }
    
    func cellForTableView(tableView: UITableView) -> UITableViewCell {
        let cellIdentifier = "Cell"
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let calculator = DictList.OpeLst[indexPath.row]
        DictList.operationNum = indexPath.row
        performSegueWithIdentifier("showmainpage", sender: calculator)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let identifier = segue.identifier
        if identifier == "showmainpage"{
            let mainController = segue.destinationViewController as! CalcuViewController
            mainController.Cal = sender as! Calculator
            mainController.dictRec = DictList
           
        }else if identifier == "showhistory"{
            let mainController = segue.destinationViewController as! recordViewController
            mainController.dictRecord = DictList
        }else if identifier == "showschedule"{
            let mainController = segue.destinationViewController as!ScheduleTableViewController
            mainController.ItemToEdit = DictList.remin
        }
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if viewController === self{
            DictList.operationNum = -1
            if DictList.flag{
                DictList.flag = false
            }
        }
    }
}
