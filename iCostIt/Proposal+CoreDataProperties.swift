//
//  Proposal+CoreDataProperties.swift
//  iCostIt
//
//  Created by Allison Mcentire on 5/21/17.
//  Copyright © 2017 com.millionacrenest. All rights reserved.
//

import Foundation
import CoreData


extension Proposal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Proposal> {
        return NSFetchRequest<Proposal>(entityName: "Proposal");
    }

    @NSManaged public var dateCreated: NSDate?
    @NSManaged public var daysOfSickLeave: Double
    @NSManaged public var daysOfSickLeaveIncrease: Double
    @NSManaged public var insurancePremiumIncrease: Double
    @NSManaged public var pensionContribution: Double
    @NSManaged public var percentIncrease: Double
    @NSManaged public var proposalName: String?
    @NSManaged public var proposalNumHolidaysCurr: Double
    @NSManaged public var proposalNumHolidaysProposed: Double
    @NSManaged public var proposalVacaWeeks: Double
    @NSManaged public var totalPaidHolidays: Double
    @NSManaged public var wageClasses: NSSet?

}

// MARK: Generated accessors for wageClasses
extension Proposal {

    @objc(addWageClassesObject:)
    @NSManaged public func addToWageClasses(_ value: WageClass)

    @objc(removeWageClassesObject:)
    @NSManaged public func removeFromWageClasses(_ value: WageClass)

    @objc(addWageClasses:)
    @NSManaged public func addToWageClasses(_ values: NSSet)

    @objc(removeWageClasses:)
    @NSManaged public func removeFromWageClasses(_ values: NSSet)

}
