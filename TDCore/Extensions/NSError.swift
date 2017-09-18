//
//  NSError.swift
//  TheDistanceCore
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import Foundation
import CoreLocation

public extension NSError {
    
    /// Converts an NSURLError to have a more friendly user error message using the `userFacingDescription()` and `userFacingRecoverySuggestion()` methods on `NSURLError`.
    public func userFacingError() -> NSError {
        
        switch domain {
        case NSURLErrorDomain:
            
            let urlError = URLError.Code(rawValue: code)
            return userFacingErrorWithUsingFacing(uf: urlError as UserFacing)
            
        case kCLErrorDomain:
            
            if let clError = CLError.Code(rawValue: code) {
                return userFacingErrorWithUsingFacing(uf: clError as UserFacing)
            }
            
        default:
            // do nothing
            return self
        }
        
        return self
    }
    
    /// - returns: A configured `NSError` object with updated `NSLocalizedDescription` and `NSLocalizedRecoverySuggestionErrorKey` if the values of `UserFacing` returned is not `nil`.
    public func userFacingErrorWithUsingFacing(uf:UserFacing) -> NSError {
        
        var newInfo = userInfo 
        newInfo[NSLocalizedDescriptionKey] = uf.userFacingDescription() ?? localizedDescription
        newInfo[NSLocalizedRecoverySuggestionErrorKey] = uf.userFacingRecoverySuggestion() ?? userInfo[NSLocalizedRecoverySuggestionErrorKey]
        
        let errorToReturn = NSError(domain: domain, code:self.code, userInfo:newInfo)
        
        return errorToReturn
    }
}

/**
 
 Protocol defining the requirements of an object to provide a 'User Friendly' string, such as 'Your device is not connected to the internet.' not 'NSURLError -1001'.
 
 Extensions are given for:
 
 - `NSURLError`
 - `CLError`
 
 */
public protocol UserFacing {
    
    /// -returns: A more friendly error than 'NSURL error -1001`.
    func userFacingDescription() -> String?
    
    /// -returns: A friendly suggestion such as 'Please connect to the internet and try again.'.
    func userFacingRecoverySuggestion() -> String?
}

/// Public implementation of `UserFacing` for url errors.
extension URLError.Code: UserFacing {
    
    /**
     
     Default implemntations provides responses for:
     
     - `.NotConnectedToInternet`
     - `.TimedOut`
     - `.CannotFindHost`
     - `.CannotConnectToHost`
     
    */
    public func userFacingDescription() -> String? {
        switch self {
        case .notConnectedToInternet:
            return "Your device is not connected to the internet."
        case .timedOut:
            return "The request timed out."
        case .cannotFindHost:
            return "Unable to find server."
        case .cannotConnectToHost:
            return "Unable to connect to server."
        default:
            return nil
        }
    }
    
    /**
     
     Default implemntations provides responses for:
     
     - `.NotConnectedToInternet`
     - `.TimedOut`
     - `.CannotFindHost`
     - `.CannotConnectToHost`
     
     */
    public func userFacingRecoverySuggestion() -> String? {
        
        switch self {
        case .notConnectedToInternet:
            return "Please connect to the internet and try again."
        case .timedOut, .cannotFindHost, .cannotConnectToHost:
            return "Please check your internet connection and try again."
        default:
            return nil
        }
        
    }
}

/// Public implementation of `UserFacing` for location errors.
extension CLError.Code: UserFacing {
    
    /// Default implementation returns errors for all `CLError` cases.
    public func userFacingDescription() -> String? {
        switch self {
        case .locationUnknown:
            return "Device location unknown."
        case .denied:
            return "Location usage permission denied."
        case .network:
            return "Unable to connect to network."
            case .headingFailure:
            return "Device heading unknown."
            case .regionMonitoringDenied:
            return "Region monitoring usage permission denied."
            case .regionMonitoringFailure:
                return "Unable to monitor region."
            case .regionMonitoringSetupDelayed:
                return "Could not monitor region immediately."
            case .regionMonitoringResponseDelayed:
            return "Unable to monitor region."
            case .geocodeFoundNoResult:
            return "No results found."
            case .geocodeFoundPartialResult:
            return "Only partial results found."
            case .geocodeCanceled:
            return "Geocoding cancelled."
            case .deferredFailed:
            return "Location fetch failed."
            case .deferredNotUpdatingLocation:
            return "Location fetch failed."
            case .deferredAccuracyTooLow:
            return "Location fetch failed."
            case .deferredDistanceFiltered:
            return "Location fetch failed."
            case .deferredCanceled:
            return "Location fetch cancelled."
            case .rangingUnavailable:
            return "Ranging is disabled."
            case .rangingFailure:
            return "Ranging failed."
        }
    }
    
    /// Default implementation returns errors for all `CLError` cases.
    public func userFacingRecoverySuggestion() -> String? {
        switch self {
        case .locationUnknown:
            return "Please try again shortly."
        case .denied:
            return "Please enable location usage in your device's Settings."
        case .network:
            return "Please check your network connection and try again."
        case .headingFailure:
            return "Please try again shortly."
        case .regionMonitoringDenied:
            return "Please enable location usage and region monitoring in your device's Settings."
        case .regionMonitoringFailure:
            return "Please contact support if the problem persists."
        case .regionMonitoringSetupDelayed:
            return "Please try again shortly."
        case .regionMonitoringResponseDelayed:
            return "Please try again shortly."
        case .geocodeFoundNoResult:
            return "Please search for a different term."
        case .geocodeFoundPartialResult:
            return "Please search for a different term."
        case .geocodeCanceled:
            return nil
        case .deferredFailed:
            return "Please try again shortly."
        case .deferredNotUpdatingLocation:
            return "Please contact support if the problem persists."
        case .deferredAccuracyTooLow:
            return "Please contact support if the problem persists."
        case .deferredDistanceFiltered:
            return "Please contact support if the problem persists."
        case .deferredCanceled:
            return nil
        case .rangingUnavailable:
            return "Please check your network connection, enable location usage and try again."
        case .rangingFailure:
            return "Please try again shortly."
        }
    }
}
