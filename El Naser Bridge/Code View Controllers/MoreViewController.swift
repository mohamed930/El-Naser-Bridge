//
//  MoreViewController.swift
//  El Naser Bridge
//
//  Created by Mohamed Ali on 2/12/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import FirebaseDatabase
import CoreData
import MessageUI

class MoreViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {
    
    var LangArr = Array<Language>()
    var Mess = """
               ملاكي  ١ جنيه
               اجره   ١جنيه
               ميكروباص  ٢ جنيه
               ربع نقل  ٥جنيه
               نصف نقل  ١٠جنيه
               اتربيس  ١٠جنيه
               نقل فرداني  ٢٠جنيه
               تريللا  ٤٠جنيه

               السيارات الملاكي و الاجره ببورسعيد معفيه من قيمه الرسوم المقرره
               """
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // TODO: This Action Method For Return Page we Are in here.
    @IBAction func BTNBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // TODO: This Methodes for The Collection View Action in This Ar Viewcontroller
    // --------------------------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Tools.ImgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : MyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyCell
        cell.IconImage.image = UIImage(named: Tools.ImgArr[indexPath.row])
        cell.backgroundColor = UIColor().hexStringToUIColor(hex: Tools.ColorArr[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Info Button
        if indexPath.row == 5 {
            Tools.createAlert(Title: "معلومه", Mess: "تطبيق كوبرى النصر من تصميم و تنفيذ المهندس محمد على ابراهيم المسؤل عن قسم نظم المعلومات بالتعاون مع هيىه قناه السويس" , ob: self)
        }
        // Fees Button
        else if indexPath.row == 2 {
            Tools.createAlert(Title: "معلومه", Mess: Mess , ob: self)
        }
        // Arabic Button
        else if indexPath.row == 0 {
            Tools.createAlert(Title: "تنبيه", Mess: "انت تستخدم اللغه العربيه" , ob: self)
        }
        // English Button
        else if indexPath.row == 1 {
           LangArr = Tools.getData(&LangArr)
           Tools.setLanguage(Value: "English", LanArray: LangArr)
            self.performSegue(withIdentifier: "English", sender: self)
        }
        else if indexPath.row == 4 {
            sendEmail()
        }
    }
    // -----------------------------------------------
    
    public func sendEmail() {
        guard MFMailComposeViewController.canSendMail() else {
            // Show alert info the user
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["mohammedali12477@gmial.com"])
        
        self.present(composer, animated: true)
    }
}

extension MoreViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if error != nil {
            controller.dismiss(animated: true)
            return
        }
        
        switch result {
        case .cancelled:
            print("canceled")
        case.failed:
            print("failed")
        case .saved:
            print("Saved")
        case .sent:
            print("Sened")
        @unknown default:
            print("Error")
        }
        
    }
}
