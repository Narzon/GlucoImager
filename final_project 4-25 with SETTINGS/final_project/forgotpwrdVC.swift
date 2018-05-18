//
//  forgotpwrdVC.swift
//  final_project
//
//  Created by Akshata Sastry on 3/22/17.
//  Copyright © 2017 Akshata Sastry. All rights reserved.
//

import UIKit
import CoreData
import Foundation
import MessageUI

class forgotpwrdVC: UIViewController,MFMailComposeViewControllerDelegate {
    var createloginVC: createloginVC?

    @IBOutlet weak var emailtxt: UITextField!
    @IBOutlet weak var btn: UIButton!
    
    @IBAction func sendEmailButton(_ sender: Any) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([emailtxt.text!])
        mailComposerVC.setSubject("GlucoImager Recovered Password")
        mailComposerVC.setMessageBody("W00P", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func editingChanged(_ textField: UITextField) {
        if textField.text?.characters.count == 1 {
            if textField.text?.characters.first == " " {
                textField.text = ""
                return
            }
        }
        
        guard
            let em = emailtxt.text, !em.isEmpty
            else {
                self.btn.isEnabled = false
                return
        }
        btn.isEnabled = true
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()

        
        btn.isEnabled = false
        emailtxt.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = SettingsService.sharedService.backgroundColor;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user touches on the main view (outside the UITextField).
    //
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
