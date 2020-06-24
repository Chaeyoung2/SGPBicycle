//
//  TourInfoViewController.swift
//  SGPBicycleApp
//
//  Created by kpugame on 2020/06/24.
//  Copyright © 2020 SONCHAEYOUNG. All rights reserved.
//

import UIKit
import MapKit

class TourInfoViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    
    var pageImages : [UIImage] = []
    var pageViews : [UIImageView?] = []
    
    let initialLocation = CLLocation(latitude: (Xpos as NSString).doubleValue, longitude: (Ypos as NSString).doubleValue)
    // 이 지역은 regionRaduis (1000m) 거리에 따라 남북 및 동서에 걸쳐있을 것이다.
    let regionRadius: CLLocationDistance = 1000
    var tours: [Tour] = []
    
    
    override func viewDidLoad() {
        
        setImage()
        setTourInfoTextView()
        
        setLocation()
        centerMapOnLocation(location: initialLocation) // center를 initialLocation으로
        mapView.delegate = self // TourInfoViewController가 mapView의 delegate임을 설정
        mapView.register(TourMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        loadInitialData()
        mapView.addAnnotations(tours) // 배열을 전부 핀으로 표시
        // Do any additional setup after loading the view.
        
        super.viewDidLoad()
    }
    
    func showTourOnMap(){
        let tour = Tour(title: g_tourTitle, locationName: g_tourAddr, discipline: g_tourType,
                        coordinate: CLLocationCoordinate2D(latitude: (Xpos as NSString).doubleValue, longitude: (Ypos as NSString).doubleValue))
        mapView.addAnnotation(tour)
        
    }
    
    // Tour 객체 배열 생성
    func loadInitialData(){
        let validTours = Tour(title: g_tourTitle, locationName: g_tourAddr, discipline: g_tourType,
                                              coordinate: CLLocationCoordinate2D(latitude: (Xpos as NSString).doubleValue, longitude: (Ypos as NSString).doubleValue))
        tours.append(validTours)
    }
    
    // regionRadius을 사용. Json 파일에서 공용 아트웍 데이터를 폴로팅 하는 데 적합한 거리임.
    // setRegion은 region을 표시하도록 mapview에 지시
    func centerMapOnLocation(location: CLLocation){
        
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func setLocation(){
        _ = CLLocation(latitude: (Xpos as NSString).doubleValue, longitude: (Ypos as NSString).doubleValue)
        // print((Xpos as NSString).doubleValue)
        // print((Ypos as NSString).doubleValue)
    }
    
    func setImage(){
        // url에서 받아온 사진
        if let url = URL(string: urlTourImage){
//        if let url = URL(string: urlImage as String){
            if let data = try? Data(contentsOf: url){
                pageImages.append(UIImage(data:data)!)
            }
        }
        // 아무 사진.. 호선 사진으로 하자
        pageImages.append(UIImage(named: "line" + String(FindLine))!)
        // 페이지 개수
        let pageCount = pageImages.count
        // 페이지 컨트롤 관련 변수
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount
        // 페이지 개수만큼 페이지뷰 배열 원소를 nil로 생성, 나중에 로딩할 때 실제 페이지 이미지 가져옴
        for _ in 0..<pageCount{
            pageViews.append(nil)
        }
        let pageScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: pageScrollViewSize.width * CGFloat(pageImages.count), height: pageScrollViewSize.height)
        loadVisiblePages()
    }
    
    func loadVisiblePages(){
        let pageWidth = scrollView.frame.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        pageControl.currentPage = page
        
        let firstPage = page - 1
        let lastPage = page + 1
        
        for index in 0 ..< firstPage+1{
            purgePage((index))
        }
        
        for index in firstPage ... lastPage{
            loadPage(index)
        }
        
        for index in lastPage+1 ..< pageImages.count+1{
            purgePage(index)
        }
    }
    func loadPage(_ page: Int){
        if page < 0 || page >= pageImages.count{
            return
        }
        if pageViews[page] != nil{
            
        }else {
            
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .scaleAspectFit
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
            
            pageViews[page] = newPageView
        }
    }
    
    func purgePage(_ page: Int){
       if page < 0 || page >= pageImages.count{
                   return
               }
        
        if let pageView = pageViews[page]{
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
        }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        loadVisiblePages()
    }
    
    func setTourInfoTextView(){
        if(g_tourPhone == ""){
            self.textView.text = "주소: " + g_tourAddr + "\n전화번호: 번호가 없어요 〣(ºΔº)〣 " + g_tourPhone + "\n컨텐츠 유형: " + g_tourType
        }
        else {
            self.textView.text = "주소: " + g_tourAddr + "\n전화번호: " + g_tourPhone + "\n컨텐츠 유형: " + g_tourType
        }
         
        
        self.title = g_tourTitle
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
