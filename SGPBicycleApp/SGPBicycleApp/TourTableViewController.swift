//
//  TourTableViewController.swift
//  SGPBicycleApp
//
//  Created by kpugame on 2020/06/23.
//  Copyright © 2020 SONCHAEYOUNG. All rights reserved.
//

import UIKit

class TourTableViewController: UITableViewController, XMLParserDelegate {

    @IBOutlet var tbData: UITableView! // table view 데이터
    
    // xml 데이터 파싱 위한 변수
    var parser = XMLParser()
    var posts = NSMutableArray() // feed 데이터 저장
    var elements = NSMutableDictionary() // feed 데이터 저장
    var element = NSString()
    
    //전철역 코드로 위도경도 알려주는 xml파싱에 쓰이는 변수들
    var XPOINT_WGS = NSMutableString()
    var YPOINT_WGS = NSMutableString()
    var XPoint : Float = 0.0
    var YPoint : Float = 0.0
    
    var url = "http://openapi.seoul.go.kr:8088/4b477279796d6f6f3930584851756e/xml/SearchLocationOfSTNByIDService/1/5/금정/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        settingInformation()
    }
    
    func beginParsing(){
        posts = []
        // 여행 정보
        parser = XMLParser(contentsOf: (URL(string:"http://api.visitkorea.or.kr/openapi/service/rest/KorService/locationBasedList?ServiceKey=eVQI4T2pv9%2F5bhGQP%2FxFgKhQDajSaNh9NvFwrxkHJG2zyQlbP1Ai8mcgkwzwJpRWfsBqh8zQPTptdp0NH3b0IA%3D%3D&mapX=\(Xpos)&mapY=\(Ypos)&radius=1000&listYN=Y&arrange=A&MobileOS=ETC&MobileApp=AppTest​"))!)!
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
            XPOINT_WGS = NSMutableString()
            XPOINT_WGS = ""
            YPOINT_WGS = NSMutableString()
            YPOINT_WGS = ""
        }
    }
    // title과 pubDate을 발견하면 title1과 date에 완성
    func parser(_ parser: XMLParser, foundCharacters string: String){
        if element.isEqual(to: "XPOINT_WGS"){
            if(string != "\n"){
                XPoint = Float(string)!
            }
        }
        else if element.isEqual(to: "YPOINT_WGS"){
            if(string != "\n"){
                YPoint = Float(string)!
            }
        }
    }
    // 하나의 카테고리 item이 끝나게 되면 그 title을 key 값으로,title1을 value로 하여서
    // element의 끝에서 feed 데이터를 dictionary에 저장
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        
        if(elementName as NSString).isEqual(to: "item"){
            if !XPOINT_WGS.isEqual(nil){
                elements.setObject(XPOINT_WGS, forKey: "XPOINT_WGS" as NSCopying)
            }
            if !YPOINT_WGS.isEqual(nil){
                elements.setObject(YPOINT_WGS, forKey: "YPOINT_WGS" as NSCopying)
            }
            posts.add(elements)
            print( "X: \(XPoint), Y: \(YPoint)")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
