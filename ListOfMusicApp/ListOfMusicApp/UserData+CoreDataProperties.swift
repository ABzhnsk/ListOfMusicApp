//
//  UserData+CoreDataProperties.swift
//  
//
//  Created by Anna Buzhinskaya on 18.08.2022.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "User")
    }

    @NSManaged public var age: Date?
    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var password: String?
    @NSManaged public var phoneNumber: String?

}
