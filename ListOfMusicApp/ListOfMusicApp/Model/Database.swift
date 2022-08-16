//
//  Database.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 15.08.2022.
//

import Foundation
import UIKit
import CoreData

class Database: DatabaseProtocol {
    private let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func add<T: NSManagedObject>(_ type: T.Type) -> T? {
        guard let entityName = T.entity().name else { return nil }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: viewContext) else { return nil}
        let object = T(entity: entity, insertInto: viewContext)
        print("Success add")
        return object
    }
    
    func save() {
        do {
            try viewContext.save()
            print("success save")
        } catch {
            print(error.localizedDescription)
        }
    }
}
