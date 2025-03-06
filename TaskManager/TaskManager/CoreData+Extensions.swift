//
//  CoreData+Extensions.swift
//  TaskManager
//
//  Created by Pubudu Mihiranga on 2025-03-06.
//

import Foundation
import CoreData

extension CategoryEntity {
    var remindersArray: [TaskEntity] {
        let set = tasks as? Set<TaskEntity> ?? []
        return set.sorted { $0.title ?? "" < $1.title ?? "" }
    }
}
