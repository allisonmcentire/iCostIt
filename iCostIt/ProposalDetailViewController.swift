//
//  ProposalDetailViewController.swift
//  iCostIt
//
//  Created by Allison Mcentire on 12/5/16.
//  Copyright © 2016 com.millionacrenest. All rights reserved.
//

import UIKit
import CoreData

class ProposalDetailViewController: UIViewController,  UITextFieldDelegate {
    
    @IBOutlet weak var proposalNameField: UITextField!
    
    @IBOutlet weak var pensionField: UITextField!
    
    
    @IBOutlet weak var percentField: UITextField!
    
    
    @IBOutlet weak var daysOfSickLeaveLabel: UITextField!
    
    
    
    @IBOutlet weak var daysOfSickLeaveInceaseField: UITextField!
    
    
    @IBOutlet weak var currentNumHolidaysField: UITextField!
    
    @IBOutlet weak var increasedNumHolidaysField: UITextField!
    
    @IBOutlet weak var numVacationWeeksField: UITextField!
    
    
    @IBOutlet weak var totalPaidHolidaysField: UITextField!
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var wABRLabel: UILabel!
    
    
    
    
    
    
    
    
    
    
    let currentDateTime = Date()

    var proposalToEdit: Proposal?
     var wageClasses = [WageClass]()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        proposalNameField.delegate = self
        pensionField.delegate = self
        percentField.delegate = self
        daysOfSickLeaveLabel.delegate = self
        daysOfSickLeaveInceaseField.delegate = self
        currentNumHolidaysField.delegate = self
        increasedNumHolidaysField.delegate = self
        numVacationWeeksField.delegate = self
        totalPaidHolidaysField.delegate = self
        
        if let wABR = proposalToEdit?.totalProposedCost ?? nil  {
        
        wABRLabel.text = "\(wABR)"
        
        }
  
        if let topItem = self.navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
            
        }
    
       // if proposalToEdit != nil {
            loadProposalData()
      
       // }
  
  
    }
   

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.proposalNameField.resignFirstResponder()
        self.pensionField.resignFirstResponder()
        self.percentField.resignFirstResponder()
        self.daysOfSickLeaveLabel.resignFirstResponder()
        self.daysOfSickLeaveInceaseField.resignFirstResponder()
        self.currentNumHolidaysField.resignFirstResponder()
        self.increasedNumHolidaysField.resignFirstResponder()
        self.numVacationWeeksField.resignFirstResponder()
        self.totalPaidHolidaysField.resignFirstResponder()
        
        
        return true
    }
    
 
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        
        var proposal: Proposal!
        
        if proposalToEdit == nil {
            proposal = Proposal(context: context)
            
        } else {
            
            proposal = proposalToEdit
            
        }
        
        
       
            proposal.dateCreated = currentDateTime as NSDate?
        
        
        if let proposalName = proposalNameField.text {
            proposal.proposalName = proposalName
        }
        
        if let pensionContribution = pensionField.text {
            proposal.pensionContribution = (pensionContribution as NSString).doubleValue
        }
        
        if let percentIncrease = percentField.text {
            proposal.percentIncrease = (percentIncrease as NSString).doubleValue
        }
        
         if let totalPaidHolidays =   totalPaidHolidaysField.text {
            proposal.totalPaidHolidays = (totalPaidHolidays as NSString).doubleValue
        }
        
        
        if let numWeeksVaca = numVacationWeeksField.text {
            proposal.proposalVacaWeeks = (numWeeksVaca as NSString).doubleValue
        }
        
        if let currentNumHolidays = currentNumHolidaysField.text {
            proposal.proposalNumHolidaysCurr = (currentNumHolidays as NSString).doubleValue
        }
        
        if let proposedNumHolidays = increasedNumHolidaysField.text {
            proposal.proposalNumHolidaysProposed = (proposedNumHolidays as NSString).doubleValue
        }
        
        if let currentNumSickDays = daysOfSickLeaveLabel.text {
            proposal.daysOfSickLeave = (currentNumSickDays as NSString).doubleValue
        }
        
        if let sickDaysIncrease = daysOfSickLeaveInceaseField.text {
            proposal.daysOfSickLeaveIncrease = (sickDaysIncrease as NSString).doubleValue
        }
        
        
        
     
        
        
     
      
       /// if let setting the checked value?
        
       
       
        
        adD.saveContext()
        
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "SelectWCVC") as! SelectWCViewController
        
        
        myVC.proposalObject = proposal
        navigationController?.pushViewController(myVC, animated: true)
        
       // _ = navigationController?.popViewController(animated: true)
    }
    
 
    
    func loadProposalData() {
        if let proposal = proposalToEdit {
            proposalNameField.text = proposal.proposalName
            pensionField.text = "\(proposal.pensionContribution)"
            percentField.text = "\(proposal.percentIncrease)"
            daysOfSickLeaveLabel.text = "\(proposal.daysOfSickLeave)"
            daysOfSickLeaveInceaseField.text = "\(proposal.daysOfSickLeaveIncrease)"
            currentNumHolidaysField.text = "\(proposal.proposalNumHolidaysCurr)"
            increasedNumHolidaysField.text = "\(proposal.proposalNumHolidaysProposed)"
            numVacationWeeksField.text = "\(proposal.proposalVacaWeeks)"
            totalPaidHolidaysField.text = "\(proposal.totalPaidHolidays)"
         
            
        }
        
        
    }
    
    
    
    

    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if proposalToEdit != nil {
            context.delete(proposalToEdit!)
            adD.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    


}
