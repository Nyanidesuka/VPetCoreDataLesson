//
//  VirtualPetExtension.swift
//  TamagotchiCoreData
//
//  Created by Haley Jones on 6/15/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation
import CoreData

extension VirtualPet{
    @discardableResult
    convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        //initialize with a name. The pet will save once it's given a name.
        self.name = name
        //give it middle happiness and hunger to start
        self.happiness = 50
        self.hunger = 50
        //initialize it with a timeLastFed and timeLastPet equal to the time it's created, just makes stuff easier later.
        self.timeLastFed = Date()
        self.timeLastPet = Date()
        //and lastly, because we know we're making a new pet:
        self.uuid = UUID().uuidString
    }
}
