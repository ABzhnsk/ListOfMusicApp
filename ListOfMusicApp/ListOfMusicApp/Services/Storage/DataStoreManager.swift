//
//  DataStoreManager.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 17.08.2022.
//

import CoreData

class DataStoreManager {
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ListOfMusicApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - CRUD
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveUser(_ user: UserDataModel) {
        let _user = UserData(context: persistentContainer.viewContext)
        _user.firstName = user.firstName
        _user.lastName = user.lastName
        _user.age = user.age
        _user.phoneNumber = user.phoneNumber
        _user.email = user.email
        _user.password = user.password
        
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func loadUser() -> [UserData] {
        var user: [UserData] = []
        do {
            user = try persistentContainer.viewContext.fetch(UserData.fetchRequest())
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.localizedDescription)")
        }
        return user
    }
    
}
