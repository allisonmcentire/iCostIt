//
//  WageClass+CoreDataProperties.swift
//  iCostIt
//
//  Created by Allison Mcentire on 2/26/17.
//  Copyright © 2017 com.millionacrenest. All rights reserved.
//

import Foundation
import CoreData


extension WageClass {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WageClass> {
        return NSFetchRequest<WageClass>(entityName: "WageClass");
    }

    @NSManaged public var checked: Bool
    @NSManaged public var numberOfWorkers: Double
    @NSManaged public var wageClassName: String?
    @NSManaged public var wagePerHour: Double
    @NSManaged public var wagesPaidPerHour: Double
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
