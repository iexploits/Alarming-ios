//
//  ViewController.swift
//  Alarming
//
//  Created by Jae Heo on 18/06/2019.
//  Copyright © 2019 iExploits. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController{
    
    @IBOutlet weak var dasMAP: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initCamera()
        geocodeTest()
    }
    
    func initCamera()
    {
        // This Setting is targeting for Full-Screen of Korea-Centered-View. It includes Jeju-island too.
        let camera = GMSCameraPosition.camera(withLatitude: 35.909193,longitude: 127.638828, zoom: 7)
        dasMAP.setMinZoom(3, maxZoom: 7)
        dasMAP.delegate = self
        dasMAP.camera = camera
        dasMAP.isMyLocationEnabled = true
    }
    
    func geocodeTest()
    {
        /**
         지진 : 파란색
         산불, 화재 : 빨간색
         
        */
        
        DASGeocoder.shared.geocode("울진군"){ (results, error) in
            
            // Update UI
            if let address = results?.first, error == nil {
                DispatchQueue.main.async {
                    let circleCenter = CLLocationCoordinate2D(latitude: address.coordinate!.latitude, longitude: address.coordinate!.longitude)
                    let circ = GMSCircle(position: circleCenter, radius: 10000)
                    circ.fillColor = UIColor(red: 0, green: 0, blue: 0.35, alpha: 0.30)
                    circ.strokeColor = .red
                    circ.strokeWidth = 0.5
                    circ.isTappable = true
                    
                    circ.map = self.dasMAP
                }
            }
            
        }
        
        DASGeocoder.shared.geocode("천마산"){ (results, error) in
            
            // Update UI
            if let address = results?.first, error == nil {
                DispatchQueue.main.async {
                    let circleCenter = CLLocationCoordinate2D(latitude: address.coordinate!.latitude, longitude: address.coordinate!.longitude)
                    let circ = GMSCircle(position: circleCenter, radius: 20000)
                    circ.fillColor = UIColor(red: 0.35, green: 0, blue: 0, alpha: 0.30)
                    circ.strokeColor = .purple
                    circ.strokeWidth = 0.5
                    circ.isTappable = true
                    
                    circ.map = self.dasMAP
                }
            }
            
        }
        
        
        DASGeocoder.shared.geocode("대구시청"){ (results, error) in
            
            // Update UI
            if let address = results?.first, error == nil {
                DispatchQueue.main.async {
                    let circleCenter = CLLocationCoordinate2D(latitude: address.coordinate!.latitude, longitude: address.coordinate!.longitude)
                    let circ = GMSCircle(position: circleCenter, radius: 30000)
                    circ.fillColor = UIColor(red: 0, green: 0.35, blue: 0, alpha: 0.30)
                    circ.strokeColor = .blue
                    circ.strokeWidth = 0.5
                    circ.isTappable = true
                    
                    circ.map = self.dasMAP
                }
            }
            
        }
    }
    
}

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        // create the alert
        let alert = UIAlertController(title: "My Title", message: "This is my message.", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
}
