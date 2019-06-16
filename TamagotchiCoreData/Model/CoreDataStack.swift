//
//  CoreDataStack.swift
//  TamagotchiCoreData
//
//  Created by Haley Jones on 6/15/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation

import CoreData

class CoreDataStack{
    static let container: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "TamagotchiCoreData")
        persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
            if let anError = error {
                fatalError("Everything is bad. \(anError)")
            }
        })
        return persistentContainer
    }()
    
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
}
