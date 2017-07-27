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
    
    
    @IBOutlet weak var avgInsurancePremiumLabel: UITextField!
    
    @IBOutlet weak var costPerMonthLabel: UITextField!
    
    
    @IBOutlet weak var proposedInsurancePremField: UITextField!
    
    @IBOutlet weak var increasedCostPerMonthField: UITextField!
    
    
    @IBOutlet weak var monthlyCostMedInsurancePerMonthField: UITextField!
    
    @IBOutlet weak var proposedMedMonthlyPerEmployeeField: UITextField!
   
    
    @IBOutlet weak var pensionMonthlyCostPerEmployeeField: UITextField!
    
    @IBOutlet weak var pensionProposedMonthlyCostPerEmployeeField: UITextField!
    
 
    
    var wageClassToEdit: WageClass?
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
        
        wageClassNameField.delegate = self
        numberOfWorkersField.delegate = self
        wagePerHourField.delegate = self
        avgInsurancePremiumLabel.delegate = self
        costPerMonthLabel.delegate = self
        proposedInsurancePremField.delegate = self
        increasedCostPerMonthField.delegate = self
        monthlyCostMedInsurancePerMonthField.delegate = self
        proposedMedMonthlyPerEmployeeField.delegate = self
        pensionMonthlyCostPerEmployeeField.delegate = self
        pensionProposedMonthlyCostPerEmployeeField.delegate = self
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "metal.jpg")!)
        
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
        
        // life insurance
        if let avgInsurancePremium = avgInsurancePremiumLabel.text {
            wageClass.avgInsurancePremium = (avgInsurancePremium as NSString).doubleValue
        }
        
        if let costPerMonth = costPerMonthLabel.text {
            wageClass.costPerCoverageMonth = (costPerMonth as NSString).doubleValue
        }
        
        if let proposedInsurancePrem = proposedInsurancePremField.text {
            wageClass.proposedInsurancePremium = (proposedInsurancePrem as NSString).doubleValue
        }
        
        if let increasedCostPerMonth = increasedCostPerMonthField.text {
            wageClass.proposedCostPerCoverageMonth = (increasedCostPerMonth as NSString).doubleValue
        }
        
        //medical insurance
        
        if let monthlyCostMedInsurancePerMonth = monthlyCostMedInsurancePerMonthField.text {
            wageClass.monthlyCostMedInsurancePerMonth = (monthlyCostMedInsurancePerMonth as NSString).doubleValue
        }
      
        
        wageClass.montlyClassCostMedInsurance = wageClass.monthlyCostMedInsurancePerMonth * 12 * wageClass.numberOfWorkers
        
        
        if let proposedMedMonthlyPerEmployee = proposedMedMonthlyPerEmployeeField.text {
            wageClass.proposedMedMonthlyPerEmployee = (proposedMedMonthlyPerEmployee as NSString).doubleValue
        }
        
        if let pensionMonthlyCostPerEmployee = pensionMonthlyCostPerEmployeeField.text {
            wageClass.pensionMonthlyCostPerEmployee = (pensionMonthlyCostPerEmployee as NSString).doubleValue
        }
        
        if let pensionProposedMonthlyCostPerEmployee = pensionProposedMonthlyCostPerEmployeeField.text {
            wageClass.pensionProposedMonthlyCostPerEmployee = (pensionProposedMonthlyCostPerEmployee as NSString).doubleValue
        }
      
        wageClass.proposedMedMonthlyClassPerEmployee = wageClass.proposedMedMonthlyPerEmployee * 12 * wageClass.numberOfWorkers
        

        //these are insurance calculations
        let wageClassCurrLifeInsuranceTAC = wageClass.numberOfWorkers * (wageClass.avgInsurancePremium/1000) * 12 * wageClass.costPerCoverageMonth
        
        
        
        wageClass.wageClassCurrMedCost = wageClassCurrLifeInsuranceTAC
        debugPrint("\(wageClass.wageClassCurrMedCost)")
        
        
         wageClass.wageClassProMedCost = wageClass.numberOfWorkers * (wageClass.proposedInsurancePremium/1000) * 12 * wageClass.proposedCostPerCoverageMonth
  

        
        
        
        wageClass.currentInsuranceCost = wageClass.numberOfWorkers * (wageClass.avgInsurancePremium/1000) * 12 * wageClass.costPerCoverageMonth
       
        
        
        
        
        
        adD.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
   
    

    
    func loadWageClassData() {
        if let wageClass = wageClassToEdit {
            wageClassNameField.text = wageClass.wageClassName
            numberOfWorkersField.text = "\(wageClass.numberOfWorkers)"
            wagePerHourField.text = "\(wageClass.wagePerHour)"
            avgInsurancePremiumLabel.text = "\(wageClass.avgInsurancePremium)"
            costPerMonthLabel.text = "\(wageClass.costPerCoverageMonth)"
            proposedInsurancePremField.text = "\(wageClass.proposedInsurancePremium)"
            increasedCostPerMonthField.text = "\(wageClass.proposedCostPerCoverageMonth)"
            monthlyCostMedInsurancePerMonthField.text = "\(wageClass.monthlyCostMedInsurancePerMonth)"
            proposedMedMonthlyPerEmployeeField.text = "\(wageClass.proposedMedMonthlyPerEmployee)"
            pensionMonthlyCostPerEmployeeField.text = "\(wageClass.pensionMonthlyCostPerEmployee)"
            pensionProposedMonthlyCostPerEmployeeField.text = "\(wageClass.pensionProposedMonthlyCostPerEmployee)"
            
            
            
            
            
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.wageClassNameField.resignFirstResponder()
        self.numberOfWorkersField.resignFirstResponder()
        self.wagePerHourField.resignFirstResponder()
        self.avgInsurancePremiumLabel.resignFirstResponder()
        self.costPerMonthLabel.resignFirstResponder()
        self.proposedInsurancePremField.resignFirstResponder()
        self.increasedCostPerMonthField.resignFirstResponder()
        self.monthlyCostMedInsurancePerMonthField.resignFirstResponder()
        self.proposedMedMonthlyPerEmployeeField.resignFirstResponder()
        self.pensionMonthlyCostPerEmployeeField.resignFirstResponder()
        self.pensionProposedMonthlyCostPerEmployeeField.resignFirstResponder()
        
        
        
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
