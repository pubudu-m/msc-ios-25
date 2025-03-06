//
//  CoreData+Extensions.swift
//  RemindersApp
//
//  Created by Pubudu Mihiranga on 2025-03-06.
//

import Foundation
import CoreData

extension CategoryEntity {
    var remindersArray: [ReminderEntity] {
        let set = reminders as? Set<ReminderEntity> ?? []
        return set.sorted { $0.title ?? "" < $1.title ?? "" }
    }
}
