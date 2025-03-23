//
//  CoreDataService.swift
//  WeatherApp-PT
//
//  Created by Pubudu Mihiranga on 2025-03-23.
//

import Foundation
import CoreData

protocol CoreDataServiceProtocol {
    func cacheWeather(latitute: Double, longitude: Double, data: WeatherResponse)
    func fetchWeather(latitute: Double, longitude: Double) -> CachedWeather?
    func invalidateCache(latitute: Double, longitude: Double)
    func clearAllCache()
}

class CoreDataService: CoreDataServiceProtocol {
    static let shared = CoreDataService()
    private let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "WeatherCoreDataModel")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load CoreData model: \(error)")
            }
        }
    }
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func cacheWeather(latitute: Double, longitude: Double, data: WeatherResponse) {
        let cache = CachedWeather(context: context)
        cache.latitude = latitute
        cache.longitude = longitude
        cache.timestamp = Date()
        cache.data = try? JSONEncoder().encode(data)
        
        do {
            try context.save()
        } catch {
            print("Failed to cache data \(error)")
        }
    }
    
    func fetchWeather(latitute: Double, longitude: Double) -> CachedWeather? {
        let request: NSFetchRequest<CachedWeather> = CachedWeather.fetchRequest()
        request.predicate = NSPredicate(format: "latitude == %lf AND longitude == %lf", latitute, longitude)
        return try? context.fetch(request).first
    }
    
    func invalidateCache(latitute: Double, longitude: Double) {
        let request: NSFetchRequest<CachedWeather> = CachedWeather.fetchRequest()
        request.predicate = NSPredicate(format: "latitude == %lf AND longitude == %lf", latitute, longitude)
        
        do {
            let results = try context.fetch(request)
            for object in results {
                context.delete(object)
            }
            try context.save()
        } catch {
            print("Failed to invalidate cache: \(error)")
        }
    }
    
    func clearAllCache() {
        let request: NSFetchRequest<NSFetchRequestResult> = CachedWeather.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to clear cache \(error)")
        }
    }
}
