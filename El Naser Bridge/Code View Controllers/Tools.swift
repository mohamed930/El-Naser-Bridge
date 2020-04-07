//
//  Tools.swift
//  El Naser Bridge
//
//  Created by Mohamed Ali on 2/13/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import CoreData
import FirebaseDatabase
import SVProgressHUD
import AVKit
import AVFoundation
import MessageUI

class Tools{
    
    // TODO: Mark This Sektion For Mutual Var.
    public static var ImgArr = ["arabic","en","logo","car","attention-logo-png-7","info"]
    public static var ColorArr = ["#F6F6EE","#1C6497","#FF0000","#5BFFDE","#00FF5D","#FFFFFF"]
    
    // TODO: Mark This Method For Creating Alert For User.
    public static func createAlert (Title:String , Mess:String , ob:UIViewController)
    {
        let alert = UIAlertController(title: Title , message:Mess
            , preferredStyle:UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title:"OK",style:UIAlertAction.Style.default,handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        ob.present(alert,animated:true,completion: nil)
    }
    
    // TODO: This Method For Getting Language Statue from CoreData.
    public static func setLanguage (Value:String , LanArray:Array<Language>) {
        
        LanArray[0].setValue(Value, forKey: "statue")
        ad.saveContext()
        
    }
    
    public static func getData (_ LanArray: inout Array<Language>) -> Array<Language> {
        let fetchrequest:NSFetchRequest<Language> = Language.fetchRequest()
        do {
            LanArray = try! context.fetch(fetchrequest)
        }
        return LanArray
    }
    
    // TODO: This Method Check if The Time inside two time different in 24 hour formate
    // ------------------------------------------
    public static func setCondtion(FH:Int , LH:Int , FM:Int , LM:Int , type:Date , type2:Date) -> Int {
        let calendar = Calendar.current
        let FirstDate = calendar.date(
            bySettingHour: FH,
            minute: FM,
            second: 0,
            of: type)!
        
        let LastDate = calendar.date(
            bySettingHour: LH,
            minute: LM,
            second: 0,
            of: type2)!
        
        if type >= FirstDate &&
            type <= LastDate
        {
            return 0
        }
        else {
            return 1
        }
    }
    // -----------------------------------------
    
    // TODO: This Method Git The Difference Betwean Two Times one of it Current and another we git it from developper
    public static func ENsetDfference (time2:String , TXTTime : UILabel) {
        // Get The Current Time Getting From Telephone
        let today = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mma"
        let now = dateFormatter.string(from: today as Date)
        
        let date1 = dateFormatter.date(from: now)!
        let date2 = dateFormatter.date(from: time2)!
        
        let elapsedTime = date2.timeIntervalSince(date1)
        
        // convert from seconds to hours, rounding down to the nearest hour
        var hours = floor(elapsedTime / 60 / 60)
        
        /* we have to subtract the number of seconds in hours from minutes to get
         the remaining minutes, rounding down to the nearest minute (in case you
         want to get seconds down the road) */
        var minutes = floor((elapsedTime - (hours * 60 * 60)) / 60)
        
        if Int(hours) < 0 {
            hours = hours + 24
            minutes = minutes - 2
        }
        
        if Int(hours) == 0 {
            TXTTime.text = "The Time Remain \(Int(minutes)) min"
        }
        else {
            TXTTime.text = "The Time Remain \(Int(hours)) hour, \(Int(minutes)) min"
        }
    }
    
    // TODO: This Method Git The Difference Betwean Two Times one of it Current and another we git it from developper
    public static func ARsetDfference (time2:String , TXTTime:UILabel) {
        // Get The Current Time Getting From Telephone
        let today = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mma"
        let now = dateFormatter.string(from: today as Date)
        
        let date1 = dateFormatter.date(from: now)!
        let date2 = dateFormatter.date(from: time2)!
        
        let elapsedTime = date2.timeIntervalSince(date1)
        
        // convert from seconds to hours, rounding down to the nearest hour
        var hours = floor(elapsedTime / 60 / 60)
        
        /* we have to subtract the number of seconds in hours from minutes to get
         the remaining minutes, rounding down to the nearest minute (in case you
         want to get seconds down the road) */
        let minutes = floor((elapsedTime - (hours * 60 * 60)) / 60)
        
        if Int(hours) < 0 {
            hours = hours + 24
        }
        
        if Int(hours) == 0 {
            TXTTime.text = "الوقت المتبقي \(Int(minutes)) دقيقه"
        }
        else {
            TXTTime.text = "الوقت المتبقي \(Int(hours)) ساعه و \(Int(minutes)) دقيقه"
        }
    }
    
    // TODO: This Method We Call It In The Action Based on Time.
    // ---------------------------------------
    public static func SendDatabase (statue:String) {
        let ref = Database.database().reference().child("Statue1")
        ref.child("Statue").setValue(statue)
    }
    // ----------------------------------------
    
}
