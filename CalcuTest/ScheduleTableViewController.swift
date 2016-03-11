//
//  ScheduleTableViewController.swift
//  CalcuTest
//
//  Created by Yaxin Yuan on 16/3/11.
//  Copyright © 2016年 Yaxin Yuan. All rights reserved.
//

import UIKit



class ScheduleTableViewController: UITableViewController {
    @IBOutlet weak var shouldRemindSwitch: UISwitch!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerCell: UITableViewCell!
    
   
    
    
    var dueDate = NSDate()
    var ItemToEdit: Reminder?
    var datePickerVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = ItemToEdit{
            shouldRemindSwitch.on = item.shouldRemind
            dueDate = item.dueDate
        }
        updateDueDateLabel()
    }
    
    func updateDueDateLabel(){
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .ShortStyle
        dueDateLabel.text = formatter.stringFromDate(dueDate)
    }
    
    @IBAction func done(){
        if let item = ItemToEdit{
            item.shouldRemind = shouldRemindSwitch.on
            item.dueDate = dueDate
            item.scheduleNotification()
        }
    }
    
    func showDatePicker(){
        datePickerVisible = true
        let indexPathDateRow = NSIndexPath(forRow: 1, inSection: 0)
        let indexPathDatePicker = NSIndexPath(forRow: 2, inSection: 0)
        

        
        tableView.beginUpdates()
        
        tableView.insertRowsAtIndexPaths([indexPathDatePicker], withRowAnimation: .Fade)
        tableView.reloadRowsAtIndexPaths([indexPathDateRow], withRowAnimation: .None)
        
        tableView.endUpdates()
        
        
        datePicker.setDate(dueDate, animated: false)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 2{
            return datePickerCell
        }else{
            return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 && datePickerVisible{
            return 3
        }else{
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 2{
            return 217
        }else{
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0 && indexPath.row == 1{
            if !datePickerVisible{
                showDatePicker()
            }else{
                hideDatePicker()
            }
        }
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if indexPath.section == 0 && indexPath.row == 1{
            return indexPath
        }else{
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, var indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        if indexPath.section == 0 && indexPath.row == 2{
            indexPath = NSIndexPath(forRow: 0, inSection: indexPath.section)
        }
        return super.tableView(tableView, indentationLevelForRowAtIndexPath: indexPath)
    }
    
    @IBAction func dateChanged(datePicker: UIDatePicker){
        dueDate = datePicker.date
        updateDueDateLabel()
    }
    
    func hideDatePicker(){
        if datePickerVisible{
            datePickerVisible = false
        }
        let indexPathDatePicker = NSIndexPath(forRow: 2, inSection: 0)
        tableView.deleteRowsAtIndexPaths([indexPathDatePicker], withRowAnimation: .Fade)
    }
    
    @IBAction func shouldRemindToggled(switchControl: UISwitch){
        if switchControl.on{
            let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Sound], categories: nil)
            UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        }
    }
    


}
