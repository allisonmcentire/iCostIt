//
//  WageClassesDetailViewController.swift
//  iCostIt
//
//  Created by Allison Mcentire on 12/5/16.
//  Copyright © 2016 com.millionacrenest. All rights reserved.
//

import UIKit

class WageClassesDetailViewController: UIViewController, UITextFieldDelegate {

 
    @IBOutlet weak var wageClassNameField: UITextField!
    
    
    @IBOutlet weak var numberOfWorkersField: UITextField!
    
    
    @IBOutlet weak var wagePerHourField: UITextField!
    
    
    
    var wageClassToEdit: WageClass?
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wageClassNameField.delegate = self
        numberOfWorkersField.delegate = self
        wagePerHourField.delegate = self
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
            
        }
        
        
        if wageClassToEdit != nil {
            loadWageClassData()
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        
        var wageClass: WageClass!
        if wageClassToEdit == nil {
            wageClass = WageClass(context: context)
            
        } else {
            
            wageClass = wageClassToEdit
            
        }
        
        
        
        
        if let wageClassName = wageClassNameField.text {
            wageClass.wageClassName = wageClassName
        }
        
        if let numberOfWorkers = numberOfWorkersField.text {
            wageClass.numberOfWorkers = (numberOfWorkers as NSString).doubleValue
        }
        
        if let wagePerHour = wagePerHourField.text {
            wageClass.wagePerHour = (wagePerHour as NSString).doubleValue
        }
         let wageNum = wageClass.wagePerHour
         let workersNum = wageClass.numberOfWorkers
        
         let totalCostNum = workersNum * wageNum
        
        wageClass.wagesPaidPerHour = totalCostNum
        
        
        
        
        
        
        adD.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    func loadWageClassData() {
        if let wageClass = wageClassToEdit {
            wageClassNameField.text = wageClass.wageClassName
            numberOfWorkersField.text = "\(wageClass.numberOfWorkers)"
            wagePerHourField.text = "\(wageClass.wagePerHour)"
            
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.wageClassNameField.resignFirstResponder()
        self.numberOfWorkersField.resignFirstResponder()
        self.wagePerHourField.resignFirstResponder()
        
        
        return true
    }
    
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if wageClassToEdit != nil {
            context.delete(wageClassToEdit!)
            adD.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    

    
    
    

}
