//
//  CMAppDependencies.swift
//  Camden Market
//
//  Created by Josh Campion on 30/11/2015.
//  Copyright © 2015 Market Tech UK. All rights reserved.
//

import Foundation

enum RequestCacheType : String {
    case Test = "test_"
    case Live = "live_"
}

public protocol RequestCacheKey {
 
    var keyString:String { get }
    
    static var allValues:[Self] { get }
}

public protocol RequestCache {
    
    typealias RequestCacheKeyType:RequestCacheKey
    
    func getFullKey(string:String) -> String
    
    func timeSinceLastRequest(string:String) -> NSTimeInterval?
    
    func shouldIgnoreCacheForRequest(string:String, basedOnInterval interval:NSTimeInterval) -> Bool
    
    func successfullyRequested(string:String)
    
    func clearCachedRequestDates()
    
    // Enum methods
    
    func shouldIgnoreCacheForRequest(key:RequestCacheKeyType, basedOnInterval interval:NSTimeInterval) -> Bool
    
    func successfullyRequested(key:RequestCacheKeyType)
    
    func getFullKey(key:RequestCacheKeyType) -> String
}

public extension RequestCache {

    public func getFullKey(string:String) -> String {
        #if TESTING
            return RequestCacheType.Test.rawValue + string
        #else
            return RequestCacheType.Live.rawValue + string
        #endif
    }
    
    public func dateOfLastRequest(string:String) -> NSDate? {
        
        let fullKey:String = getFullKey(string)
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.objectForKey(fullKey) as? NSDate
    }
    
    public func timeSinceLastRequest(string:String) -> NSTimeInterval? {
        
        
        if let dateOfLastRequest = dateOfLastRequest(string) {
            let elapsedTime = NSDate().timeIntervalSinceDate(dateOfLastRequest)
            return elapsedTime
        }
    
        return nil
    }
    
    public func shouldIgnoreCacheForRequest(string:String, basedOnInterval interval:NSTimeInterval = 180) -> Bool{
        if let time = timeSinceLastRequest(string) {
            return time > interval
        }
        return true
    }

    public func successfullyRequested(string:String) {
        let fullKey:String = getFullKey(string)
        let defaults = NSUserDefaults.standardUserDefaults()
        dispatch_async(dispatch_get_main_queue()) { () -> () in
            defaults.setObject(NSDate(), forKey: fullKey)
            defaults.synchronize()
        }
    }
    
    /// Removes all the dates set for successful requests
    public func clearCachedRequestDates() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        for cacheKey in RequestCacheKeyType.allValues {
            let fullKey:String = getFullKey(cacheKey)
            defaults.removeObjectForKey(fullKey)
        }
    }
    
    public func shouldIgnoreCacheForRequest(key:RequestCacheKeyType, basedOnInterval interval:NSTimeInterval = 180) -> Bool{
        return shouldIgnoreCacheForRequest(key.keyString, basedOnInterval: interval)
    }
    
    public func successfullyRequested(key:RequestCacheKeyType) {
        successfullyRequested(key.keyString)
    }
    
    public func dateOfLastRequest(key:RequestCacheKeyType) -> NSDate? {
        return dateOfLastRequest(key.keyString)
    }
    
    public func getFullKey(key:RequestCacheKeyType) -> String {
        return getFullKey(key.keyString)
    }
}
