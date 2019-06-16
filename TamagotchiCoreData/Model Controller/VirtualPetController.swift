//
//  VirtualPetController.swift
//  TamagotchiCoreData
//
//  Created by Haley Jones on 6/15/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation
import CoreData

class VirtualPetController{
    
    //shared instance
    static let shared = VirtualPetController()
    private init(){}
    
    //source of truth
    
    var pets: [VirtualPet] = []
    
    //CRUD Functions
    func createPet(withName name: String) -> VirtualPet{
        let newPet = VirtualPet(name: name, context: CoreDataStack.context)
        saveToPersistentStore()
        return newPet
    }
    
    func loadPets(){
        //build a fetch request
        let request: NSFetchRequest<VirtualPet> = VirtualPet.fetchRequest()
        do{
            //do the fetch
            let fetchedPets: [VirtualPet] = try CoreDataStack.context.fetch(request)
            //assign the source of truth equal to the fetch results
            VirtualPetController.shared.pets = fetchedPets
        } catch {
            print("There was an error in \(#function) - \(error.localizedDescription)")
        }
    }
    
    func saveToPersistentStore(){
        let moc = CoreDataStack.context
        do{
            try moc.save()
        } catch {
            print("There was an error in \(#function) - \(error.localizedDescription)")
        }
    }
    //this is the delete function but it sounded too mean so im calling it release
    func releasePet(pet: VirtualPet){
        if let moc = pet.managedObjectContext{
            moc.delete(pet)
        }
        saveToPersistentStore()
        loadPets()
    }
    
    //Pet Care Functions
    
    func petPet(pet: VirtualPet){
        pet.happiness = min(100, pet.happiness + 10)
        pet.timeLastPet = Date()
        saveToPersistentStore()
    }
    
    func feedPet(pet: VirtualPet, food: String){
        switch food{
        case "burger":
            pet.hunger = max(0, pet.hunger - 40)
        case "broccoli":
            pet.hunger = max(0, pet.hunger - 15)
        case "apple":
            pet.hunger = max(0, pet.hunger - 25)
        default:
            print("The pet doesn't want that.")
        }
        pet.timeLastFed = Date()
        saveToPersistentStore()
    }
    
    //this is the cool part. A function that checks what the Date is, compares it to the pet's last fed and last pet date, and adjusts stats accordingly
    func updateStats(forPet pet: VirtualPet){
        let currentDate = Date()
        guard let petLastFed = pet.timeLastFed,
            let petLastPet = pet.timeLastPet else {return}
        //make a constant that holds how long it's been since you've fed the pet, divided to make it smaller and more forgiving
        let timeSinceFed = (currentDate.timeIntervalSince(petLastFed) / 60)
        //do the same for time since petting the pet.
        let timeSincePet = (currentDate.timeIntervalSince(petLastPet) / 100)
        //add hunger based on that timeinterval
        pet.hunger = min(100, pet.hunger + Int16(timeSinceFed))
        //subtract happiness based on how long it's been since you pet the pet
        pet.happiness = max(0, pet.happiness - Int16(timeSincePet))
        //and then save these new stats to the store
        print("timeLastFed: \(pet.timeLastFed)")
        print("Time Since Last Food: \(timeSinceFed)")
        VirtualPetController.shared.saveToPersistentStore()
    }
}
