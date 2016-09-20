//
//  SettingsViewController.swift
//  tippy
//
//  Created by Apurva Gandhi on 9/18/16.
//  Copyright © 2016 Apurva Gandhi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var defaultControl: UISegmentedControl!
    @IBOutlet weak var settingsLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeDefault(_ sender: UISegmentedControl) {
        let defaults = UserDefaults.standard
        defaults.set(defaultControl.selectedSegmentIndex, forKey: "default_tip_percentage")
        defaults.synchronize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // This is a good place to retrieve the default tip percentage from NSUserDefaults
        // and use it to update the tip amount
        let defaults = UserDefaults.standard
        defaultControl.selectedSegmentIndex = defaults.integer(forKey: "default_tip_percentage")
        self.defaultControl.alpha = 0
        UISegmentedControl.animate(withDuration: 0.8, animations: {
            self.defaultControl.alpha = 1
        
        })
        self.settingsLabel.alpha = 0
        UISegmentedControl.animate(withDuration: 0.8, animations: {
            self.settingsLabel.alpha = 1
            
        })

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
