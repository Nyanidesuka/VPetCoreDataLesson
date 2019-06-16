//
//  VPetViewController.swift
//  TamagotchiCoreData
//
//  Created by Haley Jones on 6/15/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class VPetViewController: UIViewController {
    
    //Properties
    var activePet: VirtualPet?{
        didSet{
            loadViewIfNeeded()
            guard let pet = self.activePet else {return}
            VirtualPetController.shared.updateStats(forPet: pet)
            updateViews()
        }
    }
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var happinessLabel: UILabel!
    @IBOutlet weak var hungerLabel: UILabel!
    @IBOutlet weak var petImageLabel: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        guard let pet = activePet else {return}
        if pet.hunger > 60 || pet.happiness < 50{
            petImageLabel.image = UIImage(named: "hamstarSad")
        }
    }
    
    @IBAction func petTapped(_ sender: UIButton) {
        guard let pet = activePet else {return}
        VirtualPetController.shared.petPet(pet: pet)
        petImageLabel.image = UIImage(named: "hamstarHappy")
        updateViews()
    }
    @IBAction func saveNameButtonTapped(_ sender: Any) {
        guard let pet = activePet,
        let newName = nameTextField.text else {return}
        pet.name = newName
        VirtualPetController.shared.saveToPersistentStore()
    }
    
    func updateViews(){
        guard let pet = activePet else {return}
        nameTextField.text = pet.name
        happinessLabel.text = "\(pet.happiness)"
        hungerLabel.text = "\(pet.hunger)"
    }
    
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("doing a segue")
        if segue.identifier == "toPetFood"{
            guard let destinVC = segue.destination as? FoodViewController else {return}
            print("assigning delegate")
            destinVC.delegate = self
        }
    }

}

extension VPetViewController: FoodViewControllerDelegate{
    
    func feedPet(food: String) {
        guard let pet = activePet else {return}
        VirtualPetController.shared.feedPet(pet: pet, food: food)
        switch food{
        case "burger":
            petImageLabel.image = UIImage(named: "hamstarWithBurger")
        case "broccoli":
            petImageLabel.image = UIImage(named: "hamstarWithBroccoli")
        case "apple":
            petImageLabel.image = UIImage(named: "hamstarWithApple")
        default:
            print("how")
        }
        self.updateViews()
    }
}

