//
//  RollUpViewController.swift
//  iCostIt
//
//  Created by Allison Mcentire on 5/13/17.
//  Copyright © 2017 com.millionacrenest. All rights reserved.
//

import UIKit
import CoreData

class RollUpViewController: UIViewController {
    
    @IBOutlet weak var wagesDataLabel: UILabel!
    
    @IBOutlet weak var vacationsDataLabel: UILabel!
    
    @IBOutlet weak var holidaysDataLabel: UILabel!
    
    
    @IBOutlet weak var sickLeaveDataLabel: UILabel!
    
    @IBOutlet weak var medicalDataLabel: UILabel!
    
    @IBOutlet weak var lifeInsuranceDataLabel: UILabel!
    
    @IBOutlet weak var pensionDataLabel: UILabel!
    
    @IBOutlet weak var totalPackDataLabel: UILabel!
    
    var proposalObject: Proposal?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //calculate wages roll up
        
        let proposalNumberOfWorkers:Double = (proposalObject!.value(forKeyPath: "wageClasses.@sum.numberOfWorkers") as! NSNumber).doubleValue
        
        
        let proposalWagesPaidPerHour:Double = (proposalObject!.value(forKeyPath: "wageClasses.@sum.wagesPaidPerHour") as! NSNumber).doubleValue
        
        let wABR = proposalWagesPaidPerHour / proposalNumberOfWorkers
        let formattedValuenWABR = String(format: "%.2f", wABR)
        
        let newCostAdd = proposalObject!.percentIncrease * wABR
        let newCost = wABR + newCostAdd
        
        let formattedNewCost = String(format: "%.2f", newCost)
        let formattedNewCostAdd = String(format: "%.2f", newCostAdd)
        let percentIncreaseDisp = proposalObject!.percentIncrease * 100
        
        wagesDataLabel.text = "CC: \(formattedValuenWABR) | NC: \(formattedNewCost) | A of I: \(formattedNewCostAdd) | PI: \(percentIncreaseDisp)"
        
        //calculate vacations roll up
        
        let currentVacaCost = wABR * 40 * proposalObject!.proposalVacaWeeks
        let currentVacaCostinCents = currentVacaCost/2080
        let formattedVacaCost = String(format: "%.2f", currentVacaCostinCents)
        
        let newVacaCost = newCost * 40 * 2
        let newVacaCostCents = newVacaCost/2080
        let formattednewVacaCostCents = String(format: "%.2f", newVacaCostCents)
        let increasePerEmplVaca = newVacaCost - currentVacaCost
        let increasePerHourVaca = increasePerEmplVaca/2080
        let formattedVacaIncrease = String(format: "%.2f", increasePerHourVaca)
        let vacaPercentIncrease = (increasePerHourVaca/currentVacaCostinCents)*100
        let formattedVacaPercentIncrease = String(format: "%.2f", vacaPercentIncrease)
        
        
        vacationsDataLabel.text = "CC: \(formattedVacaCost) | NC: \(formattednewVacaCostCents) | A of I: \( formattedVacaIncrease) | PI: \(formattedVacaPercentIncrease)"
        
        
        
        // calculate holidays roll up
        
        
        let curHolidayCost = wABR * 8 * proposalObject!.proposalNumHolidaysCurr
        let curHolidayCostCents = curHolidayCost/2080
        let formattedCurHolidayCost = String(format: "%.2f", curHolidayCostCents)
        
        let newHolidayCost = newCost * 8 * proposalObject!.proposalNumHolidaysProposed
        let newHolidayCostCents = newHolidayCost/2080
        
        let formattedNewHolidayCost = String(format: "%.2f", newHolidayCostCents)
        
        let holidayPercentIncrease = newHolidayCost - curHolidayCost
        let holidayIncreasePerHour = holidayPercentIncrease/2080
        let formattedIncreasePerHour = String(format: "%.2f", holidayIncreasePerHour)
        let holidayPercentIncreaseDiff = (holidayIncreasePerHour/curHolidayCostCents)*100
        
        
        
        
        holidaysDataLabel.text = "CC: \(formattedCurHolidayCost) | NC: \(formattedNewHolidayCost) | A of I: \(formattedIncreasePerHour) | PI: \(holidayPercentIncreaseDiff)"
        
