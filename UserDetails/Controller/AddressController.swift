//
//  AddressController.swift
//  UserDetails
//
//  Created by Ayush Suri on 11/07/20.
//  Copyright © 2020 Ayush Suri. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class AddressController: UIViewController {
    
    var add : Address?
    @IBOutlet weak var AddressField: UITextView!
    @IBOutlet weak var Map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        AddressField.text = "City: \((add?.city)!)\nStreet: \((add?.street)!)\nSuite: \((add?.suite)!)\nZipcode: \((add?.zipcode)!)"
   
        let lat = add?.geo.lat
        let lon = add?.geo.lng
        
        let lati = (lat! as NSString).doubleValue
        let longi = (lon! as NSString).doubleValue
   
    
        
        let location = CLLocationCoordinate2DMake(lati, longi)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        Map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.title = add?.city
        annotation.coordinate = location
        
        Map.addAnnotation(annotation)
    }
}
