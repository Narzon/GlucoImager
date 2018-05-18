//
//  myprofileVC.swift
//  final_project
//
//  Created by Akshata Sastry on 3/22/17.
//  Copyright © 2017 Akshata Sastry. All rights reserved.
//

import UIKit
import CoreData

class myprofileVC: UIViewController {
    var createloginVC: createloginVC?

    @IBOutlet weak var hlbl: UILabel!
    @IBOutlet weak var wlbl: UILabel!
    @IBOutlet weak var birth: UILabel!
    @IBOutlet weak var name: UILabel!
    /*
    var Theight = ""
    var Tname = ""
    var Tbirth = ""
    var Tweight = ""
    */
    
    var people = [NSManagedObject] ()
    var person: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //loadData()
        /*
        hlbl.text = Theight
        wlbl.text = Tweight
        birth.text = Tbirth
        name.text = Tname
         */
        
        hlbl.text = person?.value(forKey: "height") as! String?
        wlbl.text = person?.value(forKey: "weight") as! String?
        birth.text = person?.value(forKey: "bday") as! String?
        name.text = person?.value(forKey: "first_name") as! String?
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = SettingsService.sharedService.backgroundColor;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func loadData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Person")
        
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        if let results = fetchedResults {
            people = results
        } else {
            print("Could not fetch")
        }
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
