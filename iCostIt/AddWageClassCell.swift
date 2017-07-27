//
//  WageCell.swift
//  iCostIt
//
//  Created by Allison Mcentire on 12/11/16.
//  Copyright © 2016 com.millionacrenest. All rights reserved.
//

import UIKit

class AddWageClassCell: UITableViewCell {
    
    @IBOutlet weak var wageClassNameLabel: UILabel!
    
    @IBOutlet weak var totalCostLabel: UILabel!
    
    @IBOutlet weak var numberOfWorkersLabel: UILabel!
    
    
    
    @IBOutlet weak var totalWagePerHourLabel: UILabel!
    
    
    
    func configureCell(wageClass: WageClass) {
        
        
        
        
        
        
        // Calculate the total employees...
        //        var sumPeople = 0
        //        for wage in wageClass {
        //            let fQ = wage.value(forKey: "numberOfWorkers") as! Int32
        //
        //            sumPeople += fQ
        //        }
        //
        ////        // Calculate the total wages paid per hour...
        //        var sumWagesPaid = 0
        //
        //        for wage in wageClass {
        //            let fA = wage.value(forKey: "wagePerHour") as! Double
        //
        //            sumWagesPaid += fA
        //        }
        //
        //        //Calculate the weighted average base rate...
        //        var sumWeightedAverageBaseRate = 0
        //        for wage in wageClass {
        //            let fA = wage.value(forKey: "numberOfWorkers") as! Int
        //            let fQ = wage.value(forKey: "classWagesPaidPerHour") as! Int
        //
        //            sumWeightedAverageBaseRate += fQ / fA
        //        }
        
        //Calculate total wages paid
        // would that be sumWagesPaid * 2080
        
        // var sumTotalWagesPaid = sumWagesPaid * 2080
        
        
        
        //populate the view
        //            print("Grand total = \(sumPeople)")
        //            totalEmployeesLabel.text = "\(sumPeople)"
        //            totalWagesPaidPerHourLabel.text = "\(sumWagesPaid)"
        //
        //            weightedAverageBaseRate.text = "\(sumWeightedAverageBaseRate)"
        //
        //            totalWagesPaidLabel.text = "\(sumTotalWagesPaid)"
        
        
        
        
        wageClassNameLabel.text = wageClass.wageClassName
        totalWagePerHourLabel.text = "Wage per hour: \(wageClass.wagePerHour)"
        //        let wageNum = wageClass.wagePerHour
        //        print(wageNum)
        
        
        
        
        
        numberOfWorkersLabel.text = "Number of Workers: \(wageClass.numberOfWorkers)"
        
        
        
        
        totalCostLabel.text = "Total wages paid/hour: \(wageClass.wagesPaidPerHour)"
        
        
        
        
        
        
        
        
    }
    
}


//total wages paid per hour / total employees = weighted average base rate
