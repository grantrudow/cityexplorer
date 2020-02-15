//
//  APIHelper.swift
//  CityExplorer
//
//  Created by Grant Rudow on 2/15/20.
//  Copyright © 2020 Grant Rudow. All rights reserved.
//

import Foundation

let apiKey = "cb858704d068344c649e5825fcc96ffc"

func generateFlickrURL(latitude: Double, longitude: Double, numberOfPhotos: Int) -> String {
    let url = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=cb858704d068344c649e5825fcc96ffc&lat=48.864716&lon=2.349014&radius=1&radius_units=km&per_page=40&format=json&nojsoncallback=1"
    return url
}
