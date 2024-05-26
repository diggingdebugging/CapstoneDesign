//
//  FoodData.swift
//  CapstoneProject
//
//  Created by 조윤호 on 4/18/24.
//

import Foundation

protocol Food{ // 음식 정보를 담고있는 protocol
    var name: String { get }
    var imageName: String { get }
    var price: Int { get }
}

struct FoodState { // 음식 상태를 담고있는 구조체
    var food: Food
    var count: Int
    var optionPrice: Int // option이 추가될때 가격, .addshot은 +500, .addshot2은 +1000
    var totalPrice: Int // (optionPrice + food.price) * count
    var hotOrCold: HotOrCold? // OptionController의 hot, cold option
    var density: Density? // OptionController의 basic, light, addshot, addsho2 option
}

struct Coffee: Food {
    let name: String
    let imageName: String
    let price: Int
}

extension Coffee {
    static let list = [
        Coffee(name: "아메리카노",
             imageName: "americano",
             price: 3000),
        Coffee(name: "에스프레소",
             imageName: "espresso",
             price: 3000),
        Coffee(name: "카푸치노",
             imageName: "cafuchino",
             price: 4000),
        Coffee(name: "카페라떼",
             imageName: "cafe-latte",
             price: 4000),
        Coffee(name: "돌체라떼",
             imageName: "dolce-latte",
             price: 4500),
        Coffee(name: "카페모카",
             imageName: "cafe-moca",
             price: 5000)
    ]
}

struct AdeAndTea: Food {
    let name: String
    let imageName: String
    let price: Int
}

extension AdeAndTea {
    static let list = [
        AdeAndTea(name: "히비스커스티",
             imageName: "hibiscus-tea",
             price: 4500),
        AdeAndTea(name: "딸기라떼",
             imageName: "strawberry-latte",
             price: 4800),
        AdeAndTea(name: "자몽에이드",
             imageName: "grapefruit-ade",
             price: 4200),
        AdeAndTea(name: "레몬블렌디드",
             imageName: "lemon-blended",
             price: 4900),
        AdeAndTea(name: "딸기아사이레몬에이드",
             imageName: "strawberry-acai-lemonade",
             price: 4700),
        AdeAndTea(name: "용과에이드",
             imageName: "dragonfruit-ade",
             price: 4500),
        AdeAndTea(name: "자몽허니블랙티",
             imageName: "grapefruit-honey-black-tea",
             price: 4800),
        AdeAndTea(name: "그린티",
             imageName: "green-tea",
             price: 3500),
        AdeAndTea(name: "얼그레이티",
             imageName: "earl-grey-tea",
             price: 4000)
    ]
}

struct Drink: Food {
    let name: String
    let imageName: String
    let price: Int
}

extension Drink {
    static let list = [
        Drink(name: "자바칩프라푸치노",
             imageName: "java-chip-frappuccino",
             price: 4500),
        Drink(name: "사과케일주스",
             imageName: "apple-kale-juice",
             price: 4200),
        Drink(name: "한라봉주스",
             imageName: "hallabong-juice",
             price: 4300),
        Drink(name: "망고주스",
             imageName: "mango-juice",
             price: 4000),
        Drink(name: "사과주스",
             imageName: "apple-juice",
             price: 3800),
        Drink(name: "딸기요거트",
             imageName: "strawberry-yogurt",
             price: 4600),
        Drink(name: "밀크티",
             imageName: "milk-tea",
             price: 3500),
        Drink(name: "우유",
             imageName: "milk",
             price: 3000),
        Drink(name: "망고스무디",
             imageName: "mango-smoothie",
             price: 4800)
    ]
}


struct Desert: Food {
    let name: String
    let imageName: String
    let price: Int
}

extension Desert {
    static let list = [
        Desert(name: "카스테라",
             imageName: "castella",
             price: 4500),
        Desert(name: "티라미수",
             imageName: "tiramisu",
             price: 4800),
        Desert(name: "초코롤",
             imageName: "choco-roll",
             price: 4200),
        Desert(name: "초코케이크",
             imageName: "choco-cake",
             price: 4900),
        Desert(name: "소금빵",
             imageName: "salt-bread",
             price: 3500),
        Desert(name: "베이글",
             imageName: "bagel",
             price: 3000),
        Desert(name: "샌드위치",
             imageName: "sandwich",
             price: 4500),
        Desert(name: "레드벨벳케이크",
             imageName: "red-velvet-cake",
             price: 4800),
        Desert(name: "녹차케이크",
             imageName: "green-tea-cake",
             price: 4700)
    ]
}

enum Option { // KioskViewController의 Tabbar에서 선택하는 option
    case Coffee, AdeAndTea, Drink, Desert
}

enum HotOrCold :CaseIterable { // FoodState의 속성
    case hot, cold
}

enum Density: CaseIterable{ // FoodState의 속성
    case basic, light, addShot, addShot2
}



