//
//  ViewController.swift
//  كوبري النصر العاىم
//
//  Created by Mohamed Ali on 2/10/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SVProgressHUD
import AVKit
import AVFoundation

class ArViewController: UIViewController {
    
    // TODO: Intilaize The Variblees Here:
    @IBOutlet weak var VideoFrame: UIView!
    @IBOutlet weak var VideoFrame1: UIView!
    @IBOutlet weak var TXTMess: UILabel!
    @IBOutlet weak var TXTTime: UILabel!
    @IBOutlet weak var BTNChangeStatue: UIButton!
    
    // TODO: Var That Have The Statue of Bridge.
    var x:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Call The Check The Function to get the Statue bridge from dataBase.
        checkStatue()
    }
    
    // TODO: Make An Action For Change The Statue Of Bridge
    @IBAction func BTNChangeStaute(_ sender: Any) {
         changeStatue()
    }
    
    // TODO: This Method For Get The Statue From Firebase.
    // ------------------------------------
    func checkStatue () {
        SVProgressHUD.show()
        let ref = Database.database().reference()
        ref.child("Statue1").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get Statue value
            let value = snapshot.value as? NSDictionary
            let statue = value?["Statue"] as? String ?? ""
            SVProgressHUD.dismiss()
            // Set Data To Local Var To Use It.
            self.x = statue
            // Change SomeThing in Page To Show The Difference in open or Close.
            self.loadPage()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    // -------------------------------------
    
    // TODO: This Method Work on Two Condition Open Or Close.
    // -------------------------------------
    func loadPage() {
        
        if self.x == "Closed" {
            UpdateUI()
        }
        else if self.x == "Opened" {
            
            let now = Date()
            let modifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: now)!
            
            /* In The Case Open we show Time and calculate The Difference Time and Chnage The Text and change button image. Change The Video in The Home Page */
            if Tools.setCondtion(FH: 6, LH: 9, FM: 0, LM: 55 , type: now , type2: now) == 0 {
                Tools.ARsetDfference(time2: "9:55AM",TXTTime: self.TXTTime)
                BridgeOn()
            }
            else {
                if Tools.setCondtion(FH: 11, LH: 18, FM: 5, LM: 25 , type: now , type2: now) == 0 {
                    Tools.ARsetDfference(time2: "6:25PM",TXTTime: self.TXTTime)
                    BridgeOn()
                }
                else {
                    if Tools.setCondtion(FH: 19, LH: 2, FM: 35, LM: 55 , type: now ,type2: modifiedDate) == 0 {
                        Tools.ARsetDfference(time2: "2:55AM",TXTTime: self.TXTTime)
                        BridgeOn()
                    }
                    else {
                        
                        /* In The Case Close we hide Time and Chnage The Text and change button image.
                         Change The Video in The Home Page */
                        
                        Tools.SendDatabase(statue: "Closed")
                        TXTTime.isHidden = true
                        TXTMess.text = "الكوبري مفصول للملاحه"
                        BTNChangeStatue.setBackgroundImage(UIImage(named: "BTNClose"), for: UIControl.State.normal)
                        setVideo1()
                        BTNChangeStatue.isEnabled = false
                    }
                }
            }
            
        }
    }
    // -----------------------------------
    
    // TODO: This Method We Call It In The Action Of Button To Change The Value in DataBase.
    // ---------------------------------------
    func changeStatue () {
        let ref = Database.database().reference().child("Statue1")
        if x == "Closed" {
            ref.child("Statue").setValue("Opened")
            self.x = "Opened"
            loadPage()
        } else {
            ref.child("Statue").setValue("Closed")
            self.x = "Closed"
            UpdateUI()
        }
    }
    // ----------------------------------------
    
    // TODO: This Method For Change The Page View Based On Open Bridge
    func BridgeOn () {
        setVideo()
        TXTTime.isHidden = false
        TXTMess.text = "الكوبرى يعمل للسيارات"
        BTNChangeStatue.setBackgroundImage(UIImage(named: "BTNOpen"), for: UIControl.State.normal)
    }
    
    // TODO: This Method Change The View When the Admin Close The Bridge.
    // --------------------------------------------
    func UpdateUI () {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mma"
        let mnow = dateFormatter.string(from: now as Date)
        TXTTime.isHidden = false
        TXTMess.text = "الكوبري مفصول لطوارئ الملاحه"
        TXTTime.text = "من الساعه \(mnow)"
        BTNChangeStatue.setBackgroundImage(UIImage(named: "BTNClose"), for: UIControl.State.normal)
        setVideo1()
    }
    
    // TODO: These Methods For Put the movie on view box
    // ----------------------------------------
    public func setVideo () {
        VideoFrame1.isHidden = true
        let path =  URL(fileURLWithPath: Bundle.main.path(forResource:"InShot_20200211_012921855",ofType:"mp4")!)
        let player = AVPlayer(url: path)
        
        let newlayer = AVPlayerLayer(player: player)
        newlayer.frame = VideoFrame.bounds
        VideoFrame.layer.addSublayer(newlayer)
        newlayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        VideoFrame.layer.insertSublayer(newlayer, at: 0)
        
        player.play()
        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        
        // This For Rebeate The Video By Using Notification
        NotificationCenter.default.addObserver(self, selector: #selector(ArViewController.VideoDidPlayEnded(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }
    
    public func setVideo1 () {
        VideoFrame1.isHidden = false
        let path =  URL(fileURLWithPath: Bundle.main.path(forResource:"InShot_20200211_184626580",ofType:"mp4")!)
        let player = AVPlayer(url: path)
        
        let newlayer = AVPlayerLayer(player: player)
        newlayer.frame = VideoFrame1.bounds
        VideoFrame1.layer.addSublayer(newlayer)
        newlayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        VideoFrame1.layer.insertSublayer(newlayer, at: 0)
        
        player.play()
        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        
        // This For Rebeate The Video By Using Notification
        NotificationCenter.default.addObserver(self, selector: #selector(ArViewController.VideoDidPlayEnded(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
    }
    
    @objc func VideoDidPlayEnded (_ notification:Notification) {
        let player : AVPlayerItem = notification.object as! AVPlayerItem
        player.seek(to: CMTime.zero,completionHandler: nil)
    }
    // -----------------------------------------------
    
}

