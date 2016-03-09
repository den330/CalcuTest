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
    var Numlst = ["leftNum": 0, "rightNum": 0]
    var flag = false
    var OpeLst = [Calculator(text: "+"), Calculator(text: "-"), Calculator(text: "*"), Calculator(text: "/")]
   
    
    var operationNum: Int{
        get{
            return NSUserDefaults.standardUserDefaults().integerForKey("Operation")
        }
        set{
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "Operation")
        }
    }
    
    init(){
        load("history.plist", key: "history")
        load("number.plist", key: "num")
        registerDefaults()
    }
    
    func randomize(){
        Numlst["leftNum"] = (Int(arc4random_uniform(100) + 1))
        Numlst["rightNum"] = (Int(arc4random_uniform(100) + 1))
    }
    
    func load(filename: String, key: String){
        let path = dataFilePath(filename)
        if NSFileManager.defaultManager().fileExistsAtPath(path){
            if let data = NSData(contentsOfFile: path){
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                if filename == "history.plist"{
                    CorrectLst = unarchiver.decodeObjectForKey(key) as! [String: Int]
                }else{
                    Numlst = unarchiver.decodeObjectForKey(key) as! [String: Int]
                }
                unarchiver.finishDecoding()
            }
        }
    }
    
    func documentDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    
    func dataFilePath(filename: String) -> String{
        return (documentDirectory() as NSString).stringByAppendingPathComponent(filename)
    }
    
    func save(filename: String, key: String, lst: [String:Int]){
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(lst, forKey: key)
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(filename), atomically: true)
    }
    
    func clearHist(){
        CorrectLst["Correct"] = 0
        CorrectLst["False"] = 0
        save("history.plist", key:"history", lst: CorrectLst)
    }
    
    func registerDefaults(){
        let dictionary = ["Operation" : -1]
        NSUserDefaults.standardUserDefaults().registerDefaults(dictionary)
    }
    
}
