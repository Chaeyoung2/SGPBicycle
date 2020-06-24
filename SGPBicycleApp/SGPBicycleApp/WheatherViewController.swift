//
//  WheatherViewController.swift
//  SGPBicycleApp
//
//  Created by kpugame on 2020/06/24.
//  Copyright © 2020 SONCHAEYOUNG. All rights reserved.
//

import UIKit

class WheatherViewController: UIViewController {
    @IBOutlet weak var Wheatherimg: UIImageView!
    @IBOutlet weak var 온도: UILabel!
    @IBOutlet weak var 아울렛_하늘상태: UILabel!
    @IBOutlet weak var 아울렛_습도: UILabel!
    @IBOutlet weak var 강수확률아울렛: UILabel!
    
    func Chimg(){
        print("이미지바뀜")
        Wheatherimg.image = UIImage(named:  하늘상태+".png")
        //강수확률이 80프로이상이면 하늘상태가아니라 2 파일을 넣어주자
    }
    func Chtxt(){
        var temp = ""
        var endindex = 0
        
        if(하늘상태 == "1"){
            temp = "맑음"
        }
        else if(하늘상태=="2"){
            temp = "비옴"
        }
        else if(하늘상태 == "3")
        {
            temp = "구름많음"
        }
        else if(하늘상태 == "4"){
            temp = "흐림"
        }
        온도.text = "낮 최고기온 : " + 낮최고기온 + "°C" 
        아울렛_하늘상태.text = "오늘의 날씨 : " + temp
        아울렛_습도.text = "습도 : " + 시간별습도[0]! + "%"
        강수확률아울렛.text =  "강수확률 : " + 시간별강수[0]! +  "%"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Chimg()
        Chtxt()
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
