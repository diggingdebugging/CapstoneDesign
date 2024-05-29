//
//  MissionSelectViewController.swift
//  CapstoneProject
//
//  Created by yujin on 5/22/24.
//

import UIKit

class MissionReplayViewController: UIViewController {
    var missionLabel = UILabel()
    var textMission = UILabel()
    var difficultyLabel = UILabel()
    var actionLabel = UILabel()
    var backView = UIView()
    
    var foodList: [Food]?
    var mission: Mission?
    var difficultySelectViewController: DifficultySelectViewController?
    var missionStr = ""
    var actionStr = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
                
        // missionLabel gesture달기
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goMisson))
        view.addGestureRecognizer(tapGesture)
    }
    
    func setUI(){
        view.backgroundColor = .clear
        textMission.text = "BUDDY MISSION"
        textMission.font = UIFont(descriptor: UIFontDescriptor(name: "American Typewriter", size: 38).withSymbolicTraits(.traitBold)!, size: 38)
        textMission.textAlignment = .center
        textMission.backgroundColor = UIColor(hexCode: "143785")
        textMission.textColor = UIColor.white
        
        difficultyLabel.text = "[다시보기]"
        difficultyLabel.font = UIFont(name: "Jalnan2", size: 30)
        difficultyLabel.textAlignment = .center
        difficultyLabel.textColor = UIColor(hexCode: "143785")
                
        missionLabel.numberOfLines = 0
        if mission?.difficulty == .basic { // 기본미션
            makeMissionStr(index: 0)
        }
        
        if mission?.difficulty == .difficult{ // 어려움 미션
            for i in 0...2{
                makeMissionStr(index: i)
            }
        }
//        missionLabel.layer.borderWidth = 2
//        missionLabel.layer.borderColor = UIColor.black.cgColor
        missionLabel.text = missionStr
        missionLabel.font = UIFont(name: "Jalnan2", size: 22)
        missionLabel.textAlignment = .left
        
        if mission?.action == .forhere {
            actionStr = " • 매장을 이용하시오."
        }
        
        if mission?.action == .takeout {
            actionStr = " • 포장하시오."
        }
        
        actionLabel.text = actionStr
        actionLabel.font = UIFont(name: "Jalnan2", size: 22)
        actionLabel.textAlignment = .left
        
        backView.backgroundColor = .white
        backView.layer.cornerRadius = 40
        
        textMission.translatesAutoresizingMaskIntoConstraints = false
        difficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        missionLabel.translatesAutoresizingMaskIntoConstraints = false
        actionLabel.translatesAutoresizingMaskIntoConstraints = false
        backView.translatesAutoresizingMaskIntoConstraints = false
        
        backView.addSubview(textMission)
        backView.addSubview(difficultyLabel)
        backView.addSubview(missionLabel)
        backView.addSubview(actionLabel)
        
        view.addSubview(backView)
        
        // 오토레이아웃 설정
        NSLayoutConstraint.activate([
            // 첫 번째 레이블 제약 조건
            textMission.topAnchor.constraint(equalTo: backView.topAnchor, constant: 0),
            textMission.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 0),
            textMission.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 0),
            
            difficultyLabel.topAnchor.constraint(equalTo: textMission.bottomAnchor, constant: 20),
            difficultyLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            difficultyLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20),
            
            // 두 번째 레이블 제약 조건
            missionLabel.topAnchor.constraint(equalTo: difficultyLabel.bottomAnchor, constant: 60),
            missionLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            missionLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20),
            
            actionLabel.topAnchor.constraint(equalTo: missionLabel.bottomAnchor, constant: 20),
            actionLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            actionLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20),
            
            backView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -180),
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
    
    func makeMissionStr(index: Int){
        missionStr += " • "
        let answer = mission!.answers[index]
        switch answer.selectHotOrDrink {
        case .hot:
            missionStr += "뜨거운 "
        case .cold:
            missionStr += "차가운 "
        default:
            break
        }
        
        missionStr += (answer.selectDrink?.name ?? "") + " 을(를)    "
        
        switch answer.selectDensity {
        case .basic :
            missionStr += "\n     기본으로 "
        case .light :
            missionStr += "\n     연하게 "
        case .addShot :
            missionStr += "\n     샷 1개를 추가하여 "
        case .addShot2 :
            missionStr += "\n     샷 2개를 추가하여 "
        default:
            break
        }
        if answer.selectDrink as? Desert != nil {
            missionStr += "\n     1개 주문하시오.\n\n"
        }else{
            if answer.selectDensity == .basic || answer.selectDensity == .light {
                missionStr += " 1잔 주문하시오.\n\n"
            } else {
                missionStr += "\n     1잔 주문하시오.\n\n"
            }
            
        }
        
    }
    
    @objc func goMisson(_ sender: UILabel) { // 아메리카노, 차가움, 기본, 결제하기버튼누르기, 포장하기버튼 누르기
        dismiss(animated: true)
    }
}


