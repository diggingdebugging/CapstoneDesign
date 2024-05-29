//
//  DifficultySelectViewController.swift
//  CapstoneProject
//
//  Created by yujin on 5/26/24.
//

import UIKit

class DifficultySelectViewController: UIViewController {
    let titleLabel = UILabel()
    let basicDescriptionLabel = UILabel()
    let difficultDescriptionLabel = UILabel()
    
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
        titleLabel.text = "난이도 선택"
        titleLabel.font = UIFont(name: "Jalnan2", size: 35)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        
        basicButton.setTitle("기본", for: .normal)
        basicButton.layer.cornerRadius = 10
        basicButton.backgroundColor = UIColor(hexCode: "143785")
        basicButton.titleLabel?.font = UIFont(name: "Jalnan2", size: 25)
        
        basicDescriptionLabel.text = "메뉴 1개 주문"
        basicDescriptionLabel.font = UIFont(name: "Jalnan2", size:  20)
        basicDescriptionLabel.textAlignment = .center
        basicDescriptionLabel.textColor = .black
        
        difficultButton.setTitle("어려움", for: .normal)
        difficultButton.layer.cornerRadius = 10
        difficultButton.backgroundColor = UIColor(hexCode: "143785") // 버튼의 배경색 설정
        difficultButton.titleLabel?.font = UIFont(name: "Jalnan2", size: 25)
        
        difficultDescriptionLabel.text = "메뉴 3개 주문"
        difficultDescriptionLabel.font = UIFont(name: "Jalnan2", size: 20   )
        difficultDescriptionLabel.textAlignment = .center
        difficultDescriptionLabel.textColor = .black
                
        view.addSubview(titleLabel)
        view.addSubview(basicButton)
        view.addSubview(basicDescriptionLabel)
        view.addSubview(difficultButton)
        view.addSubview(difficultDescriptionLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        basicButton.translatesAutoresizingMaskIntoConstraints = false
        basicDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        difficultButton.translatesAutoresizingMaskIntoConstraints = false
        difficultDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            basicButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
            basicButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            basicButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            basicButton.heightAnchor.constraint(equalToConstant: 50),
            
            basicDescriptionLabel.topAnchor.constraint(equalTo: basicButton.bottomAnchor, constant: 20),
            basicDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            basicDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                        
            difficultButton.topAnchor.constraint(equalTo: basicDescriptionLabel.bottomAnchor, constant: 80),
            difficultButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            difficultButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            difficultButton.heightAnchor.constraint(equalToConstant: 50),
            
            difficultDescriptionLabel.topAnchor.constraint(equalTo: difficultButton.bottomAnchor, constant: 20),
            difficultDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            difficultDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
            
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
        let randomAction = Action.allCases.randomElement()
        
        let answer = Answer(selectDrink: randomDrink, selectHotOrDrink: randomHotOrCold, selectDensity: randomDensity) // answer생성
        answers.append(answer)
        mission = Mission(difficulty: .basic, answers: answers, action:  randomAction) // mission 생성
    }
    
    func addCoffeeList(){ // 기본 미션에 커피데이터 넣기
        foodList = [] // 배열 초기화, 모든 상품을 배열에 담기
        for i in Coffee.list {
            foodList?.append(i)
        }
    }
    
    func makeDifficultMission(){ // 어려운 미션, 결제하기 버튼을 눌러야 결과를 알 수 있음..., 미션은 모든 음료 종류포함, 여러잔 가능, 커피를 제외한 음료와 디저트는 옵션없이 생성해야함
        addFoodList()
        
        var randomDrink = foodList?.randomElement()
        randomHotOrCold = nil
        randomDensity = nil
        
        if randomDrink as? Coffee != nil { // Coffee로 캐스팅이되면
            randomHotOrCold = HotOrCold.allCases.randomElement()
            randomDensity = Density.allCases.randomElement()
        }
        
        let answer = Answer(selectDrink: randomDrink, selectHotOrDrink: randomHotOrCold, selectDensity: randomDensity) // answer생성
        answers.append(answer)
        
        // 재시동
        randomDrink = foodList?.randomElement()
        for i in 0...1 {
            while answers[i].selectDrink?.name == randomDrink?.name {
                randomDrink = foodList?.randomElement()
            }
            
            if randomDrink as? Coffee != nil { // Coffee로 캐스팅이되면
                randomHotOrCold = HotOrCold.allCases.randomElement()
                randomDensity = Density.allCases.randomElement()
            } else {
                randomHotOrCold = nil
                randomDensity = nil                
            }
            let answer = Answer(selectDrink: randomDrink, selectHotOrDrink: randomHotOrCold, selectDensity: randomDensity) // answer생성
            answers.append(answer)
        }
        
        let randomAction = Action.allCases.randomElement()
        mission = Mission(difficulty: .difficult, answers: answers, action: randomAction) // mission 생성
    }
    
    func randomAnswer() {
        
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
                missionSelectViewController.modalPresentationStyle = .fullScreen
            }
        }
    }
    
}
