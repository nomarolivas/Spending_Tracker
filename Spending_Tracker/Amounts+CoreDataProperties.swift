//
//  Amounts+CoreDataProperties.swift
//  Spending_Tracker
//
//  Created by Nomar Olivas on 5/9/22.
//
//

import Foundation
import CoreData


extension Amounts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Amounts> {
        return NSFetchRequest<Amounts>(entityName: "Amounts")
    }

    @NSManaged public var totalAmount: Float
    @NSManaged public var groceryAmount: Float
    @NSManaged public var resturantAmount: Float

}

extension Amounts : Identifiable {

}
