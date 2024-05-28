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
    var difficultyLabel = UILabel()
    var actionLabel = UILabel()
    var instructionLabel = UILabel()
    var touchImageView = UIImageView()
    
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
//        if mission?.difficulty == .basic{
//            textMission.text = "📝미션 [기본]"
//        }
//        if mission?.difficulty == .difficult{
//            textMission.text = "📝미션 [어려움]"
//        }
        textMission.text = "BUDDY MISSION"
        textMission.font = UIFont(descriptor: UIFontDescriptor(name: "American Typewriter", size: 38).withSymbolicTraits(.traitBold)!, size: 38)
        textMission.textAlignment = .center
        textMission.backgroundColor = UIColor(hexCode: "143785")
        textMission.textColor = UIColor.white
        
        if mission?.difficulty == .basic{
            difficultyLabel.text = "[기본]"
        }
        if mission?.difficulty == .difficult{
            difficultyLabel.text = "[어려움]"
        }
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
        
        touchImageView.image = UIImage(named: "touch") // 시스템 이미지 사용 예시
        touchImageView.contentMode = .scaleAspectFit
        
        instructionLabel.text = "다음 뷰로 넘어가려면 화면을 터치하세요"
        instructionLabel.font = UIFont.systemFont(ofSize: 20)
        instructionLabel.textAlignment = .center
        instructionLabel.textColor = .gray
        
        textMission.translatesAutoresizingMaskIntoConstraints = false
        difficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        missionLabel.translatesAutoresizingMaskIntoConstraints = false
        actionLabel.translatesAutoresizingMaskIntoConstraints = false
        touchImageView.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(textMission)
        view.addSubview(difficultyLabel)
        view.addSubview(missionLabel)
        view.addSubview(actionLabel)
        view.addSubview(touchImageView)
        view.addSubview(instructionLabel)
        
        
        // 오토레이아웃 설정
        NSLayoutConstraint.activate([
            // 첫 번째 레이블 제약 조건
            textMission.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            textMission.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            textMission.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            difficultyLabel.topAnchor.constraint(equalTo: textMission.bottomAnchor, constant: 20),
            difficultyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            difficultyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 두 번째 레이블 제약 조건
            missionLabel.topAnchor.constraint(equalTo: difficultyLabel.bottomAnchor, constant: 60),
            missionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            missionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            actionLabel.topAnchor.constraint(equalTo: missionLabel.bottomAnchor, constant: 20),
            actionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            actionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // touchImageView 제약 조건
            touchImageView.bottomAnchor.constraint(equalTo: instructionLabel.topAnchor, constant: -20),
            touchImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            touchImageView.widthAnchor.constraint(equalToConstant: 130),
            touchImageView.heightAnchor.constraint(equalToConstant: 130),
            
            // instructionLabel 제약 조건
            instructionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
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
            if answer.selectDensity == .basic || answer.selectDensity == .light {
                missionStr += " 1잔 주문하시오.\n\n"
            } else {
                missionStr += "\n     1잔 주문하시오.\n\n"
            }
            
        }
        
    }
    
    @objc func goMisson(_ sender: UILabel) { // 아메리카노, 차가움, 기본, 결제하기버튼누르기, 포장하기버튼 누르기
        performSegue(withIdentifier:"GotoKioskMissionViewController" , sender: mission)
        //        let storyboard = UIStoryboard(name: "Mission", bundle: nil)
        //        let vc = storyboard.instantiateViewController(withIdentifier: "KioskMissionViewController") as! KioskMissionViewController
        //        vc.modalPresentationStyle = .fullScreen
        //        present(vc, animated: true)
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

extension UIColor {
    
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}



