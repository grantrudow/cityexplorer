//
//  ObservableObject.swift
//  CityExplorer
//
//  Created by Grant Rudow on 2/15/20.
//  Copyright © 2020 Grant Rudow. All rights reserved.
//

import Foundation
import MapKit

class LocationManager: ObservableObject {
    
    var userLocationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    
    
    //Default region set to Paris
    @Published var currentRegion = MKCoordinateRegion(center: CLLocation(latitude: 48.864716, longitude: 2.349014).coordinate, latitudinalMeters: CLLocationDistance(10000), longitudinalMeters: CLLocationDistance(10000))
    
    //Checks to see if permission has been requested and if not, requests for permission
    func requestPermission() {
        if self.authorizationStatus == .notDetermined {
            self.userLocationManager.requestAlwaysAuthorization()
        }
        else {
            return
        }
    }
    
    //Allows us to zoom into the user location by tapping button
    func goToUserLocation() {
        
        guard let userLocation = userLocationManager.location?.coordinate
            else {return}
        
        currentRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: CLLocationDistance(10000), longitudinalMeters: CLLocationDistance(10000))
    }
    
    
    init() {
        requestPermission()
        
        //checks to see if we know the users location
        guard let userLocation = userLocationManager.location?.coordinate
            else {return}
        
        //if we don't know the users location this will not be used and it'll go to the default of Paris
        currentRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: CLLocationDistance(1000), longitudinalMeters: CLLocationDistance(10000))
    }
}

