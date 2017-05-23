//
//  WageClass+CoreDataProperties.swift
//  iCostIt
//
//  Created by Allison Mcentire on 5/22/17.
//  Copyright © 2017 com.millionacrenest. All rights reserved.
//

import Foundation
import CoreData


extension WageClass {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WageClass> {
        return NSFetchRequest<WageClass>(entityName: "WageClass");
    }

    @NSManaged public var avgInsurancePremium: Double
    @NSManaged public var costPerCoverageMonth: Double
    @NSManaged public var currentInsuranceCost: Double
    @NSManaged public var monthlyCostMedInsurancePerMonth: Double
    @NSManaged public var montlyClassCostMedInsurance: Double
    @NSManaged public var numberOfWorkers: Double
    @NSManaged public var proposedCostPerCoverageMonth: Double
    @NSManaged public var proposedInsurancePremium: Double
    @NSManaged public var wageClassCurrMedCost: Double
    @NSManaged public var wageClassName: String?
    @NSManaged public var wageClassProMedCost: Double
    @NSManaged public var wagePerHour: Double
    @NSManaged public var wagesPaidPerHour: Double
    @NSManaged public var proposedMedMonthlyPerEmployee: Double
    @NSManaged public var proposedMedMonthlyClassPerEmployee: Double
    @NSManaged public var pensionMonthlyCostPerEmployee: Double
    @NSManaged public var pensionProposedMonthlyCostPerEmployee: Double
    @NSManaged public var proposals: NSSet?

}

// MARK: Generated accessors for proposals
extension WageClass {

    @objc(addProposalsObject:)
    @NSManaged public func addToProposals(_ value: Proposal)

    @objc(removeProposalsObject:)
    @NSManaged public func removeFromProposals(_ value: Proposal)

    @objc(addProposals:)
    @NSManaged public func addToProposals(_ values: NSSet)

    @objc(removeProposals:)
    @NSManaged public func removeFromProposals(_ values: NSSet)

}
