//
//  VCMapView.swift
//  SGPBicycleApp
//
//  Created by kpugame on 2020/06/24.
//  Copyright © 2020 SONCHAEYOUNG. All rights reserved.
//


import Foundation
import MapKit

extension TourInfoViewController: MKMapViewDelegate{
    
    // 사용자가 지도 주석 마커를 tap 하면 설명 선에 info button이 표시.
    // info button을 누르면 mapView(_:annotationView:calloutAccessoryControlTapped:) 메서드가 호출
    // Artwork 탭에서 참조하는 객체 항목을 만들고 지도 항목을 MKMapItem 호출 하여 지도 앱을 실행
    // openInMaps(launchOptions:) 몇 가지 옵션을 지정할 수 있음. 여기는 DirectionModeKey로 Driving 설정
    // 이로 인해, 지도 앱에서 사용자의 현재 위치에서의 핀까지의 운전 경로를 표시
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        let location = view.annotation as! Tour
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    
    // 강의 후반부에 필요 없다고 할 내용들.. 주석 풀려면 command + / 하면 됨
//    // 1. mapView(_:viewFor:)는, tableView(_:cellForRowAt:) 테이블 보기로 작업 할 때와 마찬가지로, 지도에 추가하는 모든 주석이 호출되어 각 주석에 대한 보기를 반환.
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation)->MKAnnotationView?{
//        // 2. 이 주석(annotation)이 Artwork 객체인지 확인!!
//        // 그렇지 않으면 nil, 지도 뷰에서 기본 주석 뷰를 사용하도록 돌아감.
//        /// guard let : if let과 비슷, assure로 확인하는 것임. nil이 아니면 assign, nil이면 return
//        guard let annotation = annotation as? Artwork else {return nil}
//
//        // 3. 마커가 나타나도록 MKMarkerAnnotationView를 만듦.
//        /// 이 자습서 뒷부분에서는 MKAnnotationView 마커 대신 이미지를 표시하는 객체를 만듫ㅁ
//        let identifier = "marker"
//        var view: MKMarkerAnnotationView
//
//        // 4. 코드를 새로 생성하기 전, 재사용 가능한 주석 뷰를 사용할 수 있는지 확인
//        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//            as? MKMarkerAnnotationView{
//            dequeuedView.annotation = annotation
//            view = dequeuedView
//        }else{
//            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            view.canShowCallout = true
//            view.calloutOffset = CGPoint(x: -5, y: 5)
//            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//
//        }
//        return view
//    }
}
