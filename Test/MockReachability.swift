//
//  MockReachability.swift
//  edX
//
//  Created by Akiva Leffert on 5/19/15.
//  Copyright (c) 2015 edX. All rights reserved.
//

import UIKit

class MockReachability: NSObject, Reachability {
    
    var reachableBlock : NetworkReachable?
    var unreachableBlock : NetworkUnreachable?
    
    func isReachableViaWiFi() -> Bool {
        return networkStatus.wifi
    }
    
    func isReachableViaWWAN() -> Bool {
        return networkStatus.wwan
    }
    
    func isReachable() -> Bool {
        return networkStatus.wifi || networkStatus.wwan
    }
    
    var notifierEnabled = false
    var networkStatus = (wifi : true, wwan : true) {
        didSet {
            if notifierEnabled {
                if isReachable() {
                    self.reachableBlock?(self)
                }
                else {
                    self.unreachableBlock?(self)
                }
                NSNotificationCenter.defaultCenter().postNotificationName(kReachabilityChangedNotification, object: self)
            }
        }
    }
    
    func startNotifier() -> Bool {
        notifierEnabled = true
        return true
    }
    
    func stopNotifier() {
        notifierEnabled = false
    }

}
