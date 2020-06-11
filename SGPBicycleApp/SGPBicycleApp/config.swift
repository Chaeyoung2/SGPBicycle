//
//  config.swift
//  SGPBicycleApp
//
//  Created by kpugame on 2020/06/11.
//  Copyright © 2020 SONCHAEYOUNG. All rights reserved.
//

import Foundation
var clb = 0;

var stations = [[Station]]()
var FindName : String = ""
func loadStations(){
stations = [[
    Station(category: "1호선", name: "소요산"),
    Station(category: "1호선", name: "동두천"),
    Station(category: "1호선", name: "보산"),
    Station(category: "1호선", name: "동두천중앙"),
    Station(category: "1호선", name: "지행"),
    Station(category: "1호선", name: "덕정"),
    Station(category: "1호선", name: "덕계"),
    Station(category: "1호선", name: "양주"),
    Station(category: "1호선", name: "녹양"),
    Station(category: "1호선", name: "가능"),
    Station(category: "1호선", name: "의정부"),
    Station(category: "1호선", name: "회룡"),
    Station(category: "1호선", name: "망월사"),
    Station(category: "1호선", name: "도봉산"),
    Station(category: "1호선", name: "도봉"),
    Station(category: "1호선", name: "방학"),
    Station(category: "1호선", name: "창동"),
    Station(category: "1호선", name: "녹천"),
    Station(category: "1호선", name: "월계"),
    Station(category: "1호선", name: "광운대"),
    Station(category: "1호선", name: "석계"),
    Station(category: "1호선", name: "신이문"),
    Station(category: "1호선", name: "외대앞"),
    Station(category: "1호선", name: "회기"),
    Station(category: "1호선", name: "청량리"),
    Station(category: "1호선", name: "제기동"),
    Station(category: "1호선", name: "신설동"),
    Station(category: "1호선", name: "동묘앞"),
    Station(category: "1호선", name: "동대문"),
    Station(category: "1호선", name: "종로5가"),
    Station(category: "1호선", name: "종로3가"),
    Station(category: "1호선", name: "종각"),
    Station(category: "1호선", name: "시청"),
    Station(category: "1호선", name: "서울역"),
    Station(category: "1호선", name: "남영"),
    Station(category: "1호선", name: "용산"),
    Station(category: "1호선", name: "노량진"),
    Station(category: "1호선", name: "대방"),
    Station(category: "1호선", name: "신길"),
    Station(category: "1호선", name: "영등포"),
    Station(category: "1호선", name: "신도림"),
    Station(category: "1호선", name: "구로"),
    
    Station(category: "1호선", name: "가산디지털단지"),
    Station(category: "1호선", name: "독산"),
    Station(category: "1호선", name: "금천구청"),
    Station(category: "1호선", name: "석수"),
    Station(category: "1호선", name: "관악"),
    Station(category: "1호선", name: "안양"),
    Station(category: "1호선", name: "명학"),
    Station(category: "1호선", name: "금정"),
    Station(category: "1호선", name: "군포"),
    Station(category: "1호선", name: "당정"),
    Station(category: "1호선", name: "의왕"),
    Station(category: "1호선", name: "성균관대"),
    Station(category: "1호선", name: "화서"),
    Station(category: "1호선", name: "수원"),
    Station(category: "1호선", name: "세류"),
    Station(category: "1호선", name: "병점"),
    Station(category: "1호선", name: "세마"),
    Station(category: "1호선", name: "오산대"),
    Station(category: "1호선", name: "오산"),
    Station(category: "1호선", name: "송탄"),
    Station(category: "1호선", name: "서정리"),
    Station(category: "1호선", name: "지제"),
    Station(category: "1호선", name: "평택"),
    
    Station(category: "1호선", name: "구일"),
    Station(category: "1호선", name: "개봉"),
    Station(category: "1호선", name: "오류동"),
    Station(category: "1호선", name: "온수"),
    Station(category: "1호선", name: "역곡"),
    Station(category: "1호선", name: "소사"),
    Station(category: "1호선", name: "부천"),
    Station(category: "1호선", name: "중동"),
    Station(category: "1호선", name: "송내")
    ],[
        Station(category:"2호선" , name:"신도림" ),
        Station(category:"2호선" , name:"대림" ),
        Station(category:"2호선" , name:"구로디지털단지"),
        Station(category:"2호선" , name:"신대방" ),
        Station(category:"2호선" , name:"신림" ),
        Station(category:"2호선" , name:"봉천" ),
        Station(category:"2호선" , name:"서울대입구" ),
        Station(category:"2호선" , name:"낙성대" ),
        Station(category:"2호선" , name:"사당" ),
        Station(category:"2호선" , name:"방배" ),
        Station(category:"2호선" , name:"서초" ),
        Station(category:"2호선" , name:"교대" ),
        Station(category:"2호선" , name:"강남" ),
        Station(category:"2호선" , name:"서초" ),
        Station(category:"2호선" , name:"역삼" ),
        Station(category:"2호선" , name:"삼성" ),
        Station(category:"2호선" , name:"선릉" ),
        Station(category:"2호선" , name:"종합운동장" ),
        Station(category:"2호선" , name:"신천" ),
        Station(category:"2호선" , name:"잠실" ),
        Station(category:"2호선" , name:"잠실나루" ),
        Station(category:"2호선" , name:"강변" ),
        Station(category:"2호선" , name:"구의" ),
        Station(category:"2호선" , name:"건대입구" ),
        Station(category:"2호선" , name:"성수" ),
        Station(category:"2호선" , name:"뚝섬" ),
        Station(category:"2호선" , name:"한양대" ),
        Station(category:"2호선" , name:"왕십리" ),
        Station(category:"2호선" , name:"상왕십리" ),
        Station(category:"2호선" , name:"신당" ),
        Station(category:"2호선" , name:"동대문역사문화공원" ),
        Station(category:"2호선" , name:"을지로4가" ),
        Station(category:"2호선" , name:"을지로3가" ),
        Station(category:"2호선" , name:"을지로입구" ),
        Station(category:"2호선" , name:"시청" ),
        Station(category:"2호선" , name:"충정로" ),
        Station(category:"2호선" , name:"아현" ),
        Station(category:"2호선" , name:"이대" ),
        Station(category:"2호선" , name:"신촌" ),
        Station(category:"2호선" , name:"홍대입구" ),
        Station(category:"2호선" , name:"합정" ),
        Station(category:"2호선" , name:"당산" ),
        Station(category:"2호선" , name:"영등포구청" ),
        Station(category:"2호선" , name:"문래" ),
        Station(category:"2호선" , name:"까치산" ),
        Station(category:"2호선" , name:"신정네거리" ),
        Station(category:"2호선" , name:"양천구청" ),
        Station(category:"2호선" , name:"도림천" ),
        Station(category:"2호선" , name:"신설동" ),
        Station(category:"2호선" , name:"용두" ),
        Station(category:"2호선" , name:"신답" ),
        Station(category:"2호선" , name:"용답" ),
    ],
      [
    Station(category:"3호선" , name:"대화" ),
    Station(category:"3호선" , name:"주엽" ),
    Station(category:"3호선" , name:"정발산" ),
    Station(category:"3호선" , name:"마두" ),
    Station(category:"3호선" , name:"백석" ),
    Station(category:"3호선" , name:"대곡" ),
    Station(category:"3호선" , name:"화정" ),
    Station(category:"3호선" , name:"원당" ),
    Station(category:"3호선" , name:"원흥" ),
    Station(category:"3호선" , name:"삼송" ),
    Station(category:"3호선" , name:"지축" ),
    Station(category:"3호선" , name:"구파발" ),
    Station(category:"3호선" , name:"연신내" ),
    Station(category:"3호선" , name:"불광" ),
    Station(category:"3호선" , name:"녹번" ),
    Station(category:"3호선" , name:"홍제" ),
    Station(category:"3호선" , name:"무악제" ),
    Station(category:"3호선" , name:"독립문" ),
    Station(category:"3호선" , name:"경복궁" ),
    Station(category:"3호선" , name:"안국" ),
    Station(category:"3호선" , name:"종로3가" ),
    Station(category:"3호선" , name:"을지로3가" ),
    Station(category:"3호선" , name:"충무로" ),
    Station(category:"3호선" , name:"동대입구" ),
    Station(category:"3호선" , name:"약수" ),
    Station(category:"3호선" , name:"금호" ),
    Station(category:"3호선" , name:"옥수" ),
    Station(category:"3호선" , name:"압구정" ),
    Station(category:"3호선" , name:"신사" ),
    Station(category:"3호선" , name:"잠원" ),
    Station(category:"3호선" , name:"고속터미널" ),
    Station(category:"3호선" , name:"교대" ),
    Station(category:"3호선" , name:"남부터미널" ),
    Station(category:"3호선" , name:"양재" ),
    Station(category:"3호선" , name:"매봉" ),
    Station(category:"3호선" , name:"도곡" ),
    Station(category:"3호선" , name:"대치" ),
    Station(category:"3호선" , name:"학여울" ),
    Station(category:"3호선" , name:"대청" ),
    Station(category:"3호선" , name:"일원" ),
    Station(category:"3호선" , name:"수서" ),
    Station(category:"3호선" , name:"가락시장" ),
    Station(category:"3호선" , name:"경찰병원" ),
    Station(category:"3호선" , name:"오금" ),
    ],
      [
    Station(category:"4호선" , name:"당고개" ),
    Station(category:"4호선" , name:"상계" ),
    Station(category:"4호선" , name:"노원" ),
    Station(category:"4호선" , name:"창동" ),
    Station(category:"4호선" , name:"쌍문" ),
    Station(category:"4호선" , name:"수유" ),
    Station(category:"4호선" , name:"미아" ),
    Station(category:"4호선" , name:"미아사거리" ),
    Station(category:"4호선" , name:"길음" ),
    Station(category:"4호선" , name:"성신여대입구" ),
    Station(category:"4호선" , name:"한성대입구" ),
    Station(category:"4호선" , name:"혜화" ),
    Station(category:"4호선" , name:"동대문" ),
    Station(category:"4호선" , name:"동대문역사문화공원" ),
    Station(category:"4호선" , name:"충무로" ),
    Station(category:"4호선" , name:"명동" ),
    Station(category:"4호선" , name:"회현" ),
    Station(category:"4호선" , name:"서울역" ),
    Station(category:"4호선" , name:"숙대입구" ),
    Station(category:"4호선" , name:"삼각지" ),
    Station(category:"4호선" , name:"신용산" ),
    Station(category:"4호선" , name:"이촌" ),
    Station(category:"4호선" , name:"동작" ),
    Station(category:"4호선" , name:"총신대입구" ),
    Station(category:"4호선" , name:"사당" ),
    Station(category:"4호선" , name:"남태령" ),
    Station(category:"4호선" , name:"선바위" ),
    Station(category:"4호선" , name:"경마공원" ),
    Station(category:"4호선" , name:"대공원" ),
    Station(category:"4호선" , name:"과천" ),
    Station(category:"4호선" , name:"정부과천청사" ),
    Station(category:"4호선" , name:"인덕원" ),
    Station(category:"4호선" , name:"평촌" ),
    Station(category:"4호선" , name:"범계" ),
    Station(category:"4호선" , name:"금정" ),
    Station(category:"4호선" , name:"산본" ),
    Station(category:"4호선" , name:"수리산" ),
    Station(category:"4호선" , name:"대야미" ),
    Station(category:"4호선" , name:"반월" ),
    Station(category:"4호선" , name:"상록수" ),
    Station(category:"4호선" , name:"한대앞" ),
    Station(category:"4호선" , name:"중앙" ),
    Station(category:"4호선" , name:"고잔" ),
    Station(category:"4호선" , name:"초지" ),
    Station(category:"4호선" , name:"안산" ),
    Station(category:"4호선" , name:"신길온천" ),
    Station(category:"4호선" , name:"정왕" ),
    Station(category:"4호선" , name:"오이도" ),




    ]
      
]
//MARK: -오디오 오브젝트 이니셜라이징 ko-kr로써 한국어만 검색가능하게해놓음
}
