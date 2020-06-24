//
//  ExplodeView.swift
//  SGPBicycleApp
//
//  Created by kpugame on 2020/06/24.
//  Copyright © 2020 SONCHAEYOUNG. All rights reserved.
//

import Foundation

import UIKit

class ExplodeView: UIView {
    //CAEmitterLayer 변수
    private var emitter: CAEmitterLayer!
    //UIView class 메소드 : CALayer 가 아니라 CAEmitterLayer 리턴
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init(frame: ")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //파티클 표현을 위해서 emitter cell을 생성하고 설정
        emitter = self.layer as! CAEmitterLayer
        emitter.emitterPosition = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
        emitter.emitterSize = self.bounds.size
        emitter.renderMode = CAEmitterLayerRenderMode.additive
        emitter.emitterShape = CAEmitterLayerEmitterShape.rectangle
    }
    
    override func didMoveToSuperview() {
        //1. 부모의 didMoveToSuperView()를 호출하고 superview가 없다면 exit
        super.didMoveToSuperview()
        if self.superview == nil {
            return
        }
        //2. particle.png 파일 UIImage로 로딩
        let texture: UIImage? = UIImage(named: "particle")
        assert(texture != nil, "particle image not found")
        //3. emitterCell 생성, 뒤에는 설정
        let emitterCell = CAEmitterCell()
        
        emitterCell.name = "cell"               //name 설정
        emitterCell.contents = texture?.cgImage //contents는 texture 이미지로
        emitterCell.birthRate = 300     //1초에 200개 생성
        emitterCell.lifetime = 1     //1개 particle는 0.75초 동안 생존
        
        if(FindLine == "1"){
                    emitterCell.greenRange = 0.33
                    emitterCell.greenSpeed = -0.33
                    emitterCell.redRange = 0.33
                    emitterCell.redSpeed = -0.33
        }
        else if(FindLine == "2"){
                    emitterCell.redRange = 0.33
                    emitterCell.redSpeed = -0.33
            emitterCell.blueRange = 0.33    //랜덤색깔 rgb(1,1,1) ~ (1,1,0.67)white~orange
            emitterCell.blueSpeed = -0.33   //시간이 지나면서 blue 색을 줄인다.
        }
        else if(FindLine == "3"){
            emitterCell.greenRange = 0.33
            emitterCell.greenSpeed = -0.33
            emitterCell.blueRange = 0.33    //랜덤색깔 rgb(1,1,1) ~ (1,1,0.67)white~orange
            emitterCell.blueSpeed = -0.33   //시간이 지나면서 blue 색을 줄인다.
        }
        else if(FindLine == "4"){
            emitterCell.redRange = 0.53
            emitterCell.redSpeed = -0.53
            emitterCell.greenRange = 0.23
            emitterCell.greenSpeed = -0.23
        }

        emitterCell.velocity = 200      //셀의 속도 범위 160-40 ~ 160+40
        emitterCell.velocityRange = 40
        emitterCell.scaleRange = 0.5    //셀크기 1.0-0.5 ~ 1.0+0.5
        emitterCell.scaleSpeed = -0.2   //셀크기 감소 속도
        emitterCell.emissionRange = CGFloat(Double.pi * 2)  //셀생성 방향 360도
        emitter.emitterCells = [emitterCell] //emitterCell 배열에 넣는다.
        //2초 후에 파티클 remove
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.removeFromSuperview()
        })
    }

}

