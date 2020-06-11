import UIKit
import Speech
var lineNumber : String = "일호선"
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
        switch (self.myTextView.text) {
        case "일호선" : self.pickerView.selectRow(0, inComponent: 0, animated: true)
            break
        case "이호선" : self.pickerView.selectRow(1, inComponent: 0, animated: true)
            break
        case "삼호선" : self.pickerView.selectRow(2, inComponent: 0, animated: true)
            break
        case "사호선" : self.pickerView.selectRow(3, inComponent: 0, animated: true)
        break
        default: break
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
//ㄹㄴㄹㄹㄹㄹㄹ
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

   
    @IBOutlet weak var pickerView: UIPickerView!
    
//MARK: - 호선 별로보이는
      var pickerDataSource = ["1호선","2호선","3호선","4호선"]
    //,"5호선","6호선","7호선","8호선","9호선"
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
        if row == 0 {
                lineNumber = "일호선"//광진구 시구코드
            }else if row == 1{//구로구
                lineNumber = "이호선"
                
            }else if row == 2{//동대문구
                lineNumber = "삼호선"
            }else if row == 3{//종로구 시구
                lineNumber = "사호선"
            }
    }
    override func viewDidLoad() {
        authorizeSR()
        super.viewDidLoad()
        
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
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
