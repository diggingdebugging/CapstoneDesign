//
//  KioskViewController.swift
//  CapstoneProject
//
//  Created by 조윤호 on 4/18/24.
//

import UIKit

class KioskViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabbar: UITabBar!
    
    var select: Option = .Coffee
    var list : [Food] = Coffee.list
    var foodStateList : [FoodState] = []
    var totalPrice: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tabbar.delegate = self
        
        setupTabBar()
        setupCollectionView()
    }
    
    @IBAction func calcButton(_ sender: UIButton) { // 계산하기 버튼
        totalPrice = foodStateList.reduce(0) { $0 + $1.totalPrice }
        performSegue(withIdentifier: "GoToSelectionViewController", sender: totalPrice)
        print("1")
    }
    
}
extension KioskViewController{ // tabBar, collectionView UI
    // TabBar UI
    func setupTabBar() {
        // 기본 텍스트 속성
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 18)  // 텍스트 크기를 18로 설정
        ]
        
        // 선택된 탭 텍스트 속성
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.blue,
            .font: UIFont.boldSystemFont(ofSize: 18)  // 텍스트 크기를 18로 설정
        ]
        
        if let items = tabbar.items {
            for item in items {
                // 기본 텍스트 속성 설정
                item.setTitleTextAttributes(normalAttributes, for: .normal)
                
                // 선택된 탭 텍스트 속성 설정
                item.setTitleTextAttributes(selectedAttributes, for: .selected)
                
                // 중앙 정렬을 위해 titlePositionAdjustment 설정
                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)  // 수직 위치 조정
            }
        }
        
        // 탭바 배경색 설정
        tabbar.barTintColor = UIColor.white
        
        // 탭바 전체 틴트 색상 설정 (아이템 색상)
        tabbar.tintColor = UIColor.blue
    }
    // CollectionView UI
    func setupCollectionView() {
        if let flowlayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowlayout.estimatedItemSize = .zero
        }
        
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16)
    }
}

extension KioskViewController: UICollectionViewDataSource { // CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as? FoodCell else {
            return UICollectionViewCell()
        }
        let food = list[indexPath.item]
        cell.configure(food)
        cell.layer.cornerRadius = 10
        return cell
    }
}

extension KioskViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate { // CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 3열일때 계산
        let interItemSpacing: CGFloat = 10
        let padding: CGFloat = 16
        
        let width = (collectionView.bounds.width - interItemSpacing * 2 - padding * 2) / 3
        let height = width * 1.8
        
        return CGSize(width: width, height: height)
        
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToOptionController", sender: indexPath)
    }
}

extension KioskViewController{ // prepare, performSegue호출되면 호출됨
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? OptionViewController{
            vc.kioskViewController = self
            vc.foodIndex = (sender as? IndexPath)?.row
        }
        if let vc = segue.destination as? SelectionViewController{
            vc.totalPrice = sender as? Int
        }
        
    }
}

extension KioskViewController: UITableViewDelegate, UITableViewDataSource{ // TableView Delegate, DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodStateList.count
    }
    
    //as를 이용한 타입 캐스팅을 통해 myTableViewCell을 불러옴
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath) as! OptionCell
        let foodState = foodStateList[indexPath.row] // 선택된 객체의 레퍼런스
        
        cell.delegate = self
        
        // cell의 UI 초기화
        cell.nameLabel.text = foodState.food.name
        cell.priceLabel.text = String(foodState.totalPrice)
        cell.countLabel.text = String(foodState.count)
        
        // cell의 정보 초기화
        cell.count = foodState.count
        cell.price = foodState.food.price // 상품의 원래 가격
        cell.optionPrice = foodState.optionPrice // 상품의 옵션 가격
        cell.totalPrice = foodState.totalPrice // cell당 상품 총합 가격
        
        // cell의 hotOrCold Option
        if foodState.hotOrCold == .hot {
            cell.optionTwoLabel.text = "뜨거운(HOT)"
        }
        else if foodState.hotOrCold == .cold {
            cell.optionTwoLabel.text = "차가운(COLD)"
        }
        
        // cell의 density Option
        switch foodState.density {
        case .basic:
            cell.optionOneLabel.text = "기본"
        case .light:
            cell.optionOneLabel.text = "연하게"
        case .addShot:
            cell.optionOneLabel.text = "샷 추가"
        case .addShot2:
            cell.optionOneLabel.text = "샷 두번추가"
        default:
            cell.optionOneLabel.text = "기본"
        }
        // cell의 optionPrice
        cell.optionOnePriceLabel.text = String(foodState.optionPrice)
                
        return cell
    }
    
    //셀 자체의 사이즈 크기 조정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 여기서 원하는 셀 높이를 반환합니다. 예를 들어 80.0으로 설정할 수 있습니다.
        return 80.0
    }
}

extension KioskViewController: OptionCellDelegate { // TableView의 Cell의 Delegate
    func didTapRemoveButton(on cell: OptionCell){
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        foodStateList.remove(at: indexPath.row)
        tableView.reloadData()
    }
    func didUpdateCountAndPrice(on cell: OptionCell, count: Int, price: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        foodStateList[indexPath.row].count = count
        foodStateList[indexPath.row].totalPrice = count * (foodStateList[indexPath.row].food.price + foodStateList[indexPath.row].optionPrice)
        tableView.reloadData()
        // 가격 업데이트는 자동으로 totalPrice 계산에 포함됩니다.
    }
}

extension KioskViewController: UITabBarDelegate { // TabBar Delegate
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.title {
        case "커피" :
            list = Coffee.list
            select = .Coffee
        case "에이드&티":
            list = AdeAndTea.list
            select = .AdeAndTea
        case "음료":
            list = Drink.list
            select = .Drink
        case "디저트":
            list = Desert.list
            select = .Desert
        default :
            break
        }
        collectionView.reloadData() // 이미지를 바꾸기 위해 reload()
    }
}






