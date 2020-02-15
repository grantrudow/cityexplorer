//
//  ContentView.swift
//  CityExplorer
//
//  Created by Grant Rudow on 2/13/20.
//  Copyright © 2020 Grant Rudow. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @ObservedObject var locationManager = LocationManager()
    
    //Declares annotation for dropping pin
    @State var currentAnnotation: MKPointAnnotation?
    
    @State var showPhotoGrid = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                //Binds to MyMap location
                MyMap(currentRegion: $locationManager.currentRegion, currentAnnotation: $currentAnnotation, showPhotoGrid: $showPhotoGrid)
                Button(action : {
                    print(self.locationManager.goToUserLocation())
                }) {
                    LocationButtonContent()
                }
            }
            .sheet(isPresented: $showPhotoGrid) {
                PhotoGrid(latitudeToSearchFor: (self.currentAnnotation?.coordinate.latitude)!, longitudeToSearchFor: (self.currentAnnotation?.coordinate.longitude)!)
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Long-press to select location", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LocationButtonContent: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
            Image(systemName: "location")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 25, height: 25)
                .clipped()
                .foregroundColor(.black)
                .padding(40)
        }
    }
}
