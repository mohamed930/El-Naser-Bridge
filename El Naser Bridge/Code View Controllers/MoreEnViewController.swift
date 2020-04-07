//
//  MoreEnViewController.swift
//  El Naser Bridge
//
//  Created by Mohamed Ali on 2/13/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import CoreData
import MessageUI

class MoreEnViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate {

    var LangArr = Array<Language>()
    
    var Mess = """
                Private car  1EGP
               Taxi   1EGP
               Van    2EGP
               Pickup Truck  5EGP
               Medium truck   10EGP
               Bus truck  10EGP
               Fardany  20EGP
               Trella  40EGP

               Port Said private cars and taxis are exempted from fees
               """
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // TODO: Action Method For Return Button
    @IBAction func BTNBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // TODO: These Methods For Collection View Actions
    // -------------------------------------
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
            Tools.createAlert(Title: "title", Mess: "This Application is designed and developed by Eng : Mohamed Ali Abraham Ali and Help with Suez Canal Authority" , ob: self)
        }
        // Fees Button
        else if indexPath.row == 2 {
            Tools.createAlert(Title: "info", Mess: Mess , ob: self)
        }
        // English Button
        else if indexPath.row == 1 {
            Tools.createAlert(Title: "Alert", Mess: "You Are Using An English language" , ob: self)
        }
        // Arabic Button
        else if indexPath.row == 0 {
            LangArr = Tools.getData(&LangArr)
            Tools.setLanguage(Value: "Arabic", LanArray: LangArr)
            self.performSegue(withIdentifier: "Arabic", sender: self)
        }
        else if indexPath.row == 4 {
            sendEmail()
        }
    }
    // --------------------------------------
    
    // TODO: This Method For send Email To Admin About Any Problem
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

extension MoreEnViewController: MFMailComposeViewControllerDelegate {
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

