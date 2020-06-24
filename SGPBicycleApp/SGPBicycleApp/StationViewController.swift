//
//  StationViewController.swift
//  SGPBicycleApp
//
//  Created by kpugame on 2020/06/23.
//  Copyright © 2020 SONCHAEYOUNG. All rights reserved.
//

import UIKit

class StationViewController: UIViewController, XMLParserDelegate {

    @IBOutlet weak var imgLine: UIImageView!
    
    @IBOutlet weak var textviewStationName: UITextView!
    @IBOutlet weak var textviewStationCode: UITextView!
    @IBOutlet weak var textviewRouteName: UITextView!
    
    // XMl데이터 파싱 위해 클래스에서 다음 변수를 선언
    var parser = XMLParser() // xml 파일을 다운로드 및 파싱하는 오브젝트
    var posts = NSMutableArray() // feed 데이터를 저장하는 mutable array
    var elements = NSMutableDictionary() // title과 date 같은 feed 데이터를 저장하는 mutable dictionary
    var element = NSString()
    var stationId = NSMutableString() // 저장 문자열 변수
    var stationName = NSMutableString()
    var routeName = NSMutableString()
    var urlImage = NSMutableString()
    // image
    var imgOn : UIImage?


    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        settingImageLine()
        settingInformation()
        // Do any additional setup after loading the view.
    }

    // parser 오브젝트 초기화하고 XMLParserDelegate로 설정하고 XML 파싱 시작
    func beginParsing(){
        posts = []
        let strEncoded = self.escape(string: "http://openapi.tago.go.kr/openapi/service/SubwayInfoService/getKwrdFndSubwaySttnList?ServiceKey=eVQI4T2pv9%2F5bhGQP%2FxFgKhQDajSaNh9NvFwrxkHJG2zyQlbP1Ai8mcgkwzwJpRWfsBqh8zQPTptdp0NH3b0IA%3D%3D&subwayStationName=" + FindName)
        parser = XMLParser(contentsOf: (URL(string:strEncoded))!)!
        parser.delegate = self
        parser.parse()
        //tbData!.reloadData()
    }
    

    // parser delegate를 위해 필요한 함수
    // parser가 새로운 element를 발견하면 변수를 생성해야 함
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        element = elementName as NSString
        if(elementName as NSString).isEqual(to: "item"){ // item인지 검색 // hotnews의 뉴스들은 각각 item으로 카테고리화 되어 있기 때문
            elements = NSMutableDictionary()
            elements = [:]
            stationId = NSMutableString()
            stationId = ""
            stationName = NSMutableString()
            stationName = ""
            routeName = NSMutableString()
            routeName = ""
            urlImage = NSMutableString()
            urlImage = ""
        }
    }

    // title과 pubDate을 발견하면 title1과 date에 완성한다
    func parser(_ parser: XMLParser, foundCharacters string: String){
        if element.isEqual(to: "subwayStationId"){
            stationId.append(string) // 기관명
        } else if element.isEqual(to: "subwayStationName"){
            stationName.append(string) // 시도명
        } else if element.isEqual(to: "subwayRouteName"){
            routeName.append(string) // 시군구명
        } else if element.isEqual(to: "firstimage"){
            urlImage.append(string) // 시군구명
        }
    }

    // 하나의 카테고리 item이 끝나게 되면 그 title을 key 값으로,title1을 value로 하여서
    // element의 끝에서 feed 데이터를 dictionary에 저장
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        if(elementName as NSString).isEqual(to: "item"){
            if !stationId.isEqual(nil){
                elements.setObject(stationId, forKey: "subwayStationId" as NSCopying)
            }
            if !stationName.isEqual(nil){
                elements.setObject(stationName, forKey: "subwayStationName" as NSCopying)
            }
            if !routeName.isEqual(nil){
                elements.setObject(routeName, forKey: "subwayRouteName" as NSCopying)
            }
            
            // elements라는 딕셔너리들을 여러개 갖는 posts
            posts.add(elements)
        }
    }
    
    func settingImageLine(){
        if clb == 0{
            imgOn = UIImage(named:"line1.png")
        }
        else if clb == 1{
            imgOn = UIImage(named:"line2.png")
        }
        else if clb == 2{
            imgOn = UIImage(named:"line3.png")
        }
        else if clb == 3{
            imgOn = UIImage(named:"line4.png")
        }
        else if clb == 4{
            imgOn = UIImage(named:"line5.png")
        }
        imgLine.image = imgOn
    }
    
    func settingInformation(){
        textviewStationCode.text = (posts.object(at: 0) as AnyObject).value(forKey: "subwayStationId") as! NSString as String
        textviewStationName.text = (posts.object(at: 0) as AnyObject).value(forKey: "subwayStationName") as! NSString as String
        textviewRouteName.text = (posts.object(at: 0) as AnyObject).value(forKey: "subwayRouteName") as! NSString as String
    }
    
    func escape(string: String) -> String{
        let allowedCharacters = string.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn:"#").inverted) ?? ""
        return allowedCharacters
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
