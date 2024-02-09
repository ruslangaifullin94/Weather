//
//  WatchConnect.swift
//  Weather Watch Watch App
//
//  Created by Руслан Гайфуллин on 08.02.2024.
//

import Foundation
import WatchConnectivity

struct UserLocation: Decodable {
    let longitude: Double
    let latitude: Double
}

final class PhoneConnect: NSObject, WCSessionDelegate, ObservableObject {
    
    static let shared = PhoneConnect()
    
    var session: WCSession = WCSession.default
    
    @Published var locations: [UserLocation] = []
    
    override init() {
        super.init()
        // Настройка WatchConnectivity
        if WCSession.isSupported() {
//            session = WCSession.default
            session.delegate = self
            session.activate()
        }
        print(session.activationState)
    }
    
    private func receiveDataFromPhone(message: [String: Any]) {
        guard let data = message["locations"] as? Data else {
            return
        }
        do {
            let locations = try JSONDecoder().decode([UserLocation].self, from: data)
            DispatchQueue.main.async {
                self.locations.append(contentsOf: locations)
                print(self.locations)
            }
        } catch {
            print("Error decoding locations: \(error.localizedDescription)")
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        // Обработка полученных данных
     receiveDataFromPhone(message: message)
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error {
            print("session activation failed with error - \(error.localizedDescription)")
        }
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        receiveDataFromPhone(message: userInfo)
    }
              
    
}