        // calculate sick leave roll up
        
        let avgCostPerEmpl = wABR * 8 * proposalObject!.daysOfSickLeave
        let sickDaysCentsPerHourCost = avgCostPerEmpl/2080
        let formattedSickDaysPerHourCost = String(format: "%.2f", sickDaysCentsPerHourCost)
        
        let newCostPerEmpl = newCost * 8 * proposalObject!.daysOfSickLeaveIncrease
        let sickDaysNewCentsPerHourCost = newCostPerEmpl/2080
        let formattedSickDaysNewCentsPerHourCost = String(format: "%.2f", sickDaysNewCentsPerHourCost)
        
        let sickLeaveIncreasePerHour = sickDaysNewCentsPerHourCost - sickDaysCentsPerHourCost
        let formattedSickLeaveIncreasePerHour = String(format: "%.2f", sickLeaveIncreasePerHour)
        let sickLeavePercIncreaseDiff = (sickLeaveIncreasePerHour/sickDaysCentsPerHourCost)*100
        
        
        sickLeaveDataLabel.text = "CC: \(formattedSickDaysPerHourCost) | NC: \(formattedSickDaysNewCentsPerHourCost) | A of I: \(formattedSickLeaveIncreasePerHour) | PI: \(sickLeavePercIncreaseDiff)"
        
        // calculate medical insurance roll up
        
         //cc
        let medicalMonthlyTotal:Double = (proposalObject!.value(forKeyPath: "wageClasses.@sum.montlyClassCostMedInsurance") as! NSNumber).doubleValue
        debugPrint("\(medicalMonthlyTotal)")
        
        let medInsuranceTAC = medicalMonthlyTotal * 12 * proposalNumberOfWorkers
        let medInsuranceMonthlyCostPerEmp = medicalMonthlyTotal/12
        let montlyMedInsuranceCentsPerHour = medInsuranceMonthlyCostPerEmp/173.3
        let formattedmontlyMedInsuranceCentsPerHour = String(format: "%.2f", montlyMedInsuranceCentsPerHour)
        
        //nc
        
        let proposedMedicalMonthlyTotal:Double = (proposalObject!.value(forKeyPath: "wageClasses.@sum.proposedMedMonthlyClassPerEmployee") as! NSNumber).doubleValue
        debugPrint("\(medicalMonthlyTotal)")
        
        let proposedMedInsuranceTAC = proposedMedicalMonthlyTotal * 12 * proposalNumberOfWorkers
        let proposedMedInsuranceMonthlyCostPerEmp = proposedMedicalMonthlyTotal/12
        let proposedMontlyMedInsuranceCentsPerHour = proposedMedInsuranceMonthlyCostPerEmp/173.3
        let formattedproposedMontlyMedInsuranceCentsPerHour = String(format: "%.2f", proposedMontlyMedInsuranceCentsPerHour)
        
        // a of i
        
        let medAofI = proposedMontlyMedInsuranceCentsPerHour - montlyMedInsuranceCentsPerHour
        
        let formattedMedAofI = String(format: "%.2f", medAofI)
        
        // percent diff
        
        let medPercentDiff = (medAofI/montlyMedInsuranceCentsPerHour)*100
        
        medicalDataLabel.text = "CC: \(formattedmontlyMedInsuranceCentsPerHour) | NC: \(formattedproposedMontlyMedInsuranceCentsPerHour) | A of I: \(formattedMedAofI) | PI: \(medPercentDiff)"
 
        // calculate life insurance roll up

         let insuranceMonthlyTotal:Double = (proposalObject!.value(forKeyPath: "wageClasses.@sum.wageClassCurrMedCost") as! NSNumber).doubleValue
        let insuranceAnnualCostPerEmployee = insuranceMonthlyTotal/proposalNumberOfWorkers
        let insuranceAnnualCostPerEmployeeCents = insuranceAnnualCostPerEmployee/2080
         let formattedInsuranceAnnualCostPerEmployeeCents = String(format: "%.2f", insuranceAnnualCostPerEmployeeCents)
        
