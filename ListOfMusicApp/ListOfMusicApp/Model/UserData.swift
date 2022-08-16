//
//  UserData.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 14.08.2022.
//

import Foundation
import CoreData

class UserData: NSManagedObject {
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var phoneNumber: String
    @NSManaged var age: Date
    @NSManaged var email: String
    @NSManaged var password: String
}
