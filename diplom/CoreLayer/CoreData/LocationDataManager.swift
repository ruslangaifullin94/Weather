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
