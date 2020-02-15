//
//  MyMap.swift
//  CityExplorer
//
//  Created by Grant Rudow on 2/13/20.
//  Copyright © 2020 Grant Rudow. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit

struct MyMap: UIViewRepresentable {
    
    //zooms to currentRegion when it's updated
    @Binding var currentRegion: MKCoordinateRegion
    
    //Bind to Pin Annotation in ContentView
    @Binding var currentAnnotation: MKPointAnnotation?
    
    //Bind to user tap on pin to show location info
    @Binding var showPhotoGrid: Bool
    
    func makeCoordinator() -> MyMap.Coordinator {
        Coordinator(self)
    }
    
    //creates map
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        
        //for showing modal with more info on location
        map.delegate = context.coordinator
        
        //make sure the map shows the user's location
        map.showsUserLocation = true
        
        //gives coordinator access to map
        context.coordinator.map = map
        
        //make sure the map zooms to currentRegion when being initialized
        map.setRegion(currentRegion, animated: true)
        
        //Enables user to long press and drop a pin
        let longPress = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.didLongPress(gesture:)))
        //user must press for at least one second
        longPress.minimumPressDuration = 1.0
        map.addGestureRecognizer(longPress)
        
        return map
    }
    
    //update the function if necessary
    func updateUIView(_ map: MKMapView, context: Context) {
        
        //currentAnnotation should be added to the map
        if currentAnnotation != nil {
            //ensures user can only add on annotation at a time
            map.removeAnnotations(map.annotations)
            map.addAnnotation(currentAnnotation!)
        }
        
        //zooms map to the assigned MKCoordinate Region
        map.setRegion(currentRegion, animated: true)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
        
        var parent: MyMap
        
        //add optional map property for annotation drop
        var map: MKMapView?
        
        init(_ parent: MyMap) {
            self.parent = parent
        }
        
        //adds didLongPress method to Coordinator
        @objc func didLongPress(gesture: UITapGestureRecognizer) {
            //only drops pin once
            if gesture.state == UIGestureRecognizer.State.began {
                //Drop Pin Annotation
                let touchedPoint = gesture.location(in: gesture.view)
                guard let touchedCoordinates = map?.convert(touchedPoint, toCoordinateFrom: map)
                    else {return}
                
                //create corresponding MKPointAnnotation
                let newAnnotation = MKPointAnnotation()
                newAnnotation.title = "Tap to see photos"
                newAnnotation.coordinate = CLLocationCoordinate2D(latitude: touchedCoordinates.latitude, longitude: touchedCoordinates.longitude)
                parent.currentAnnotation = newAnnotation
                //Move map to dropped pin
                parent.currentRegion = MKCoordinateRegion(center: newAnnotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            } else {
                return
            }
        }
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            parent.showPhotoGrid = true
        }
    }
}

//guard statement will make sure that it has been succeeded before continuing 
