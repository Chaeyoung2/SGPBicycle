//
//  Tour.swift
//  SGPBicycleApp
//
//  Created by kpugame on 2020/06/24.
//  Copyright © 2020 SONCHAEYOUNG. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Tour: NSObject, MKAnnotation{
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    init?(_title: String, _locationName : String, _discipline : String, _latitude : String, _longitude: String){
        // 1. title 이 있다면 (json[16]) 설정하고 nil 이면 "No Title"
        self.title = _title
        self.locationName = _locationName
        self.discipline = _discipline
        // 2. latitude, longitude는 String에서 Double로 변경
        if let latitude = Double(_latitude ),
            let longitude = Double(_longitude ){
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else{
            self.coordinate = CLLocationCoordinate2D()
        }
    }
    
    var subtitle: String?{
        return locationName
    }
    
    // 클래스에 추가하는 helper 메소드
    // MKPlacemark로부터 MKMapItem을 생성
    // info button을 누르면 MKMapItem을 오픈하게 됨
    func mapItem() -> MKMapItem{
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
//    
    // Customizing
    // Artwork.json 파일의 disciplines에 따라서 기념물 Monument는 red, 벽화 Mural은 cyan, 상패 Plaque는 blue, 조각 Sculpture는 Purple, other는 green
    var markerTintColor: UIColor{
        switch discipline{
        case "관광지":
            return .black
        case "문화시설":
            return .yellow
        case "행사/공연/축제":
            return .cyan
        case "여행코스":
            return .systemPink
        case "레포츠":
            return .blue
        case "숙박":
            return .purple
        case "쇼핑":
            return .orange
        case "음식점":
            return .red
        default:
            return .green
        }
    }
    
}
