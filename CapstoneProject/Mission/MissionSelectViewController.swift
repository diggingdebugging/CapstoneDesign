//
//  MissionSelectViewController.swift
//  CapstoneProject
//
//  Created by yujin on 5/22/24.
//

import UIKit

class MissionSelectViewController: UIViewController {
    var missionLabel = UILabel()
    var textMission = UILabel()
    var instructionLabel = UILabel()
    var touchImageView = UIImageView()
    
    var foodList: [Food]?
    var mission: Mission?
    var difficultySelectViewController: DifficultySelectViewController?
    var missionStr = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        
        // missionLabel gesture달기
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goMisson1))
        view.addGestureRecognizer(tapGesture)
    }
    
    func setUI(){
        if mission?.difficulty == .basic{
            textMission.text = "📝미션 - 기본"
        }
        if mission?.difficulty == .difficult{
            textMission.text = "📝미션 - 어려움"
        }
        
        textMission.font = UIFont.boldSystemFont(ofSize: 45)
        textMission.textAlignment = .left
        missionLabel.numberOfLines = 0
        if mission?.difficulty == .basic { // 기본미션
            makeMissionStr(index: 0)
        }
        
        if mission?.difficulty == .difficult{ // 어려움 미션
            for i in 0...2{
                makeMissionStr(index: i)
            }
        }
        
//        missionLabel.layer.borderColor = UIColor.black.cgColor
//        missionLabel.layer.cornerRadius = 20
//        missionLabel.layer.borderWidth = 2
        missionLabel.text = missionStr
        missionLabel.font = UIFont.boldSystemFont(ofSize: 30)
        missionLabel.textAlignment = .left
        
        
        instructionLabel.text = "다음 뷰로 넘어가려면 화면을 터치하세요"
        instructionLabel.font = UIFont.systemFont(ofSize: 20)
        instructionLabel.textAlignment = .center
        instructionLabel.textColor = .gray
        
        touchImageView.image = UIImage(named: "touch") // 시스템 이미지 사용 예시
        touchImageView.contentMode = .scaleAspectFit
        
        textMission.translatesAutoresizingMaskIntoConstraints = false
        missionLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        touchImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(textMission)
        view.addSubview(missionLabel)
        view.addSubview(touchImageView)
        view.addSubview(instructionLabel)
        
        
        // 오토레이아웃 설정
        NSLayoutConstraint.activate([
            // 첫 번째 레이블 제약 조건
            textMission.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            textMission.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textMission.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 두 번째 레이블 제약 조건
            missionLabel.topAnchor.constraint(equalTo: textMission.bottomAnchor, constant: 40),
            missionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            missionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 이미지뷰 제약 조건
            touchImageView.topAnchor.constraint(equalTo: missionLabel.bottomAnchor, constant: 20),
            touchImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            touchImageView.widthAnchor.constraint(equalToConstant: 100),
            touchImageView.heightAnchor.constraint(equalToConstant: 100),
            
            // 세 번째 레이블 제약 조건
            instructionLabel.topAnchor.constraint(equalTo: touchImageView.bottomAnchor, constant: 20),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
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
            missionStr += "\n     1잔 주문하시오.\n\n"
        }
        
    }
    
    @objc func goMisson1(_ sender: UILabel) { // 아메리카노, 차가움, 기본, 결제하기버튼누르기, 포장하기버튼 누르기
        performSegue(withIdentifier:"GotoKioskMissionViewController" , sender: mission)
    }
}

extension MissionSelectViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? KioskMissionViewController {
            vc.mission = sender as? Mission
            vc.modalPresentationStyle = .fullScreen
        }
        
    }
}



