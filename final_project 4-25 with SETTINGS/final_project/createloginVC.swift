//
//  createloginVC.swift
//  final_project
//
//  Created by Akshata Sastry on 3/22/17.
//  Copyright © 2017 Akshata Sastry. All rights reserved.
//

import UIKit
import CoreData

class createloginVC: UIViewController {
    
    var people = [NSManagedObject]()
    
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var pword: UITextField!
    @IBOutlet weak var birth: UITextField!
    @IBOutlet weak var wgt: UITextField!
    @IBOutlet weak var hgt: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    
    @IBOutlet weak var nxtbtn: UIButton!
    
    
    

    fileprivate func savePerson(first_name:String, last_name:String, email:String, password:String, height:String, weight:String, gender:Int32,birthday:String) {
     
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
     
        let managedContext = appDelegate.persistentContainer.viewContext
     
     // Create the entity we want to save
        let entity =  NSEntityDescription.entity(forEntityName: "Person", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
     
     // Set the attribute values
        person.setValue(first_name, forKey: "first_name")
        person.setValue(last_name, forKey: "last_name")
        person.setValue(email, forKey: "email")
        person.setValue(height, forKey: "height")
        person.setValue(weight, forKey: "weight")
        person.setValue(birthday, forKey: "birthday")
        person.setValue(gender, forKey: "gender")
        person.setValue(password, forKey: "password")
     
     // Commit the changes.
        do {
            try managedContext.save()
        } catch {
     // what to do if an error occurs?
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
     
     // Add the new entity to our array of managed objects
        people.append(person)
     
     }

    @IBAction func nextbtn(_ sender: UIButton) {
        savePerson(first_name: fname.text!, last_name: lname.text!, email: email.text!, password: pword.text!, height: hgt.text!, weight: wgt.text!, gender: Int32(gender!.selectedSegmentIndex), birthday: birth.text!)

        let myVC = storyboard?.instantiateViewController(withIdentifier: "Profile") as! myprofileVC
        /*myVC.Theight = hgt.text!
        myVC.Tweight = wgt.text!
        myVC.Tname = fname.text! + " " + lname.text!
        myVC.Tbirth = birth.text!
        */
 navigationController?.pushViewController(myVC, animated: true)
    }

    func editingChanged(_ textField: UITextField) {
        if textField.text?.characters.count == 1 {
            if textField.text?.characters.first == " " {
                textField.text = ""
                return
            }
        }


        guard
            let f = fname.text, !f.isEmpty,
            let l = lname.text, !l.isEmpty,
            let p = pword.text, !p.isEmpty,
            let b = birth.text, !b.isEmpty,
            let e = email.text, !e.isEmpty,
            let h = hgt.text, !h.isEmpty,
            let w = wgt.text, !w.isEmpty
        else {
            self.nxtbtn.isEnabled = false
            return
        }
        nxtbtn.isEnabled = true
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nxtbtn.isEnabled = false
        fname.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        lname.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        pword.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        birth.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        email.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        hgt.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        wgt.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
 
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
