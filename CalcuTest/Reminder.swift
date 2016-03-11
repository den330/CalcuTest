//
//  Reminder.swift
//  CalcuTest
//
//  Created by Yaxin Yuan on 16/3/11.
//  Copyright © 2016年 Yaxin Yuan. All rights reserved.
//

import Foundation
import UIKit

class Reminder: NSObject, NSCoding{
    var dueDate = NSDate()
    var shouldRemind = false
    let text = "Time to Calculate!"
    
    required init?(coder aDecoder: NSCoder){
        dueDate = aDecoder.decodeObjectForKey("DueDate") as! NSDate
        shouldRemind = aDecoder.decodeBoolForKey("ShouldRemind")
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(dueDate, forKey: "DueDate")
        aCoder.encodeBool(shouldRemind, forKey: "ShouldRemind")
    }
    
    override init(){
        super.init()
    }
    
    func scheduleNotification(){
        let existingNotification = notificationForThisItem()
        if let notification = existingNotification{
            UIApplication.sharedApplication().cancelLocalNotification(notification)
        }
        if shouldRemind && dueDate.compare(NSDate()) != .OrderedAscending{
            let localNotification = UILocalNotification()
            localNotification.fireDate = dueDate
            localNotification.timeZone = NSTimeZone.defaultTimeZone()
            localNotification.alertBody = text
            localNotification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        }
    }
    
    func notificationForThisItem() -> UILocalNotification?{
        let allNotifications = UIApplication.sharedApplication().scheduledLocalNotifications!
        for notification in allNotifications{
            return notification
        }
        return nil
    }
    
    deinit{
        if let notification = notificationForThisItem(){
            UIApplication.sharedApplication().cancelLocalNotification(notification)
        }
    }
    
    
}