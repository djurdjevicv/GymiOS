//
//  Training+CoreDataProperties.swift
//  Gym
//
//  Created by Vladimir Djurdjevic on 22.3.22..
//
//

import Foundation
import CoreData


extension Training {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Training> {
        return NSFetchRequest<Training>(entityName: "Training")
    }

    @NSManaged public var beginnerUsername: String?
    @NSManaged public var coachUsername: String?
    @NSManaged public var dateTime: Date?
    @NSManaged public var duration: String?
    @NSManaged public var id: Int64
    @NSManaged public var endTraining: Date?

}

extension Training : Identifiable {

}
