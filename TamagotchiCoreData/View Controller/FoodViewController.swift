//
//  FoodViewController.swift
//  TamagotchiCoreData
//
//  Created by Haley Jones on 6/15/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController {
    
    //Properties
    var delegate: FoodViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(delegate)
    }
    
    @IBAction func burgerButtonPressed(_ sender: Any) {
        delegate?.feedPet(food: "burger")
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func appleButtonPressed(_ sender: UIButton) {
        delegate?.feedPet(food: "apple")
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func broccoliButtonPressed(_ sender: UIButton) {
        delegate?.feedPet(food: "broccoli")
        self.dismiss(animated: true, completion: nil)
    }
    
}

protocol FoodViewControllerDelegate{
    func feedPet(food: String)
}
