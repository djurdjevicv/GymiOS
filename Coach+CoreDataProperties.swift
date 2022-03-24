//
//  Coach+CoreDataProperties.swift
//  Gym
//
//  Created by Vladimir Djurdjevic on 19.3.22..
//
//

import Foundation
import CoreData


extension Coach {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Coach> {
        return NSFetchRequest<Coach>(entityName: "Coach")
    }


}
