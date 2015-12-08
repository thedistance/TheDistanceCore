//
//  CMAppDependencies.swift
//  Camden Market
//
//  Created by Josh Campion on 30/11/2015.
//  Copyright © 2015 Market Tech UK. All rights reserved.
//

import Foundation

/// Internal `enum` for  ensuring Automated Testing and Live builds don't share cached dates.
enum RequestCacheType : String {
    /// Suffixes a key if the `TESTING` linked flag is defined and visible to Swift.
    case Test = "test_"
    /// Suffixes a key for none testing situations
    case Live = "live_"
}

/// Notification Name posted when a request successfully completes. The object associated with this notificatoin is the `keyString` for this cached request.
public let RequestCacheSuccessfullyUpdatedNotificationKey = "UpdatedRequestCache"

/// Protocol defining the requirements of an object to be used as a key in a `RequestCache`.
public protocol RequestCacheKey {
 
    /// Required for caching the dates of successful request in `NSUserDefaults`.
    var keyString:String { get }
    
    /// Should return all the possible keys. This can be used to clear caches, such as on log out.
    static var allValues:[Self] { get }
}

/// Protocol defining the requirements for an object that can be used to determine expiration of a persistent store based on a time interval.
public protocol RequestCache {
    
    /// Key Type that can be used for calling methods using `enum`s.
    typealias RequestCacheKeyType:RequestCacheKey
    
    /// - retuns:
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
            
            NSNotificationCenter.defaultCenter().postNotificationName(RequestCacheSuccessfullyUpdatedNotificationKey, object: string)
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
