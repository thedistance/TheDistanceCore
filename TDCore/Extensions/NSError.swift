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
            
            if let urlError = NSURLError(rawValue: code) {
                return userFacingErrorWithUsingFacing(urlError)
            }
            
        case kCLErrorDomain:
            
            if let clError = CLError(rawValue: code) {
                return userFacingErrorWithUsingFacing(clError)
            }
            
        default:
            // do nothing
            return self
        }
        
        return self
    }
    
    public func userFacingErrorWithUsingFacing(uf:UserFacing) -> NSError {
        
        var newInfo = userInfo ?? [NSObject:AnyObject]()
        newInfo[NSLocalizedDescriptionKey] = uf.userFacingDescription() ?? localizedDescription
        newInfo[NSLocalizedRecoverySuggestionErrorKey] = uf.userFacingRecoverySuggestion() ?? userInfo[NSLocalizedRecoverySuggestionErrorKey]
        
        let errorToReturn = NSError(domain: domain, code:self.code, userInfo:newInfo)
        
        return errorToReturn
    }
}

public protocol UserFacing {
    
    /// -returns: A more friendly error than 'NSURL error -1001`.
    func userFacingDescription() -> String?
    
    /// -returns: A more friendly error than 'NSURL error -1001`.
    func userFacingRecoverySuggestion() -> String?
}

extension NSURLError: UserFacing {
    
    
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

extension CLError: UserFacing {
    
    public func userFacingDescription() -> String? {
        switch self {
        case .LocationUnknown:
            return "Device location unknown."
        case .Denied:
            return "Location usage permission denied."
        case .Network:
            return "Unable to connect to network."
            case .HeadingFailure:
            return "Device heading unknown."
            case .RegionMonitoringDenied:
            return "Region monitoring usage permission denied."
            case .RegionMonitoringFailure:
                return "Unable to monitor region."
            case .RegionMonitoringSetupDelayed:
                return "Could not monitor region immediately."
            case .RegionMonitoringResponseDelayed:
            return "Unable to monitor region."
            case .GeocodeFoundNoResult:
            return "No results found."
            case .GeocodeFoundPartialResult:
            return "Only partial results found."
            case .GeocodeCanceled:
            return "Geocoding cancelled."
            case .DeferredFailed:
            return "Location fetch failed."
            case .DeferredNotUpdatingLocation:
            return "Location fetch failed."
            case .DeferredAccuracyTooLow:
            return "Location fetch failed."
            case .DeferredDistanceFiltered:
            return "Location fetch failed."
            case .DeferredCanceled:
            return "Location fetch cancelled."
            case .RangingUnavailable:
            return "Ranging is disabled."
            case .RangingFailure:
            return "Ranging failed."
        }
    }
    
    public func userFacingRecoverySuggestion() -> String? {
        switch self {
        case .LocationUnknown:
            return "Please try again shortly."
        case .Denied:
            return "Please enable location usage in your device's Settings."
        case .Network:
            return "Please check your network connection and try again."
        case .HeadingFailure:
            return "Please try again shortly."
        case .RegionMonitoringDenied:
            return "Please enable location usage and region monitoring in your device's Settings."
        case .RegionMonitoringFailure:
            return "Please contact support if the problem persists."
        case .RegionMonitoringSetupDelayed:
            return "Please try again shortly."
        case .RegionMonitoringResponseDelayed:
            return "Please try again shortly."
        case .GeocodeFoundNoResult:
            return "Please search for a different term."
        case .GeocodeFoundPartialResult:
            return "Please search for a different term."
        case .GeocodeCanceled:
            return nil
        case .DeferredFailed:
            return "Please try again shortly."
        case .DeferredNotUpdatingLocation:
            return "Please contact support if the problem persists."
        case .DeferredAccuracyTooLow:
            return "Please contact support if the problem persists."
        case .DeferredDistanceFiltered:
            return "Please contact support if the problem persists."
        case .DeferredCanceled:
            return nil
        case .RangingUnavailable:
            return "Please check your network connection, enable location usage and try again."
        case .RangingFailure:
            return "Please try again shortly."
        }
    }
}