//
//  ViewController.swift
//  RPG
//
//  Created by Jonathon Day on 1/3/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import UIKit

protocol CharacterDetailViewDelegate: NSObjectProtocol {
    func characterDetailDisplayDidEnd()
}

class CharacterDetailViewController: UIViewController {
    var character: Character!
    weak var delegate: CharacterTableController?
    
    @IBOutlet var charImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var classLabel: UILabel!
    @IBOutlet var healthLabel: UILabel!
    @IBOutlet var manaNumber: UILabel!
    @IBOutlet var levelNumber: UILabel!
    @IBOutlet var experienceNumber: UILabel!
    @IBOutlet var hitpointsLabel: UILabel!
    @IBOutlet var stepperControl: UIStepper!
    @IBOutlet var strengthLabel: UILabel!
    @IBOutlet var intLabel: UILabel!
    @IBOutlet var faithLabel: UILabel!
    @IBOutlet var unconsciousLabel: UILabel!
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        hitpointsLabel.text = String(sender.value)
    }
    

    @IBAction func userHeal(_ sender: UIButton) {
        character.heal(Int(stepperControl.value))
        updateView()
    }
    
    @IBAction func userDamage(_ sender: UIButton) {
        character.damage(Int(stepperControl.value))
        updateView()
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        delegate?.characterDetailDisplayDidEnd()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateView() {
        charImage.image = character.image
        nameLabel.text = character.name
        classLabel.text = character.characterClass.description
        healthLabel.text = "\(character.health.description) / \(character.maxHealth)"
        manaNumber.text = "\(character.mana.description) / \(character.maxMana)"
        levelNumber.text = character.level.description
        experienceNumber.text = "\((character.experience % 50 ).description) / 50"
        strengthLabel.text = character.strength.description
        intLabel.text = character.intelligence.description
        faithLabel.text = character.faith.description
        
        if character.health == 0 {
            unconsciousLabel.isHidden = false
            charImage.alpha = 0.35
        } else {
            unconsciousLabel.isHidden = true
            charImage.alpha = 0.65
        }
        
        switch character.characterClass {
        case .knight:
            self.view.backgroundColor = UIColor(red: 0.96, green: 0.85, blue: 0.78, alpha: 1)
        case .mage:
            self.view.backgroundColor = UIColor(red: 0.71, green: 0.86, blue: 1, alpha: 1)
        case .cleric:
            self.view.backgroundColor = UIColor(red: 0.68, green: 0.66, blue: 0.64, alpha: 1)
        }
    }
    
}
//three stats of your choice (Agility, defense, charisma, )
//status: at least two statuses (normal | incapacitated ) If a character's health reaches 0, they should be incapacitated.
//for the currently displayed character.
//
//Character's should be serializable to JSON.
//
