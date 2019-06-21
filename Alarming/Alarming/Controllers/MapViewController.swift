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
        
        getDisasterData(location: "천마산", type: DisasterType.ForestFire, weight: 1.4, time: "2019-06-21")
        getDisasterData(location: "포항시청", type: DisasterType.EarthQuake, weight: 2.0, time: "2019-06-21")
    }
    
    @IBAction func sideViewControllerButtonDidClicked(_ sender: Any)
    {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "SideViewController") else { return }
        viewController.view.backgroundColor = .white
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func presentViewControllerButtonClicked(_ sender: UIButton)
    {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "SideViewController") else { return }
        viewController.view.backgroundColor = .white
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissViewController))
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func menuBttonDidClicked(_ sender: Any)
    {
        sideMenuController?.revealMenu()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    // Initiating for Side Menu Controller Completed
    
    func initCamera()
    {
        // This Setting is targeting for Full-Screen of Korea-Centered-View. It includes Jeju-island too.
        let camera = GMSCameraPosition.camera(withLatitude: 35.909193,longitude: 127.638828, zoom: 7)
        dasMAP.setMinZoom(3, maxZoom: 7)
        dasMAP.delegate = self
        dasMAP.camera = camera
        dasMAP.isMyLocationEnabled = true
    }
    
    func getDisasterData(location: String, type: DisasterType, weight: Double, time: String)
    {
        /**
         지진 : 파란색
         산불, 화재 : 빨간색
         
        */
        DASGeocoder.shared.geocode(location){ (results, error) in
            
            // Update UI
            if let address = results?.first, error == nil {
                DispatchQueue.main.async {
                    let coordinate = CLLocationCoordinate2D(latitude:address.coordinate!.latitude, longitude:address.coordinate!.longitude)
                    
                    let disasterInfo = DisasterInfo(type: type, coordinate: coordinate, location: location, weight: weight, time: time)
                    
                    DisasterManager.sharedInstance.ADD_info(dInfo: disasterInfo)
                    
                    let circ = disasterInfo.prepareDrawing()
                    circ.isTappable = true
                    circ.map = self.dasMAP
                }
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is DetailViewController
        {
            let vc = segue.destination as? DetailViewController
            vc?.disaster = nil
        }
    }
    
}

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        
        self.performSegue(withIdentifier: "getDetailPage", sender: self)
    }
    
}
