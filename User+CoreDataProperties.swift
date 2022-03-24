//
//  User+CoreDataProperties.swift
//  Gym
//
//  Created by Vladimir Djurdjevic on 19.3.22..
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var id: Int64
    @NSManaged public var lastName: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var userType: String?
    @NSManaged public var email: String?

}

extension User : Identifiable {

}
