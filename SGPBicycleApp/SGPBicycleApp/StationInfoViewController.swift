//
//  StationInfoViewController.swift
//  SGPBicycleApp
//
//  Created by kpugame on 2020/06/11.
//  Copyright © 2020 SONCHAEYOUNG. All rights reserved.
//

import UIKit




class StationInfoViewController: UIViewController, XMLParserDelegate {

    
    @IBOutlet weak var imgLine: UIImageView!
    
    @IBOutlet weak var textviewStationName: UITextView!
    @IBOutlet weak var textviewStationCode: UITextView!
    @IBOutlet weak var textviewRouteName: UITextView!
    
    // XMl데이터 파싱 위해 클래스에서 다음 변수를 선언
    var parser = XMLParser() // xml 파일을 다운로드 및 파싱하는 오브젝트
    var posts = NSMutableArray() // feed 데이터를 저장하는 mutable array
    var tempelements = NSMutableDictionary()
    var elements = NSMutableDictionary() // title과 date 같은 feed 데이터를 저장하는 mutable dictionary
    var element = NSString()
    var stationId = NSMutableString() // 저장 문자열 변수
    var stationName = NSMutableString()
    var routeName = NSMutableString()
    // image
    var imgOn : UIImage?
    
    //전철역 코드로 위도경도 알려주는 xml파싱에 쓰이는 변수들
    var XPOINT_WGS = NSMutableString()
    var YPOINT_WGS = NSMutableString()
    
    
    // MARK: - 아래의 플롯변수에 위도 경도 저장되요!
    var XPoint : Float = 0
    var YPoint : Float = 0

    // Mark: - 위도 경도를 통해 동네 예보
    var 동네예보 = "http://apis.data.go.kr/1360000/VilageFcstInfoService/getVilageFcst"
    var 초단기예보 = "http://apis.data.go.kr/1360000/VilageFcstInfoService/getUltraSrtFcst"
    var 동네예보인증키 = "peuzoABFl3ew9WDJeae1ap8n5rlnIok9P1zH0%2FzIXXz2LM%2B8qahwkE1WckPkvD%2FET%2BZ5nN3LltIICJNplE0zvA%3D%3D"
    var 현재날짜 = "20200624"// 당일날짜밖에안되는거같음
    var 기준시간 = "0800"
    var category = NSMutableString()
    var fcstValue = NSMutableString()
    var POP = NSMutableString() // 강수확률
    var REH =  NSMutableString() // 습도
    var SKY =  NSMutableString() // 하늘상태
    var TMX =   NSMutableString() // 낮최고기온
    var 현재기온 = NSMutableString()
    var 꼼수용 = 0
    var fcstTime = NSMutableString()
    var temptime = 0
    var tempstring = ""
    // MARK: - 해당 화면이 불려질때 불려지는 함수들
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        settingImageLine()
        settingInformation()
        explodeParticle()
        저장용 = 강수확률
        시간저장용 = 시간
        // print("xpos \(Xpos) ypos \(Ypos)")
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
        let SstrEncoded = self.escape(string: "http://openAPI.seoul.go.kr:8088/4b477279796d6f6f3930584851756e/xml/SearchLocationOfSTNByIDService/1/5/" + FindCode)
               parser = XMLParser(contentsOf: (URL(string:SstrEncoded))!)!
               parser.delegate = self
               parser.parse()
               //tbData!.reloadData()
               
        
        
        let url : String = 동네예보 + "?serviceKey=" + 동네예보인증키 + "&numOfRows=100&pageNo=1 &base_date=" + 현재날짜 + "&base_time=" + 기준시간 + "&nx=" + String(Int(XPoint)) + "&ny=" + String(Int(YPoint))
        
        let SsstrEncoded = self.escape(string: url)
        parser = XMLParser(contentsOf: (URL(string:SsstrEncoded))!)!
                   parser.delegate = self
                   parser.parse()
        
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
            XPOINT_WGS  = NSMutableString()
            XPOINT_WGS  = ""
            YPOINT_WGS = NSMutableString()
            YPOINT_WGS  = ""

