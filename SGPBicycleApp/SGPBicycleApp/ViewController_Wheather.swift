//
//  ViewController_Wheather.swift
//  SGPBicycleApp
//
//  Created by kpugame on 2020/06/24.
//  Copyright © 2020 SONCHAEYOUNG. All rights reserved.
//

import UIKit
import SwiftUI
struct WheatherChart: View {
    var posts : NSMutableArray
    var tempstr = "POP"
    var tempstr2 = "fcstTime"
  
  var body: some View {
    // 1
    VStack {
        Text(텍스트)
    HStack{
      // 2
      ForEach(0..<9) { index in
        // 3
        VStack {
          // 4
            Spacer()
              Text(저장용[index] as NSString as String)
              .font(.footnote)
              .rotationEffect(.degrees(0))
                  .offset(y : 0)
              .zIndex(1)
            // 5
            Rectangle()
              .fill(Color.blue)
              .frame(width: 20, height:
                  Int(저장용[index] as NSString as String)! < 25 ? 25:
                      (Int(저장용[index] as NSString as String)! <  50 ? 50:
                          (Int(저장용[index] as NSString as String)! < 75 ? 75:
                              (Int(저장용[index] as NSString as String)! < 100  ? 100: 100)))
          )
            
            // 6
              Text(시간저장용[index] as NSString as String)
              .font(.footnote)
              .frame(height: 20)
        }
      }
    }
  }
}
}

struct WheatherChart_Previews: PreviewProvider {
  static var previews: some View {
    WheatherChart(posts: ViewController_Wheather().posts )
  }
}
struct WeatherInfo: View {
     var posts : NSMutableArray
    var station: WeatherStation
 
    
    var body: some View {
        //헤더부문은 위도경도 맵킷부분 아래 네비게이션킷 부분
     // VStack {
        //StationHeader(station: self.station)
        //  .padding()
        
        
        TabView {
      
            WheatherChart(posts: self.posts)
            .tabItem({
              Image(systemName: "cloud.rain")
              Text("차트")
            })
        }.frame(width: 400, height: 300)
    //}  .navigationBarTitle(Text("\(station.name)"), displayMode: .inline)
    }
}

struct WheatherInfo_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInfo(posts: ViewController_Wheather().posts , station: WeatherInformation()!.stations[0])
    }
}


class ViewController_Wheather: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource{
    var posts : NSMutableArray = 시간별
    
    
    
    var Row = 0{//로우가 바뀔때마다 디드셋을 실행시켜줌
         didSet {
            addui()
     }
    }
    // 차트를 화면에 그려주는부분
    func addui(){
        let stations = WeatherInformation()
        
        let swiftUIController = UIHostingController(rootView: WeatherInfo(posts:  ViewController_Wheather().posts, station: (stations?.stations[0])!))
        print(posts.count)
        addChild(swiftUIController)
        
        swiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(swiftUIController.view)
        
        swiftUIController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        swiftUIController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        swiftUIController.didMove(toParent: self)
        
        
        
    }
    var pickerDataSource = ["강수확률","습도"]
    @IBOutlet weak var pickerView: UIPickerView!
    func pickerView(_ pickerView: UIPickerView, titleForRow row : Int , forComponent component : Int)->String?{
           return pickerDataSource[row]
       }
       func numberOfComponents(in pickerView: UIPickerView) -> Int {//픽커뷰의 컴포넌트 ㅐㄱ수
             return 1 //일단 1개만들거임
         }
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
             return pickerDataSource.count
         }
         
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
           //피커뷰의 로우가 row == 1 일때 어떤건지 알려주기
        Row = row
        print(Row)
        if(row==0){
            텍스트 = "시간대별 강수확률"
            저장용 = 강수확률
            시간저장용 = 시간
        }
        else if(row==1){
            텍스트 = "시간대별 습도"
            저장용 = 습도
            시간저장용 = 시간1
       
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
addui()
        // Do any additional setup after loading the view.
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
