//
//  MissionSelectViewController.swift
//  CapstoneProject
//
//  Created by yujin on 5/22/24.
//

import UIKit

class MissionSelectViewController: UIViewController {
    @IBOutlet weak var missionLabel: UILabel!
    var foodList: [Food]?
    var mission: Mission?
    var difficultySelectViewController: DifficultySelectViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UI
        missionLabelUI()
        
        // missionLabel gesture달기
        missionLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goMisson1))
        missionLabel.addGestureRecognizer(tapGesture)
    }
    
    func missionLabelUI(){
        missionLabel.layer.borderWidth = 2
        missionLabel.layer.borderColor = UIColor.black.cgColor
        missionLabel.layer.cornerRadius = 30
        
        if mission?.difficulty == .basic { // 기본미션
            var missionStr = ""
            let answer = mission!.answers[0]
            switch answer.selectHotOrDrink {
            case .hot:
                missionStr += "뜨거운 "
            case .cold:
                missionStr += "차가운 "
            default:
                break
            }
            
            missionStr += (answer.selectDrink?.name ?? "") + "을(를)\n    "
                  
            switch answer.selectDensity {
                  case .basic :
                      missionStr += "기본으로 "
                  case .light :
                      missionStr += "연하게 "
                  case .addShot :
                      missionStr += "샷 1개를 추가하여 "
                  case .addShot2 :
                      missionStr += "샷 2개를 추가하여 "
                  default:
                      break
                  }
            
            missionStr += "\n1잔 주문하시오."
            missionLabel.text = missionStr
        }
        
        if mission?.difficulty == .difficult{ // 어려움 미션
            
        }
      
    }
    
    func makeMissionStr(){
        
    }
    
    @objc func goMisson1(_ sender: UILabel) { // 아메리카노, 차가움, 기본, 결제하기버튼누르기, 포장하기버튼 누르기
        performSegue(withIdentifier:"GotoKioskMissionViewController" , sender: mission)
    }
}

extension MissionSelectViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? KioskMissionViewController {
            vc.mission = sender as? Mission
        }
    }
}



