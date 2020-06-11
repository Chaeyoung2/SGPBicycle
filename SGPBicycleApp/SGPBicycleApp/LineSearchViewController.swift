//
//  LineSearchViewController.swift
//  SGPBicycleApp
//
//  Created by kpugame on 2020/06/11.
//  Copyright © 2020 SONCHAEYOUNG. All rights reserved.
//

import UIKit
import Speech
class LineSearchViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    //MARK: - 권한가져오기
    func authorizeSR() {
          SFSpeechRecognizer.requestAuthorization { authStatus in

              OperationQueue.main.addOperation {
                  switch authStatus {
                  case .authorized:
                      self.transcribebutton.isEnabled = true

                  case .denied:
                      self.transcribebutton.isEnabled = false
                      self.transcribebutton.setTitle("유저에의해 권한 거부됨 ㅋㅋ", for: .disabled)

                  case .restricted:
                      self.transcribebutton.isEnabled = false
                      self.transcribebutton.setTitle("말하기기능 제한되있셈ㅋ", for: .disabled)

                  case .notDetermined:
                      self.transcribebutton.isEnabled = false
                      self.transcribebutton.setTitle("말하기기능권한 없으셈ㅋㅋ", for: .disabled)
                  }
              }
          }
    }
    // MARK: - 변수지정
    @IBOutlet weak var transcribebutton: UIButton!
    @IBOutlet weak var stopbutton: UIButton!
    @IBOutlet weak var myTextView: UITextView!
    
    @IBAction func startTranscribe(_ sender: Any) {
        transcribebutton.isEnabled = false
                 stopbutton.isEnabled = true
                 try! startSession()
    }
    @IBAction func stopTranscribe(_ sender: Any) {
        if audioEngine.isRunning {
                   audioEngine.stop()
                   speechRecognitionRequest?.endAudio()
                   transcribebutton.isEnabled = true
                   stopbutton.isEnabled = false
               }
        
    }
    //mark: -
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
                   self.myTextView.text =
                   result.bestTranscription.formattedString
                   finished = result.isFinal
               }

               if error != nil || finished {
                   self.audioEngine.stop()
                   inputNode.removeTap(onBus: 0)

                   self.speechRecognitionRequest = nil
                   self.speechRecognitionTask = nil

                   self.transcribebutton.isEnabled = true
               }
           }
    let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in

            self.speechRecognitionRequest?.append(buffer)
        }

        audioEngine.prepare()
        try audioEngine.start()
    }
//MARK: -오디오 오브젝트 이니셜라이징 ko-kr로써 한국어만 검색가능하게해놓음
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))!

       private var speechRecognitionRequest:
           SFSpeechAudioBufferRecognitionRequest?
       private var speechRecognitionTask: SFSpeechRecognitionTask?
       private let audioEngine = AVAudioEngine()

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        <#code#>
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        <#code#>
    }
//

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
