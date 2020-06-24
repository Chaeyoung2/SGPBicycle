//
//  TourViews.swift
//  SGPBicycleApp
//
//  Created by kpugame on 2020/06/24.
//  Copyright © 2020 SONCHAEYOUNG. All rights reserved.
//

import Foundation
import MapKit

class TourMarkerView: MKMarkerAnnotationView{
    override var annotation: MKAnnotation?{
        willSet{
            // 1. callout 구성을 한다
            guard let tour = newValue as? Tour else {return}
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y:5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            // 2. pin icon을 각 discipline 의 첫 글자로 설정한다.
            markerTintColor = tour.markerTintColor
            glyphText = String(tour.discipline.first!)
        }
    }
}
