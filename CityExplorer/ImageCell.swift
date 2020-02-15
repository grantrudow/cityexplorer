//
//  ImageCell.swift
//  CityExplorer
//
//  Created by Grant Rudow on 2/15/20.
//  Copyright © 2020 Grant Rudow. All rights reserved.
//

import Foundation
import SwiftUI

struct ImageCell: Identifiable {
    let id = UUID()
    let image: Image
}

let samplePhotos = [
       ImageCell(image: Image("samplePhoto")),
       ImageCell(image: Image("samplePhoto")),
       ImageCell(image: Image("samplePhoto")),
       ImageCell(image: Image("samplePhoto")),
       ImageCell(image: Image("samplePhoto")),
       ImageCell(image: Image("samplePhoto")),
       ImageCell(image: Image("samplePhoto")),
       ImageCell(image: Image("samplePhoto")),
       ImageCell(image: Image("samplePhoto")),
       ImageCell(image: Image("samplePhoto"))
   ]
