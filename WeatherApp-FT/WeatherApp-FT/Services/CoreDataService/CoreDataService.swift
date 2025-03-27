//
//  CoreDataService.swift
//  WeatherApp-FT
//
//  Created by Pubudu Mihiranga on 2025-03-27.
//

import Foundation
import CoreData

class CoreDataService {
    static let shared = CoreDataService()
    private let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "CacheDataModel")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load core data stack \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveData(latitude: Double, longitude: Double, data: WeatherResponse) {
        let cache = WeatherEntity(context: context)
        cache.latitude = latitude
        cache.longitude = longitude
        cache.timestamp = Date()
        cache.data = try? JSONEncoder().encode(data)
        
        do {
            try context.save()
        } catch {
            print("failed to save data")
        }
    }
    
    func fetchData(latitude: Double, longitude: Double) -> WeatherEntity? {
        let request: NSFetchRequest<WeatherEntity> = WeatherEntity.fetchRequest()
        request.predicate = NSPredicate(format: "latitude == %lf AND longitude == %lf", latitude, longitude)
        return try? context.fetch(request).first
    }
}
