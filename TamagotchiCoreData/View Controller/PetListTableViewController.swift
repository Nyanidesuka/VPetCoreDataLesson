//
//  PetListTableViewController.swift
//  TamagotchiCoreData
//
//  Created by Haley Jones on 6/15/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class PetListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        VirtualPetController.shared.loadPets()
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return VirtualPetController.shared.pets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "petCell", for: indexPath)

        let cellPet = VirtualPetController.shared.pets[indexPath.row]
        cell.textLabel?.text = cellPet.name
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let targetPet = VirtualPetController.shared.pets[indexPath.row]
            VirtualPetController.shared.releasePet(pet: targetPet)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("doing a segue")
        if segue.identifier == "newPet"{
            print("the identifier is right")
            guard let destinVC = segue.destination as? VPetViewController else {return}
            print("trying to make that new pet")
            destinVC.activePet = VirtualPetController.shared.createPet(withName: "Finias")
        }
        if segue.identifier == "toExistingPet"{
            guard let destinVC = segue.destination as? VPetViewController,
                let index = tableView.indexPathForSelectedRow else {return}
            let passPet = VirtualPetController.shared.pets[index.row]
            destinVC.activePet = passPet
        }
    }

}
