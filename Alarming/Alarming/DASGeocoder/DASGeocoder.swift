//
//  DASGeocoder.swift
//  Alarming
//
//  Created by Jae Heo on 18/06/2019.
//  Copyright © 2019 iExploits. All rights reserved.
//

import UIKit
import CoreLocation

public enum DASGeocoderError: Error {
    case InvalidCoordinate
    case InvalidAddressString
    case Internal
}

/// Google Geocoding API const
private let googleMapsBaseURL = "https://maps.googleapis.com/maps/api/geocode/json?sensor=true"

/// Handler that reports a geocoding response, or error.
public typealias DASGeocoderCallback = (_ results: Array<DASAddress>?, _ error: Error?) -> Void

/// Exposes a service for geocoding and reverse geocoding.
open class DASGeocoder {
    
    // MARK: - PROPERTIES
    
    /**
     Members
     
     1. isGeocoding : The State Value for checking geocoding is ongoing.
     2. googleAPIKey : API Key for Google Geocoding.
     3. googleGeocoderTask : URLSessionDataTask for GoogleGeocoder
     
     */
    
    private(set) var isGeocoding: Bool = false
    public var googleAPIKey: String? = "AIzaSyBtSjas8iIDwAIEyOZUbGTwhsScM6MdxYs"
    private lazy var googleGeocoderTask: URLSessionDataTask? = nil
    
    // MARK: SINGLETON
    
    public static let shared = DASGeocoder()
    
    // MARK: PUBLIC

    /**
     
     Geocode Method :: Request Geocode using Address ( String )
     
     - Parameters:
     1. address: The string you want to geocode ( find ).
     2. completionHandler: CallBackHandler
     
     - Descriptions:
     After Checking String address's Validity, call GoogleAPI Service for geocoding.
     There's guard syntax for checking validity of Address data.
     If it's not valid, Geocode Service will be off.
     
     */
    open func geocode(_ address: String, completionHandler: DASGeocoderCallback?) {
        
        isGeocoding = true
        
        // Check adress string
        guard address.count != 0 else {
            
            isGeocoding = false
            if let completionHandler = completionHandler {
                completionHandler(nil, DASGeocoderError.InvalidAddressString)
            }
            return
        }
        
        // Geocode using Google service
        var urlString = googleMapsBaseURL + "&address=\(address)"
        if let key = googleAPIKey {
            urlString = urlString + "&key=" + key
        }
        buildAsynchronousRequest(urlString: urlString) { (results, error) in
            
            self.isGeocoding = false
            if let completionHandler = completionHandler {
                completionHandler(results, error)
            }
        }
    }
    
    
    /**
     
     ReverseGeocode Method :: Location data 2 Geocode.
     
     - Parameters:
     1. coordinate: location data
     2. completionHandler: CallBackHandler
     
     - Descriptions:
     After Checking Location data's Validity, call GoogleAPI Service for reverse geocoding.
     There's guard syntax for checking validity of Location data.
     If it's not valid, Geocode Service will be off.
     
     */
    open func reverseGeocode(_ coordinate: CLLocationCoordinate2D, completionHandler: DASGeocoderCallback?) {
        
        isGeocoding = true
        
        // If Location data is not valid,
        guard CLLocationCoordinate2DIsValid(coordinate) else {
            
            isGeocoding = false
            if let completionHandler = completionHandler {
                completionHandler(nil, DASGeocoderError.InvalidCoordinate)
            }
            return
        }
        
        
        // Call Google API Service for Reverse geocoding
        var urlString = googleMapsBaseURL + "&latlng=\(coordinate.latitude),\(coordinate.longitude)"
        if let key = googleAPIKey {
            urlString = urlString + "&key=" + key
        }
        buildAsynchronousRequest(urlString: urlString) { (results, error) in
            
            self.isGeocoding = false
            if let completionHandler = completionHandler {
                completionHandler(results, error)
            }
            
        }
    }
    
    // Method for canceling Geocoding Task.
    open func cancelGeocode() {
        googleGeocoderTask?.cancel()
    }
    
    /*
     
     Internal Method for Building asynchronous request
     
     
     
     */
    func buildAsynchronousRequest(urlString: String, completionHandler: DASGeocoderCallback?) {
        
        let urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url = URL(string: urlString)!
        
        googleGeocoderTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if let data = data, error == nil {
                
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, Any>
                    
                    // Check for response's status. If it is "OK", It'll getting start formatting geocode data.
                    if let status = result["status"] as? String, status == "OK" {
                        let locationDicts = result["results"] as? Array<AnyObject>
                        let finalResults = self.parseGeocodingResponse(locationDicts)
                        if let completionHandler = completionHandler {
                            completionHandler(finalResults, nil)
                        }
                    }
                        // Not "OK" status, It'll care it by ErrorHandler
                    else {
                        if let completionHandler = completionHandler {
                            completionHandler(nil, error)
                        }
                    }
                }
                catch {
                    // Parse failed --> Return error
                    if let completionHandler = completionHandler {
                        completionHandler(nil, error)
                    }
                }
            }
            else {
                // Request failed --> Return error
                if let completionHandler = completionHandler {
                    completionHandler(nil, error)
                }
            }
        })
        googleGeocoderTask?.resume()
    }
    
    /// Parse geocoding response
    func parseGeocodingResponse(_ results: Array<AnyObject>?) -> Array<DASAddress>? {
        
        guard let results = results else { return nil }
        
        var finalResults = Array<DASAddress>()
        for respondObject in results {
            let address = DASAddress(locationData: respondObject)
            finalResults.append(address)
        }
        return finalResults
    }
}
