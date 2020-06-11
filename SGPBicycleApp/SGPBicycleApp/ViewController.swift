//
//  ViewController.swift
//  SGPBicycleApp
//
//  Created by kpugame on 2020/06/11.
//  Copyright © 2020 SONCHAEYOUNG. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    
    
       var imageView : UIImageView!
       
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // testff
        // ttttest
        let image = UIImage(named: "img_subway.png")!
                imageView = UIImageView(image: image)
                //이미지사이즈만하게 사각형그리셈
                imageView.frame = CGRect(origin:  CGPoint(x:0,y:0), size: image.size)
                scrollView.addSubview(imageView)
                
                //2.수직수평으로 스크롤하는 컨텐츠크기를 이미지크기로설정
                scrollView.contentSize = image.size
                
                //3. 줌인하기위해 더블 탭 레코나이저 설정
        let doubleTapReconizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.scrollViewDoubleTapped(_ :)))
                doubleTapReconizer.numberOfTapsRequired = 2
                doubleTapReconizer.numberOfTouchesRequired = 1
                
                //4. 최대 줌아웃 했을 때 이미지를 한 화면을 보기위해 미니멈줌스캥일설정
                
                let scrollViewFrame = scrollView.frame
                let scaleWidth = scrollViewFrame.size.width/scrollView.contentSize.width
                let scaleHeight = scrollViewFrame.size.height/scrollView.contentSize.height
                let minScale = min(scaleWidth, scaleHeight)
                scrollView.minimumZoomScale = minScale
                
                //5 원본이미지보다 확대하면 깨지니까 1.0까지만
                
                scrollView.maximumZoomScale = 1.0
                scrollView.zoomScale = minScale
                
                //6 스크롤 뷰 안에 이미지를 가운데 오도록하는 핼퍼 메소드 호출
                centerScrollViewContents()
                
                // Do any additional setup after loading the view.
            }
            func centerScrollViewContents() {
                let boundsSize = scrollView.bounds.size
                var contensFrame = imageView.frame
                //이미지 크기가 화면보다 작으면 오리진 위치를 가운대로 옮김
                if contensFrame.size.width < boundsSize.width{
                    contensFrame.origin.x = (boundsSize.width - contensFrame.size.width) / 2.0
                }else{
                    contensFrame.origin.x = 0.0
                }
                if contensFrame.size.height < boundsSize.height{
                    contensFrame.origin.y = (boundsSize.height - contensFrame.size.height) / 2.0
                }else{
                    contensFrame.origin.y = 0.0
                }
                imageView.frame = contensFrame
            }

            @objc func scrollViewDoubleTapped(_ recognizer: UITapGestureRecognizer){
                 let pointInView = recognizer.location(in: imageView)
                //2. 150% lotG| ZICH maximumZoomScale 7/24 01
                var newZoomScale = scrollView.zoomScale * 1.5
                newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)
                
                let scrollViewSize = scrollView.bounds.size
                let w = scrollViewSize.width / newZoomScale
                let h = scrollViewSize.height / newZoomScale
                let x = pointInView.x - (w / 2.0)
                let y = pointInView.y - (h / 2.0)
                let rectToZoomTo = CGRect(x: x, y: y, width: w, height: h)
                
                scrollView.zoom(to: rectToZoomTo, animated: true)

            }
            //스크롤뷰 컨트롤러를위한 메서드
            func viewForZooming(in scrollView: UIScrollView) -> UIView? {
                return imageView
            }
            //스크롤 다하면 원래대로 돌아오도록하는 메서드
            func scrollViewDidZoom (_ scrollView: UIScrollView) {
            centerScrollViewContents()
            }
        }

