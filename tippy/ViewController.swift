//
//  ViewController.swift
//  tippy
//
//  Created by Apurva Gandhi on 9/17/16.
//  Copyright © 2016 Apurva Gandhi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: AnyObject) {
    
        let locale = Locale.current
        let symbol = locale.currencySymbol!
        let tipPercentages = [0.18, 0.2, 0.25]
        let bill = Double(billField.text!) ?? 0
        let tip = tipPercentages[tipControl.selectedSegmentIndex] * bill
        let total = bill + tip
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.minimumFractionDigits = 2
        fmt.maximumFractionDigits = 2
        fmt.locale = NSLocale(localeIdentifier: locale.regionCode!) as Locale!
        
        let Tip = NSNumber(value: tip)
        let Total = NSNumber(value: total)
        tipLabel.text = String(format: "\(symbol)\(fmt.string(from: Tip)!)")
        totalLabel.text = String(format: "\(symbol)\(fmt.string(from: Total)!)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        // This is a good place to retrieve the default tip percentage from NSUserDefaults
        // and use it to update the tip amount
        let locale = Locale.current
        let symbol = locale.currencySymbol!
        let defaults = UserDefaults.standard
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "default_tip_percentage")
        let tipPercentages = [0.18, 0.2, 0.25]
        if (Int(CFAbsoluteTimeGetCurrent()) - defaults.integer(forKey: "time1") <= 600)
        {
            billField.text = defaults.string(forKey: "currentBill")
        }
        
        let bill = Double(billField.text!) ?? 0
        let tip = tipPercentages[tipControl.selectedSegmentIndex] * bill
        let total = bill + tip
        //tipLabel.text = String(format: "\(symbol)%.2f", tip)
        //totalLabel.text = String(format: "\(symbol)%.2f", total)
        
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.minimumFractionDigits = 2
        fmt.maximumFractionDigits = 2
        fmt.locale = NSLocale(localeIdentifier: locale.regionCode!) as Locale!
        
        let Tip = NSNumber(value: tip)
        let Total = NSNumber(value: total)
        tipLabel.text = String(format: "\(symbol)\(fmt.string(from: Tip)!)")
        totalLabel.text = String(format: "\(symbol)\(fmt.string(from: Total)!)")

        self.totalBar.alpha = 0
        UIView.animate(withDuration: 0.8, animations: {
            self.totalBar.alpha = 1
        })
        self.tipControl.alpha = 0
        UISegmentedControl.animate(withDuration: 0.8, animations: {
            self.tipControl.alpha = 1
            self.billField.becomeFirstResponder()
        })
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
        var startTime: CFAbsoluteTime!
        startTime = CFAbsoluteTimeGetCurrent()
        let defaults = UserDefaults.standard
        defaults.set(startTime, forKey: "time1")
        defaults.set((billField.text!), forKey: "currentBill")
        defaults.synchronize()
        
    }

}


    


