//
//  CharacterTableController.swift
//  RPG
//
//  Created by Jonathon Day on 1/16/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import Foundation
import UIKit

class CharacterTableController: UIViewController, UITableViewDelegate {
    let characterDataSource = CharacterTableDataSource()
    
    var tableView: UITableView {
        return view as! UITableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = characterDataSource
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "characterDetail") as! CharacterDetailViewController
        vc.character = characterDataSource.characters[indexPath.row]
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func characterDetailDisplayDidEnd() {
        dismiss(animated: true)
    }
}

class CharacterTableDataSource: NSObject, UITableViewDataSource {
    let characters = [Character(name: "Bob", characterClass: .knight), Character(name: "Gertrude", characterClass: .cleric), Character(name: "Cornelius", characterClass: .mage)]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell")!
        let character = characters[indexPath.row]
        
        cell.textLabel!.text = character.name
        return cell
    }
    
}

