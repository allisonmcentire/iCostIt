//
//  ProposalTableViewCell.swift
//  iCostIt
//
//  Created by Allison Mcentire on 12/9/16.
//  Copyright © 2016 com.millionacrenest. All rights reserved.
//

import UIKit


class ProposalCell: UITableViewCell {

    @IBOutlet weak var currentCostLabel: UILabel!
   
    @IBOutlet weak var contractNameLabel: UILabel!
    
    @IBOutlet weak var totalWorkersLabel: UILabel!
    
    @IBOutlet weak var dateCreatedLabel: UILabel!
    
    @IBOutlet weak var weightedAverageBaseRateLabel: UILabel!
    
  
   
    
    
    func configureCell(proposal: Proposal) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd yyyy"
        let convertedDateString = dateFormatter.string(from: proposal.dateCreated as! Date)
    
        
        
   
       
        
        var proposalNumberOfWorkers:Double = (proposal.value(forKeyPath: "wageClasses.@sum.numberOfWorkers") as! NSNumber).doubleValue

        
 
    
        
       
        
        
        var proposalWagesPaidPerHour:Double = (proposal.value(forKeyPath: "wageClasses.@sum.wagesPaidPerHour") as! NSNumber).doubleValue
        
       
        
        let wABR = proposalWagesPaidPerHour / proposalNumberOfWorkers
        //let wABRFloat = Float(wABR)
      //  let workers = Int(arraySum)
        
        
     
       
        
        
        
        
        
        
        
        contractNameLabel.text = proposal.proposalName
        currentCostLabel.text = "Total Wages Paid/Hour: \(proposalWagesPaidPerHour)"
        totalWorkersLabel.text = "Total Workers: \(proposalNumberOfWorkers)"
        dateCreatedLabel.text = "\(convertedDateString)"
        
        
      
     let value = wABR
        let formattedValue = String(format: "%.2f", value)
        
       
    
        weightedAverageBaseRateLabel.text = "Weighted Average Base Rate: \(formattedValue)"
    
    
    
    
    
    
    
    
    
    
    
    }
    
    
    
    
}




