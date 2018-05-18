//
//  settingsViewController.swift
//  final_project
//
//  Created by Nicolai Antonov on 4/30/17.
//  Copyright © 2017 Akshata Sastry. All rights reserved.
//

import UIKit

class settingsViewController: UIViewController {
    var createloginVC: createloginVC?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        // Do any additional setup after loading the view.
    }

    @IBAction func greenButton(_ sender: Any) {
        let green = UIColor(red: 106/255, green: 238/255, blue: 166/255, alpha: 1)
        SettingsService.sharedService.backgroundColor = green
        self.view.backgroundColor = SettingsService.sharedService.backgroundColor;
    }
    @IBAction func purpleButton(_ sender: Any) {
        
        let purple  = UIColor(red: 223/255, green:174/255, blue: 242/255, alpha: 1)
        SettingsService.sharedService.backgroundColor = purple
        self.view.backgroundColor = SettingsService.sharedService.backgroundColor;
    }
    @IBAction func Orange(_ sender: Any) {
        
        let orange = UIColor(red: 255/255, green: 195/255, blue: 98/255, alpha: 1)
        SettingsService.sharedService.backgroundColor = orange
        self.view.backgroundColor = SettingsService.sharedService.backgroundColor;
    }

    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = SettingsService.sharedService.backgroundColor;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