            category = NSMutableString()
            fcstValue = NSMutableString()
            category = ""
            fcstValue = ""
            fcstTime = NSMutableString()
            fcstTime = ""
            
            
          POP = NSMutableString() // 강수확률
          REH =  NSMutableString() // 습도
          SKY =  NSMutableString() // 하늘상태
          TMX =   NSMutableString() // 낮최고기온
          POP = "" // 강수확률
          REH =  ""// 습도
          SKY =  "" // 하늘상태
          TMX =  "" // 낮최고기온
        }
        
    }

    // title과 pubDate을 발견하면 title1과 date에 완성한다
    func parser(_ parser: XMLParser, foundCharacters string: String){
        if element.isEqual(to: "subwayStationId"){
            stationId.append(string) // 기관명
        }
         if element.isEqual(to: "subwayStationName"){
            stationName.append(string) // 시도명
        }
         if element.isEqual(to: "subwayRouteName"){
            routeName.append(string) // 시군구명
        }
         if element.isEqual(to: "XPOINT_WGS"){
            if(string != "\n"){
            Xpos  =  string
            XPoint = Float(string)!
            }
        }
         if element.isEqual(to: "YPOINT_WGS"){
              if(string != "\n"){
            Ypos = string
            YPoint = Float(string)!
            }
        }
         if element.isEqual(to: "fcstTime"){
            temptime = Int(string)!
            tempstring = string
        }
        else if element.isEqual(to: "category"){
           if(string == "POP"){
               꼼수용 = 1
            }
            if(string == "REH"){
               꼼수용 = 2
            }
            if(string == "SKY"){
               꼼수용 = 3
            }
            if(string == "TMX"){
               꼼수용 = 4
            }
               }
          else if element.isEqual(to: "fcstValue"){
          
                  if(꼼수용>0){
                         // print(꼼수용)
                         // print("꼼수번호")
                            //     print(string)
                             }
                  if(string != "\n"){
                      if (꼼수용 == 1){
                          꼼수용 = 0
                          if(Int(string)!>90){
                              하늘상태 = "2"
                          }
                        시간별강수.updateValue(string, forKey: temptime)
                                     
                        강수확률.append(string)
                        시간.append(tempstring)
                   
                      }
                      if (꼼수용 == 2){
                          //습도.append(string)
                          시간별습도.updateValue(string, forKey: temptime)
                        습도.append(string)
                        시간1.append(tempstring)
                                         꼼수용 = 0
                                     }
                      if (꼼수용 == 3){
                          하늘상태 = string
                          
                                         꼼수용 = 0
                                     }
                      if (꼼수용 == 4){
                          낮최고기온 = string
                          
                                         꼼수용 = 0
                                     }
                                }
                 
                  
                  }
      
        
        
        }
        
    //아이템에서 키에 해당하는 아이템이있을경우 엘리멘츠에 넣어줌
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
            if !XPOINT_WGS.isEqual(nil){
                            elements.setObject(XPOINT_WGS, forKey: "XPOINT_WGS" as NSCopying)
                        }
            if !YPOINT_WGS.isEqual(nil){
                            elements.setObject(YPOINT_WGS, forKey: "YPOINT_WGS" as NSCopying)
                        }
            if !category.isEqual(nil){
                                    elements.setObject(category, forKey: "category" as NSCopying)
                                }
            if !fcstValue.isEqual(nil){
                                    elements.setObject(fcstValue, forKey: "fcstValue" as NSCopying)
                                }
      
            // elements라는 딕셔너리들을 여러개 갖는 posts
            posts.add(elements)
        }
    }
    
    func explodeParticle(){
        let explore = ExplodeView(frame: CGRect(x: self.view.center.x - 30, y: self.view.center.y - 200, width: 100, height: 100))
        self.view.addSubview(explore)
        self.view.sendSubviewToBack(explore)
    }

   
    // MARK: -
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

