//
//  GoogleMapsVC.swift
//  LazaApp
//
//  Created by Ahmed on 28/03/2023.
//

import UIKit
import GoogleMaps


class GoogleMapsVC: UIViewController, GMSMapViewDelegate {
    @IBOutlet weak var map: GMSMapView!
    
    static let ID = String(describing: GoogleMapsVC.self)
    var latitude : Double?
    var longtude : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        map.delegate = self
        showLocation()
        // Do any additional setup after loading the view.
    }
    
    func showLocation(){
        let camera = GMSCameraPosition(latitude:  CLLocationDegrees(latitude!) , longitude:  CLLocationDegrees(longtude!), zoom: 15)
        map.camera = camera
        let coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longtude!)
        var marker = GMSMarker(position: coordinate)
        marker.map = map
    }
    
    
    @IBAction func showOrderplace(_ sender: Any) {
         showLocation()
    } 
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
}
