//
//  ViewController_SwiftUI.swift
//  SGPBicycleApp
//
//  Created by kpugame on 2020/06/24.
//  Copyright © 2020 SONCHAEYOUNG. All rights reserved.
//

import UIKit
import SwiftUI
class ViewController_SwiftUI: UIViewController {

    @IBSegueAction func embedSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        let stations = WeatherInformation()
        return UIHostingController(coder: coder, rootView: StationInfo(station: (stations?.stations[0])!))
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
