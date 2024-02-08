//
//  WatchConnect.swift
//  Weather
//
//  Created by Руслан Гайфуллин on 08.02.2024.
//

import Foundation
import WatchConnectivity


final class WatchConnect: NSObject {
    
    static let shared = WatchConnect()
    
    private let session: WCSession
    
    override init() {
        guard WCSession.isSupported() else { fatalError() } // In a productive code, this should handled more gracefully
        self.session = WCSession.default
        super.init()
        self.session.delegate = self
        self.session.activate()
    }
    
    func sendDataToWatch() {
        let locations = CoreDataHandler.shared.fetchAllUserLocations()
        
        do {
            let locationsData = try NSKeyedArchiver.archivedData(withRootObject: locations, requiringSecureCoding: false)
            if session.isReachable {
                session.sendMessage(["locations" : locationsData], replyHandler: nil) { error in
                    print(error.localizedDescription)
                }
            }
        } catch {
            print("error archived Data")
            return
        }
    }
    
}

extension WatchConnect: WCSessionDelegate {
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    
}
