//
//  Administrator+CoreDataProperties.swift
//  Gym
//
//  Created by Vladimir Djurdjevic on 19.3.22..
//
//

import Foundation
import CoreData


extension Administrator {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Administrator> {
        return NSFetchRequest<Administrator>(entityName: "Administrator")
    }


}
