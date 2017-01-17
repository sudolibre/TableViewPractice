//
//  Reminder.swift
//  Reminders
//
//  Created by Jonathon Day on 1/16/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import Foundation

class Reminder {
    var description: String
    var time: Date
    
    init(time: Date, description: String) {
        self.time = time
        self.description = description
    }
}
