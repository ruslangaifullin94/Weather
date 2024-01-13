//
//  LocationDataManager.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 28.10.2023.
//

import Foundation
import CoreData

protocol LocationDataManagerProtocol {
    func readLocation() -> [UserLocation]
    func updateLocation(_ location: UserLocation)
    func saveLocation(_ location: UserLocation)
    func deleteLocation()

}

class CoreDataHandler {
    static let shared = CoreDataHandler()
    
    private let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Locations")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
    }
    
    func saveUserLocation(_ userLocation: UserLocation) {
        let context = persistentContainer.viewContext
        let locationEntity = SavedLocation(context: context)
        locationEntity.latitude = userLocation.latitude
        locationEntity.longitude = userLocation.longitude
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchAllUserLocations() -> [UserLocation] {
        let context = persistentContainer.viewContext
        let request = SavedLocation.fetchRequest()
        
        do {
            let locationEntities = try context.fetch(request)
            let userLocations = locationEntities.map { UserLocation(longitude: $0.longitude, latitude: $0.latitude) }
            return userLocations
        } catch {
            print(error.localizedDescription)
            return [UserLocation(longitude: 0, latitude: 0)]
        }
    }
}

