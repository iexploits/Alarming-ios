//
//  DASAddress.swift
//  Alarming
//
//  Created by Jae Heo on 18/06/2019.
//  Copyright © 2019 iExploits. All rights reserved.
//

import UIKit
import CoreLocation
import Contacts

/// A result from a reverse geocode request, containing a human-readable address.
/// Some of the fields may be nil, indicating they are not present.
public struct DASAddress {
    
    // MARK: - PROPERTIES
    
    /// The location coordinate.
    public var coordinate: CLLocationCoordinate2D?
    
    /// The formatted address.
    public var formattedAddress: String?
    
    /// An array of NSString containing formatted lines of the address.
    public var lines: [String]?
    
    /// The raw source object.
    public var rawSource: AnyObject?
    
    // MARK: - INIT
    
    /// Custom initialization with response from server.
    ///
    /// - Parameters:
    ///   - locationData: Response object recieved from server
    init(locationData: AnyObject) {
        
        self.parseGoogleResponse(locationData: locationData)
        
    }
    
    private mutating func parseGoogleResponse(locationData: AnyObject) {
        
        guard let locationDict = locationData as? Dictionary<String, Any> else { return }
        
        let formattedAddress = locationDict["formatted_address"] as? String
        
        var lat = 0.0
        var lng = 0.0
        if let geometry = locationDict["geometry"] as? Dictionary<String, Any> {
            if let location = geometry["location"] as? Dictionary<String, Any> {
                if let latitude = location["lat"] as? Double {
                    lat = Double(latitude)
                }
                if let longitute = location["lng"] as? Double {
                    lng = Double(longitute)
                }
            }
        }
        
        // We'll get Location Info, Address String, rawSource info.
        coordinate = CLLocationCoordinate2DMake(lat, lng)
        self.formattedAddress = formattedAddress
        lines = formattedAddress?.components(separatedBy: ", ")
        rawSource = locationData
    }
}
