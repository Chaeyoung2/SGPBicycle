//
//  TourInfoViewController.swift
//  SGPBicycleApp
//
//  Created by kpugame on 2020/06/24.
//  Copyright © 2020 SONCHAEYOUNG. All rights reserved.
//

import UIKit

class TourInfoViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var pageImages : [UIImage] = []
    var pageViews : [UIImageView?] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        // Do any additional setup after loading the view.
    }
    
    func setImage(){
        // url에서 받아온 사진
        if let url = URL(string: urlTourImage){
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
