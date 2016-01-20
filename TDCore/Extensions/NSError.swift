//
//  NSError.swift
//  Interchange
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 Interchange Management Ltd. All rights reserved.
//

import Foundation

public extension NSError {
    
    /// Converts an NSURLError to have a more friendly user error message using the `userFacingDescription()` and `userFacingRecoverySuggestion()` methods on `NSURLError`.
    public func userFacingError() -> NSError {
        if self.domain == NSURLErrorDomain,
            let code = NSURLError(rawValue: code),
            let userDescription = code.userFacingDescription() {
                
                var newInfo = userInfo
                newInfo[NSLocalizedDescriptionKey] = userDescription
                newInfo[NSLocalizedRecoverySuggestionErrorKey] = code.userFacingRecoverySuggestion()
                
                let errorToReturn = NSError(domain: domain, code:self.code, userInfo:newInfo)
                
                return errorToReturn
        } else {
            return self
        }
    }
}

public extension NSURLError {
    
    /// Returns a more friendly error than 'NSURL error -1001`.
    public func userFacingDescription() -> String? {
        switch self {
        case .NotConnectedToInternet:
            return "Your device is not connected to the internet."
        case .TimedOut:
            return "The request timed out."
        case .CannotFindHost:
            return "Unable to find server."
        case .CannotConnectToHost:
            return "Unable to connect to server."
        default:
            return nil
        }
    }
    
    /// Returns a more friendly error than 'NSURL error -1001`.
    public func userFacingRecoverySuggestion() -> String? {
        
        switch self {
        case .NotConnectedToInternet:
            return "Please connect to the internet and try again."
        case .TimedOut, .CannotFindHost, .CannotConnectToHost:
            return "Please check your internet connection and try again."
        default:
            return nil
        }
        
    }
}