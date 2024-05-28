//
//  MissionData.swift
//  CapstoneProject
//
//  Created by yujin on 5/22/24.
//

import Foundation

struct Mission {
    let difficulty: Difficulty
    let answers: [Answer]
    let action: Action?
}

struct Answer {
    var selectDrink: Food?
    var selectHotOrDrink: HotOrCold?
    var selectDensity: Density?
}

enum Difficulty {
    case basic, difficult
}

enum Action : CaseIterable {
    case forhere, takeout
}
// 1. 레몬에이드선택, 2. 차가움, 3. 기본, 4. 포장하기 버튼 누르기


