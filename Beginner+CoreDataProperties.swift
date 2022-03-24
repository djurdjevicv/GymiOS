//
//  Beginner+CoreDataProperties.swift
//  Gym
//
//  Created by Vladimir Djurdjevic on 19.3.22..
//
//

import Foundation
import CoreData


extension Beginner {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Beginner> {
        return NSFetchRequest<Beginner>(entityName: "Beginner")
    }


}
