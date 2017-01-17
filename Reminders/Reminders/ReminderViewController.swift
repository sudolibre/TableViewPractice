//
//  ViewController.swift
//  Reminders
//
//  Created by Jonathon Day on 1/16/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import UIKit
import UserNotifications

class ReminderViewController: UIViewController, UITableViewDelegate, ReminderCreationViewControllerDelegate {
    var center: UNUserNotificationCenter! = nil
    
    @IBAction func addReminder(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "creationController") as! ReminderCreationController
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    var tableView: UITableView {
        return view as! UITableView
    }
    var reminderDataSource = ReminderDataSource()


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = reminderDataSource
}

    func reminderCreationDidEnd(_ viewController: ReminderCreationController, reminder: Reminder) {
        //add to data source
        reminderDataSource.add(reminder)
        
        //schedule notification
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Don't Forget!"
        notificationContent.body = reminder.description
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: reminder.time)
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let notificationRequest = UNNotificationRequest(identifier: "MyReminderApp", content: notificationContent, trigger: notificationTrigger)
        center.add(notificationRequest) { (error) in
            if let err = error {
                print(err.localizedDescription)
            }
        }
        
        //dismiss and reload tableview
        self.dismiss(animated: true)
        self.tableView.reloadData()
    }


}

class ReminderDataSource: NSObject, UITableViewDataSource {
    var reminders = [Reminder]()
    let dateFormatter = DateFormatter()
    
    func add(_ reminder: Reminder) {
        reminders.append(reminder)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath)
        let reminder = reminders[indexPath.row]
        dateFormatter.dateStyle = .long
        let dateDescription = dateFormatter.string(from: reminder.time)
        cell.textLabel!.text = reminder.description
        cell.detailTextLabel!.text = dateDescription
        return cell
    }
}
