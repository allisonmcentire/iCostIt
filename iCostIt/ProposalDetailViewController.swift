//
//  ProposalDetailViewController.swift
//  iCostIt
//
//  Created by Allison Mcentire on 12/5/16.
//  Copyright © 2016 com.millionacrenest. All rights reserved.
//

import UIKit
import CoreData

class ProposalDetailViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var proposalNameField: UITextField!
    
    @IBOutlet weak var pensionField: UITextField!
    
    
    @IBOutlet weak var percentField: UITextField!
    
    
   
    
    @IBOutlet weak var tableView: UITableView!
    
    let currentDateTime = Date()
  
    
    @IBOutlet weak var newWeightedAverageYear1: UILabel!
    
    @IBOutlet weak var realNewWeightedAverageYear1: UILabel!
    
   
    @IBOutlet weak var totalAnnualCostLabel: UILabel!
    
    
    @IBOutlet weak var newWeightedAverageYear2Label: UILabel!
    
    @IBOutlet weak var newWeightedAverageYearTwoLabel: UILabel!
    
    @IBOutlet weak var aacpeLabel: UILabel!
    
    
    @IBOutlet weak var averageHourlyCostLabel: UILabel!
    
    
    
    var proposalToEdit: Proposal?
     var wageClasses = [WageClass]()
    
  
    
    
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        proposalNameField.delegate = self
        pensionField.delegate = self
        percentField.delegate = self
        
        
       
        tableView.dataSource = self
        tableView.delegate = self
        
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
            
        }
        
       

       
       // if proposalToEdit != nil {
            loadProposalData()
       // }
        
        
        if  wageClasses != nil {
             getWageClasses()
            print("\(wageClasses)")
        }
        
        
        
    }
    
  
    
    func getWageClasses(){
        let fetchRequest: NSFetchRequest<WageClass> = WageClass.fetchRequest()
        
        do {
            try self.wageClasses = context.fetch(fetchRequest)
            
        } catch {
            // handle error
        }
        
       
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return  wageClasses.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddWageClassCell", for: indexPath)
        
        let wageClass = wageClasses[indexPath.row]
        
        
       
        
        cell.textLabel?.text = wageClass.value(forKey: "wageClassName") as? String
        
//        var accessoryType = UITableViewCellAccessoryType.none
//        var tintColor = UIColor.clear
//        
//        
//           let wageClassSelected = wageClass.value(forKey: "checked") as? Bool ?? true
//        if (wageClassSelected) {
//            accessoryType = UITableViewCellAccessoryType.checkmark
//            tintColor = UIColor.green
//         
//            
//        }
//        else {
//            cell.accessoryType = .none
//        }
//        
//        
//      
//        
//        cell.accessoryType=accessoryType
//        cell.tintColor = tintColor
////
        
        
        
        
        
        
        return cell
        
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if indexPath.section == 0 {
//            if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
//                cell.accessoryType = .checkmark
//            }
//        }
//        else {
//            if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
//                cell.accessoryType = .checkmark
//            }
//        }
//    }
//    
//    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        if indexPath.section == 1 {
//            if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
//                cell.accessoryType = .none
//            }
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       
        
        let wageClassObject = self.wageClasses[indexPath.row]
       
        let wageClassStatus = wageClassObject.value(forKey: "checked") as? Bool ?? true
        
        wageClassObject.setValue(!wageClassStatus, forKey:"checked")
       
        
        
        // Add WageClass to Proposal
      //  proposalToEdit?.setValue(NSSet(object: wageClassObject), forKey: "wageClasses")

       
        
       
    
       
        
        
        if (wageClassStatus) {
            proposalToEdit?.addToWageClasses(wageClassObject)
            
            
        }
        else {
            proposalToEdit?.removeFromWageClasses(wageClassObject)
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
            }
        }
    
        
       
        
  
        context.performAndWait({
            
      
        
        do {
            try
                
                    adD.saveContext()
            
           
        } catch let error as NSError {
            print("Cannot save object: \(error), \(error.localizedDescription)")
        }
              })
        
//        tableView.deselectRow(at: indexPath,animated:false)
//        
//       
//        tableView.reloadRows(at: [indexPath], with: .none)
//        
//        tableView.deselectRow(at: indexPath, animated: true)
        
        
    
        
        
        
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.proposalNameField.resignFirstResponder()
        self.pensionField.resignFirstResponder()
        self.percentField.resignFirstResponder()
        
        
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
        
      
       /// if let setting the checked value?
        
       
       
        
        adD.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    func loadProposalData() {
        if let proposal = proposalToEdit {
            proposalNameField.text = proposal.proposalName
            pensionField.text = "\(proposal.pensionContribution)"
            percentField.text = "\(proposal.percentIncrease)"
            
            
            
            let proposalNumberOfWorkers:Double = (proposal.value(forKeyPath: "wageClasses.@sum.numberOfWorkers") as! NSNumber).doubleValue
           
            
            let proposalWagesPaidPerHour:Double = (proposal.value(forKeyPath: "wageClasses.@sum.wagesPaidPerHour") as! NSNumber).doubleValue
           
            let wABR = proposalWagesPaidPerHour / proposalNumberOfWorkers
            
            let percentIncrease = proposal.percentIncrease
            
            let nWABR = wABR * percentIncrease
           
            //let nWABRInt64 = Int64(nWABR)
            
            let newWABR = wABR + nWABR
            
            
            let valuenWABR = nWABR
            let formattedValuenWABR = String(format: "%.2f", valuenWABR)
            
            let valuenewWABR = newWABR
            let formattedValuenewWABR = String(format: "%.2f", valuenewWABR)
            
            
             newWeightedAverageYear1.text = "First Year % Increase: \(formattedValuenWABR)"
            
            
            realNewWeightedAverageYear1.text = "New Weighted Average, Year 1: \(formattedValuenewWABR)"
          
            let totalAnnualCost = proposalNumberOfWorkers * nWABR * 2080
            
            totalAnnualCostLabel.text = "Total Annual Cost: \(totalAnnualCost)"
            
            let year2 = newWABR * percentIncrease
             let formattedValueYear2 = String(format: "%.2f", year2)
            
           newWeightedAverageYear2Label.text = "Second Year % Increase: \(formattedValueYear2)"
            
            let combinedHourlyCost = nWABR + year2
            
            let newWeightedAverageYear2 = combinedHourlyCost + nWABR + newWABR
             let formattedValueWYear2 = String(format: "%.2f", newWeightedAverageYear2)
            
            newWeightedAverageYearTwoLabel.text = "New Weighted Average, Year 2: \(formattedValueWYear2)"
      
            let pension = proposal.pensionContribution
           
            
            let aacpe = pension / proposalNumberOfWorkers
            let formattedAacpe = String(format: "%.2f", aacpe)
            
            aacpeLabel.text = "AACPE: \(formattedAacpe)"
            
            
            let averageHourlyCost = aacpe / 2080
            let formattedValueWAHC = String(format: "%.2f", averageHourlyCost)
            averageHourlyCostLabel.text = "Average Hourly Cost: \(formattedValueWAHC)"
            
            
            
          
            
            
            
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
