//
//  loginVCViewController.swift
//  final_project
//
//  Created by Akshata Sastry on 3/22/17.
//  Copyright © 2017 Akshata Sastry. All rights reserved.
//

import UIKit
import CoreData

class loginVCViewController: UIViewController {
    var createloginVC: createloginVC?
    

    @IBOutlet weak var signbtn: UIButton!
    @IBOutlet weak var passwordtxt: UITextField!
    @IBOutlet weak var usernametxt: UITextField!
    
    @IBAction func signinbtn(_ sender: Any) {
            print("Done")
    }
    
    func editingChanged(_ textField: UITextField) {
        if textField.text?.characters.count == 1 {
            if textField.text?.characters.first == " " {
                textField.text = ""
                return
            }
        }
        
        guard
            let user = usernametxt.text, !user.isEmpty,
            let pass = passwordtxt.text, !pass.isEmpty
        else {
            self.signbtn.isEnabled = false
            return
        }
        signbtn.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        signbtn.isEnabled = false
        usernametxt.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        passwordtxt.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
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
    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (usernametxt.text != "" || passwordtxt.text != "") {         //I TEMPORARY CHANGED THE == TO != FOR TESTING
            var destination = segue.destination as! myprofileVC
        }
        else {
        
            let detailAlert = UIAlertController(title: "Error", message: "Please fill all fields" , preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            detailAlert.addAction(OKAction)
            
            present(detailAlert, animated: true, completion:nil)
        }
        

    }*/
}
