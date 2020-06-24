//
//  TourViewController.swift
//  SGPBicycleApp
//
//  Created by kpugame on 2020/06/24.
//  Copyright © 2020 SONCHAEYOUNG. All rights reserved.
//

import UIKit

class TourViewController: UIViewController, XMLParserDelegate, UITableViewDataSource  {

    
    @IBOutlet var tbData: UITableView! // table view 데이터
    
    // xml 데이터 파싱 위한 변수
    var parser = XMLParser()
    var posts = NSMutableArray() // feed 데이터 저장
    var elements = NSMutableDictionary() // feed 데이터 저장
    var element = NSString()
    var tourAddr = NSMutableString()
    var tourTitle = NSMutableString()
    var urlImage = NSMutableString()
    
    var selectedCellNum = 0
    
    
    //전철역 코드로 위도경도 알려주는 xml파싱에 쓰이는 변수들
    var XPOINT_WGS = NSMutableString()
    var YPOINT_WGS = NSMutableString()

    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        settingInformation()
    }
    
    func beginParsing(){
        posts = []
        // 여행 정보
//        let strEncoded = self.escape(string: "http://api.visitkorea.or.kr/openapi/service/rest/KorService/locationBasedList?ServiceKey=eVQI4T2pv9%2F5bhGQP%2FxFgKhQDajSaNh9NvFwrxkHJG2zyQlbP1Ai8mcgkwzwJpRWfsBqh8zQPTptdp0NH3b0IA%3D%3D&mapX=126.882339&mapY=37.4810715&radius=1000&listYN=Y&arrange=A&MobileOS=ETC&MobileApp=AppTest​")
                let strEncoded = self.escape(string: "http://api.visitkorea.or.kr/openapi/service/rest/KorService/locationBasedList?ServiceKey=eVQI4T2pv9%2F5bhGQP%2FxFgKhQDajSaNh9NvFwrxkHJG2zyQlbP1Ai8mcgkwzwJpRWfsBqh8zQPTptdp0NH3b0IA%3D%3D&mapX=" + Ypos + "&mapY=" + Xpos + "&radius=1000&listYN=Y&arrange=A&MobileOS=ETC&MobileApp=AppTest​")
        parser = XMLParser(contentsOf: (URL(string:strEncoded))!)!
        parser.delegate = self
        parser.parse()
    }
    func settingInformation(){
        
    }
    // parser delegate를 위해 필요한 함수
    // parser가 새로운 element를 발견하면 변수를 생성해야 함
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        element = elementName as NSString
        if(elementName as NSString).isEqual(to: "item"){
            elements = NSMutableDictionary()
            elements = [:]
            tourAddr = NSMutableString()
            tourAddr = ""
            tourTitle = NSMutableString()
            tourTitle = ""
            urlImage = NSMutableString()
            urlImage = ""
        }
    }
    // title과 pubDate을 발견하면 title1과 date에 완성
    func parser(_ parser: XMLParser, foundCharacters string: String){
        if element.isEqual(to: "addr1") { // 주소
            tourAddr.append(string)
        }
        else if element.isEqual(to: "title") {// 제목
            tourTitle.append(string)
        }
        else if element.isEqual(to: "firstimage"){
            urlImage.append(string) // 이미지 url
        }
    }
        
    // 하나의 카테고리 item이 끝나게 되면 그 title을 key 값으로,title1을 value로 하여서
    // element의 끝에서 feed 데이터를 dictionary에 저장
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        
        if(elementName as NSString).isEqual(to: "item"){
            if !tourAddr.isEqual(nil){
                elements.setObject(tourAddr, forKey: "addr1" as NSCopying)
            }
            if !tourTitle.isEqual(nil){
                elements.setObject(tourTitle, forKey: "title" as NSCopying)
            }
            if !urlImage.isEqual(nil){
                elements.setObject(urlImage, forKey: "firstimage" as NSCopying)
            }
            posts.add(elements)
        }
    }
    
    func escape(string: String) -> String{
        let allowedCharacters = string.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn:"#").inverted) ?? ""
        return allowedCharacters
    }

    // MARK: - Table view data source


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tourCell", for: indexPath)

        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "title") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "addr1") as! NSString as String
        
        // Configure the cell...
        return cell
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "segueTourViewToTourInfo",
            let _ = segue.destination as? TourInfoViewController{
            print(selectedCellNum)
            urlTourImage = (posts.object(at: selectedCellNum) as AnyObject).value(forKey: "firstimage") as! NSString as String
        }
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
