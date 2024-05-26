//
//  DifficultySelectViewController.swift
//  CapstoneProject
//
//  Created by yujin on 5/26/24.
//

import UIKit

class DifficultySelectViewController: UIViewController {
    
    let basicButton = UIButton()
    let difficultButton = UIButton()
    var mission: Mission?
    var foodList: [Food]?
    var randomHotOrCold: HotOrCold?
    var randomDensity: Density?
    var answers: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basicButton.addTarget(self, action: #selector(basicButtonClicked), for: .touchUpInside)
        difficultButton.addTarget(self, action: #selector(difficultButtonClicked), for: .touchUpInside)
        getUI()
    }
    
    @objc func basicButtonClicked(sender: UIButton){
        makeBasicMission()
        performSegue(withIdentifier: "GotoMissionSelectViewController", sender: mission)
    }
    
    @objc func difficultButtonClicked(sender: UIButton){
        makeDifficultMission()
        performSegue(withIdentifier: "GotoMissionSelectViewController", sender: mission)
    }
    
    func getUI(){
        basicButton.setTitle("기본", for: .normal)
        basicButton.layer.cornerRadius = 10
        basicButton.backgroundColor = .systemBlue // 버튼의 배경색 설정
        basicButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        difficultButton.setTitle("어려움", for: .normal)
        difficultButton.layer.cornerRadius = 10
        difficultButton.backgroundColor = .systemBlue // 버튼의 배경색 설정
        difficultButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        let stackView = UIStackView()
        stackView.addArrangedSubview(basicButton)
        stackView.addArrangedSubview(difficultButton)
        stackView.spacing = 30
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 170),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -170),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100),
        ])
        
    }
    

    func makeBasicMission(){ // 기본 미션, 기본미션은 클릭즉시 리액션이옴..., 미션은 커피종류만, 1잔으로
        addCoffeeList()
        // 기본미션에 렌덤생성
        guard let randomDrink = foodList?.randomElement(),
              let randomHotOrCold = HotOrCold.allCases.randomElement(),
              let randomDensity = Density.allCases.randomElement() else {
            //missionLabel.text = "No mission available"
            return
        }
        
        let answer = Answer(selectDrink: randomDrink, selectHotOrDrink: randomHotOrCold, selectDensity: randomDensity) // answer생성
        answers.append(answer)
        mission = Mission(difficulty: .basic, answers: answers) // mission 생성
    }
    
    func addCoffeeList(){ // 기본 미션에 커피데이터 넣기
        foodList = [] // 배열 초기화, 모든 상품을 배열에 담기
        for i in Coffee.list {
            foodList?.append(i)
        }
    }
    
    func makeDifficultMission(){ // 어려운 미션, 결제하기 버튼을 눌러야 결과를 알 수 있음..., 미션은 모든 음료 종류포함, 여러잔 가능, 커피를 제외한 음료와 디저트는 옵션없이 생성해야함
        addFoodList()
        
        for _ in 1...3 {
            let randomDrink = foodList?.randomElement()
            
            randomHotOrCold = nil
            randomDensity = nil
            
            if randomDrink as? Coffee != nil { // Coffee로 캐스팅이되면
                randomHotOrCold = HotOrCold.allCases.randomElement()
                randomDensity = Density.allCases.randomElement()
            }
           
            let answer = Answer(selectDrink: randomDrink, selectHotOrDrink: randomHotOrCold, selectDensity: randomDensity) // answer생성
            answers.append(answer)
        }
        
        mission = Mission(difficulty: .difficult, answers: answers) // mission 생성
      
        
    }
    
    func addFoodList(){
        foodList = [] // 배열 초기화, 모든 상품을 배열에 담기
        for i in Coffee.list {
            foodList?.append(i)
        }
        
        for i in AdeAndTea.list{
            foodList?.append(i)
        }
        
        for i in Drink.list{
            foodList?.append(i)
        }
        
        for i in Desert.list{
            foodList?.append(i)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "GotoMissionSelectViewController" {
               if let missionSelectViewController = segue.destination as? MissionSelectViewController {
                   missionSelectViewController.mission = sender as? Mission
               }
           }
       }

}
