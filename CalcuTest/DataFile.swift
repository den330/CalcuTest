//
//  DataFile.swift
//  CalcuTest
//
//  Created by Yaxin Yuan on 2016-03-02.
//  Copyright © 2016 Yaxin Yuan. All rights reserved.
//

import Foundation

class DataFile{
    var CorrectLst = ["Correct":0, "False": 0]
    
    init(){
        loadHist()
        registerDefaults()
    }
    
    func loadHist(){
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path){
            if let data = NSData(contentsOfFile: path){
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                CorrectLst = unarchiver.decodeObjectForKey("history") as! [String: Int]
                unarchiver.finishDecoding()
            }
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
        archiver.encodeObject(CorrectLst, forKey: "history")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func clearHist(){
        CorrectLst["Correct"] = 0
        CorrectLst["False"] = 0
        saveCalrecord()
    }
    
    func registerDefaults(){
        let dictionary = ["Operation" : -1]
        NSUserDefaults.standardUserDefaults().registerDefaults(dictionary)
    }
    
}
