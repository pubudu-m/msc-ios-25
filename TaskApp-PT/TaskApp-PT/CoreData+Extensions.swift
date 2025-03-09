//
//  CoreData+Extensions.swift
//  TaskApp-PT
//
//  Created by Pubudu Mihiranga on 2025-03-09.
//

import Foundation
import CoreData

extension CategoryEntity {
    var taskItems: [ItemEntity] {
        let set = items as? Set<ItemEntity> ?? []
        return set.sorted { $0.title ?? "" < $1.title ?? "" } // high order functions
    }
}
