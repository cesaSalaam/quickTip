//
//  ViewController.swift
//  QuickTip
//
//  Created by Cesa Salaam on 12/15/16.
//  Copyright © 2016 Cesa Salaam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let tipPercentages = [0.1, 0.15, 0.20]
    
    var menuShowing = false
    
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var leadingMenuVIewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var percentController: UISegmentedControl!
    
    @IBOutlet weak var billInputField: UITextField!
    
    @IBOutlet weak var singlePersonBill: UILabel!
    
    @IBOutlet weak var doublePersonBill: UILabel!
    
    @IBOutlet weak var triplePersonBill: UILabel!
    
    override func viewDidLoad() {
    }
    
    @IBAction func segmentClicked(_ sender: Any) {
        
        let total = calculateTip(input: tipPercentages)
        
        self.tipAmount.text = String(format: "Tip: $%.2f", total[1])
        
        self.singlePersonBill.text = String(format: "$%.2f", total[0])
        
        self.doublePersonBill.text = String(format: "$%.2f", total[0]/2)
        
        self.triplePersonBill.text = String(format: "$%.2f", total[0]/3)
    }
    
    @IBAction func totalChanged(_ sender: Any) {
        
        let total = calculateTip(input: tipPercentages)
        
        self.tipAmount.text = String(format: "(Tip: $%.2f)", total[1])
        
        self.singlePersonBill.text = String(format: "$%.2f", total[0])
        
        self.doublePersonBill.text = String(format: "$%.2f", total[0]/2)
        
        self.triplePersonBill.text = String(format: "$%.2f", total[0]/3)
    }
    
    func calculateTip(input: [Double]) -> [Double]{
        
        let bill = Double(self.billInputField.text!) ?? 0
        
        let total = bill + bill * input[percentController.selectedSegmentIndex]
        let tip = bill * input[percentController.selectedSegmentIndex]
        let tempArray = [total, tip]
        return tempArray
    }
    
    @IBAction func backGroundTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func moreButtonClicked(_ sender: Any) {
        
        if(menuShowing){
            
            //If menu is showing, then hide menu.
            
            leadingMenuVIewConstraint.constant = -140 // moving view off of screen
            
            //Removing the shadow from the menuView
            menuView.layer.shadowOpacity = 0
            menuView.layer.shadowRadius = 3
        }else{
            
            //If menu is not showing, then show menu
            
            leadingMenuVIewConstraint.constant = 0 // Bringing menu into main view.
            
            UIView.animate(withDuration: 0.3, animations: {
                
                //Animation on menu view. Adds a sliding out animation.
                
                self.view.layoutIfNeeded()
            })
            //Adding a shadow to the menuView.
            menuView.layer.shadowOpacity = 1
            menuView.layer.shadowRadius = 6
        }
        
        menuShowing = !menuShowing //Toggling menuShowing boolean variable.
    }
}

