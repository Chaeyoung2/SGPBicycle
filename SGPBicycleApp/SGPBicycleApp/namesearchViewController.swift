//
//  namesearchViewController.swift
//  SGPBicycleApp
//
//  Created by kpugame on 2020/06/11.
//  Copyright © 2020 SONCHAEYOUNG. All rights reserved.
//

import UIKit
import Speech
class namesearchViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet weak var pickerview2: UIPickerView!
    @IBOutlet weak var mytextview2: UITextView!
    @IBOutlet weak var startbutton: UIButton!
    @IBOutlet weak var stopbutton: UIButton!
       private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))!

          private var speechRecognitionRequest:
              SFSpeechAudioBufferRecognitionRequest?
          private var speechRecognitionTask: SFSpeechRecognitionTask?
          private let audioEngine = AVAudioEngine()
   func authorizeSR() {
         SFSpeechRecognizer.requestAuthorization { authStatus in

             OperationQueue.main.addOperation {
                 switch authStatus {
                 case .authorized:
                     self.startbutton.isEnabled = true

                 case .denied:
                     self.startbutton.isEnabled = false
                     self.startbutton.setTitle("유저에의해 권한 거부됨 ㅋㅋ", for: .disabled)

                 case .restricted:
                     self.startbutton.isEnabled = false
                     self.startbutton.setTitle("말하기기능 제한되있셈ㅋ", for: .disabled)

                 case .notDetermined:
                     self.startbutton.isEnabled = false
                     self.startbutton.setTitle("말하기기능권한 없으셈ㅋㅋ", for: .disabled)
                 }
             }
         }
   }

   func startSession() throws {

              if let recognitionTask = speechRecognitionTask {
                  recognitionTask.cancel()
                  self.speechRecognitionTask = nil
              }

              let audioSession = AVAudioSession.sharedInstance()
              try audioSession.setCategory(AVAudioSession.Category.record)

              speechRecognitionRequest = SFSpeechAudioBufferRecognitionRequest()

              guard let recognitionRequest = speechRecognitionRequest else { fatalError("SFSpeechAudioBufferRecognitionRequest object creation failed") }

              let inputNode = audioEngine.inputNode

              recognitionRequest.shouldReportPartialResults = true
              
             
              speechRecognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in

                  var finished = false

                  if let result = result {
                      self.mytextview2.text =
                      result.bestTranscription.formattedString
                      finished = result.isFinal
                  }

                  if error != nil || finished {
                      self.audioEngine.stop()
                      inputNode.removeTap(onBus: 0)

                      self.speechRecognitionRequest = nil
                      self.speechRecognitionTask = nil
   //ㄹㄴㄹㄹㄹㄹㄹ
                      self.startbutton.isEnabled = true
                  }
              }
       let recordingFormat = inputNode.outputFormat(forBus: 0)
           inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in

               self.speechRecognitionRequest?.append(buffer)
           }

           audioEngine.prepare()
           try audioEngine.start()
       }

    @IBAction func start(_ sender: Any) {
                       startbutton.isEnabled = false
                       stopbutton.isEnabled = true
                       try! startSession()
    }
   
    @IBAction func stop(_ sender: Any) {
        if audioEngine.isRunning {
                          audioEngine.stop()
                          speechRecognitionRequest?.endAudio()
                          startbutton.isEnabled = true
                          stopbutton.isEnabled = false
                      }
               switch (self.mytextview2.text) {
               case "일호선" : self.pickerview2.selectRow(0, inComponent: 0, animated: true)
                   break
               case "이호선" : self.pickerview2.selectRow(1, inComponent: 0, animated: true)
                   break
               case "삼호선" : self.pickerview2.selectRow(2, inComponent: 0, animated: true)
                   break
               case "사호선" : self.pickerview2.selectRow(3, inComponent: 0, animated: true)
               break
               default: break
               }
        let trim = self.mytextview2.text.trimmingCharacters(in: .whitespacesAndNewlines)
        print(trim)
        for num in 0...stations[clb].count-1{
            if( trim == stations[clb][num].name){
            self.pickerview2.selectRow(num, inComponent: 0, animated: true)
                      }
    }
    }
    
    //MARK: - 호선 별로보이는
    var pickerDataSource = stations[clb]
    //,"5호선","6호선","7호선","8호선","9호선"
    func pickerView(_ pickerView: UIPickerView, titleForRow row : Int , forComponent component : Int)->String?{
        return pickerDataSource[row].name
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {//픽커뷰의 컴포넌트 ㅐㄱ수
          return 2//일단 1개만들거임
      }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
      }
      
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerview2.delegate = self;
        self.pickerview2.dataSource = self;
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
