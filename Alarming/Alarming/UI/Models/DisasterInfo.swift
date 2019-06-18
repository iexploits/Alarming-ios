//
//  DisasterInfo.swift
//  Alarming
//
//  Created by Jae Heo on 18/06/2019.
//  Copyright © 2019 iExploits. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

public enum DisasterType {
    case EarthQuake
    case Flood
    case ForestFire
    case Thsunami
}

class DisasterInfo {
    
    /*
     class DisasterInfo :: Data of Each Disaster Info.
     - It'll have the details of the disaster.
     What, Where, How Much,
     
     */
    
    private var type: DisasterType
    private var coordinate: CLLocationCoordinate2D?
    private var weight: Double?
    
    init(type: DisasterType, location: CLLocationCoordinate2D, weight: Double)
    {
        self.type = type
        coordinate = location
        self.weight = weight
    }
    
    
    // It's for Drawing Circle for Each Disaster Info.
    // It'll return GoogleMapsService Circle Object to use.
    func prepareDrawing() -> GMSCircle {
        let circle = GMSCircle(position: coordinate!, radius: 1000 * weight!)
        
        circle.strokeWidth = 3
        
        switch type
        {
        case .EarthQuake:
            circle.fillColor = UIColor(red: 0.35, green: 0, blue: 0, alpha: 0.05)
            circle.strokeColor = .red
            break
            
        case .Flood:
            circle.fillColor = UIColor(red: 0, green: 0.35, blue: 0, alpha: 0.05)
            circle.strokeColor = .green
            break
            
        case .ForestFire:
            circle.fillColor = UIColor(red: 0, green: 0, blue: 0.35, alpha: 0.05)
            circle.strokeColor = .blue
            break
            
        case .Thsunami:
            circle.fillColor = UIColor(red: 0.35, green: 0, blue: 0.35, alpha: 0.05)
            circle.strokeColor = .cyan
            break
        }
        
        return circle
    }
    
    
    
}
