//
//  DatabaseProtocol.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 14.08.2022.
//

import Foundation
import CoreData

protocol DatabaseProtocol {
    func add<T: NSManagedObject> (_ type: T.Type ) -> T?
    func save()
}
