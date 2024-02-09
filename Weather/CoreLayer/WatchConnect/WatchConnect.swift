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
    
    private let session: WCSession = WCSession.default
    
    override init() {
        super.init()
        guard WCSession.isSupported() else {
            assertionFailure("WcSession not supported")
            return
        }
        self.session.delegate = self
        self.session.activate()
    }
    
    func sendDataToWatch(locations: [UserLocation]) {
        do {
            let locationsData = try JSONEncoder().encode(locations)
            let dict = ["locations": locationsData]
                session.sendMessage(dict, replyHandler: nil)
            
        } catch {
            print("error archived Data")
            return
        }
    }
    
}

extension WatchConnect: WCSessionDelegate {
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        session.activate()
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error {
            print("session activation failed with error - \(error.localizedDescription)")
        }
    }
    
}
