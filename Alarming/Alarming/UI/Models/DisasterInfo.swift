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

public enum SNSType {
    case Twitter
    case DCinside
    case Facebook
}

class SNSFeed {
    
    private var type: SNSType
    private var time: String
    private var content: String
    
    init(type: SNSType, time: String, content: String)
    {
        self.type = type
        self.time = time
        self.content = content
    }
    
}

class DisasterInfo {
    
    /*
     class DisasterInfo :: Data of Each Disaster Info.
     - It'll have the details of the disaster.
     What, Where, How Much,
     
     */
    
    private var type: DisasterType
    private var coordinate: CLLocationCoordinate2D?
    private var location: String!
    private var weight: Double?
    private var time: String!
    
    private var feed_list: Array<SNSFeed>
    
    init(type: DisasterType, coordinate: CLLocationCoordinate2D, location: String, weight: Double, time: String)
    {
        self.type = type
        self.coordinate = coordinate
        self.location = location
        self.weight = weight
        self.time = time
        self.feed_list = Array<SNSFeed>()
    }
    
    func ADD_snsFeed(type: SNSType, time: String, content: String) {
        feed_list.append(
            SNSFeed(type: type, time: time, content: content))
    }
    
    func prepareSNSList() -> Array<SNSFeed> {
        return feed_list
    }
    
    func prepareDisasterName() -> String {
        var name: String
        switch type
        {
        case .EarthQuake:
            name = "지 진"
            break
        case .Flood:
            name = "홍 수"
            break
            
        case .ForestFire:
            name = "산 불"
            break
            
        case .Thsunami:
            name = "쓰 나 미"
            break
        }
        return name
    }
    
    func prepareDisasterImage() -> UIImage {
        var image: UIImage
        switch type
        {
        case .EarthQuake:
            image = UIImage(named: "EarthQuake")!
            break
        case .Flood:
            image = UIImage(named: "EarthQuake")!
            break
            
        case .ForestFire:
            image = UIImage(named: "ForestFire")!
            break
            
        case .Thsunami:
            image = UIImage(named: "ForestFire")!
            break
        }
        return image
    }
    
    
    // It's for Drawing Circle for Each Disaster Info.
    // It'll return GoogleMapsService Circle Object to use.
    func prepareDrawing() -> GMSCircle {
        let circle = GMSCircle(position: coordinate!, radius: 10000 * weight!)
        
        circle.strokeWidth = 0.8
        
        switch type
        {
        case .EarthQuake:
            circle.fillColor = UIColor(red: 0.35, green: 0, blue: 0, alpha: 0.20)
            circle.strokeColor = .red
            break
            
        case .Flood:
            circle.fillColor = UIColor(red: 0, green: 0.35, blue: 0, alpha: 0.20)
            circle.strokeColor = .green
            break
            
        case .ForestFire:
            circle.fillColor = UIColor(red: 0, green: 0, blue: 0.35, alpha: 0.20)
            circle.strokeColor = .blue
            break
            
        case .Thsunami:
            circle.fillColor = UIColor(red: 0.35, green: 0, blue: 0.35, alpha: 0.20)
            circle.strokeColor = .cyan
            break
        }
        
        return circle
    }
    
    
    
}
