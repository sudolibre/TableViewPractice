//
//  ReminderCreationController.swift
//  Reminders
//
//  Created by Jonathon Day on 1/16/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import Foundation
import UIKit

protocol ReminderCreationViewControllerDelegate: NSObjectProtocol {
    func reminderCreationDidEnd(_ viewController: ReminderCreationController, reminder: Reminder)
}

class ReminderCreationController: UIViewController, UITextFieldDelegate {
    weak var delegate: ReminderCreationViewControllerDelegate?
    
    @IBAction func savePressed(_ sender: UIButton) {
        delegate?.reminderCreationDidEnd(self, reminder: Reminder(time: datePicker.date, description: descriptionField.text!))
    }
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var descriptionField: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != nil {
            textField.resignFirstResponder()
            return true
        } else {
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