        let insuranceProposedMonthlyTotal:Double = (proposalObject!.value(forKeyPath: "wageClasses.@sum.wageClassProMedCost") as! NSNumber).doubleValue
        let insuranceProposedCostPerEmployee = insuranceProposedMonthlyTotal/proposalNumberOfWorkers
        let insuranceProposedCostPerEmployeeCents = insuranceProposedCostPerEmployee/2080
        let formattedInsuranceProposedCostPerEmployeeCents = String(format: "%.2f", insuranceProposedCostPerEmployeeCents)
        
        let insuranceAofI = insuranceProposedCostPerEmployeeCents - insuranceAnnualCostPerEmployeeCents
        
        let formattedInsuranceAofI = String(format: "%.2f", insuranceAofI)
        
         let insurancePercentDiff = (insuranceAofI/insuranceAnnualCostPerEmployeeCents)*100
        
        
        lifeInsuranceDataLabel.text = "CC: \(formattedInsuranceAnnualCostPerEmployeeCents) | NC: \(formattedInsuranceProposedCostPerEmployeeCents) | A of I: \(formattedInsuranceAofI) | PI: \(insurancePercentDiff)"
        
        // calculate pension roll up
        
           let pensionMonthlyTotal:Double = (proposalObject!.value(forKeyPath: "wageClasses.@sum.pensionMonthlyCostPerEmployee") as! NSNumber).doubleValue
        let pensionMonthlyAvg = pensionMonthlyTotal/12
        let currentPensionCost = pensionMonthlyAvg/173.3
        let formattedCurrentPensionCost = String(format: "%.2f", currentPensionCost)
        
        let pensionProposedMonthlyTotal:Double = (proposalObject!.value(forKeyPath: "wageClasses.@sum.pensionProposedMonthlyCostPerEmployee") as! NSNumber).doubleValue
        let pensionProposedMonthlyAvg = pensionProposedMonthlyTotal/12
        let proposedPensionCost = pensionProposedMonthlyAvg/173.3
        let formattedProposedPensionCost = String(format: "%.2f", proposedPensionCost)
        
        let pensionAofI = proposedPensionCost - currentPensionCost
         let formattedPensionAofI = String(format: "%.2f", pensionAofI)
        let pensionPercentDiff = (pensionAofI/currentPensionCost)*100
       
        pensionDataLabel.text = "CC: \(formattedCurrentPensionCost) | NC: \(formattedProposedPensionCost) | A of I: \(formattedPensionAofI) | PI: \(pensionPercentDiff)"
        
        // calculate total package roll up
        
        let totalCurrentCost = wABR + currentVacaCostinCents + curHolidayCostCents + sickDaysCentsPerHourCost + montlyMedInsuranceCentsPerHour + insuranceAnnualCostPerEmployeeCents + currentPensionCost
        let formattedTotalCurrentCost = String(format: "%.2f", totalCurrentCost)
        
        let totalProposedCost = newCost + newVacaCostCents + newHolidayCostCents + sickDaysNewCentsPerHourCost + proposedMontlyMedInsuranceCentsPerHour + insuranceProposedCostPerEmployeeCents + proposedPensionCost
           let formattedTotalProposedCost  = String(format: "%.2f", totalProposedCost)
        
        let totalAofI = newCostAdd + increasePerHourVaca + holidayIncreasePerHour + sickLeaveIncreasePerHour + medAofI + insuranceAofI + pensionAofI
        let formattedTotalAofI  = String(format: "%.2f", totalAofI)
        
        let totalPercentDiff = (totalAofI/totalCurrentCost)*100
        let formattedTotalPercentDiff  = String(format: "%.2f", totalPercentDiff)
        
        
        
        
        totalPackDataLabel.text = "CC: \(formattedTotalCurrentCost) | NC: \(formattedTotalProposedCost) | AofI:\(formattedTotalAofI) | PI: \(formattedTotalPercentDiff)"
        
        
        
        
        
        
        
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
