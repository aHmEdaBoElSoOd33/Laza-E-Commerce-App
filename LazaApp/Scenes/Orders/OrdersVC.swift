//
//  OrdersVC.swift
//  LazaApp
//
//  Created by Ahmed on 26/03/2023.
//

import UIKit

class OrdersVC: UIViewController {

    //MARK: - IBOutlets
    
    
    @IBOutlet weak var ordersCollectionView: UICollectionView!
    
     
    
    //MARK: - Variables
    
    
    static let ID = String(describing: OrdersVC.self)
    var ordersArray : [OrderModelDataDetails] = []
    var orderApi = OrdersApi()
    var indecatorView : UIActivityIndicatorView?
    var hideFavebtn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
 
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        uiSetUp()
        getOrdersDataFromApi()
    }
    //MARK: - Functions
    
    func uiSetUp(){
        view.isUserInteractionEnabled = false
        indecatorView = activityIndicator(style: .large, center: self.view.center)
        indecatorView?.startAnimating()
        self.view.addSubview(indecatorView!)
        ordersCollectionView.delegate = self
        ordersCollectionView.dataSource = self
    }
    
    
    func getOrdersDataFromApi(){
        
        orderApi.getOrders { data in
            self.ordersArray = data
            self.ordersCollectionView.reloadData()
            self.indecatorView?.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    
    
    //MARK: - IBActions
    @IBAction func backBtn(_ sender: Any) {
        tabBarNavigation(pageindex: 0)
    }
    
}



extension OrdersVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ordersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrdersCollectionViewCell.ID, for: indexPath) as! OrdersCollectionViewCell
        
        
        
        cell.layer.borderColor = UIColor(named: "BackGrpundColor")?.withAlphaComponent(0.5).cgColor
        cell.layer.borderWidth = 1
        cell.orderStatLbl.text = ordersArray[indexPath.row].status
        if cell.orderStatLbl.text == "New"{
            cell.orderStatLbl.textColor = .green
        }else{
            cell.orderStatLbl.textColor = .red
        }
        
        cell.orderdateLbl.text = ordersArray[indexPath.row].date
        cell.totalCostLbl.text = "\(Float(ordersArray[indexPath.row].total!))"
        
        
        
        return cell
    }
     
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20, height: collectionView.bounds.height / 8)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: OrderDetailsVC.ID) as! OrderDetailsVC
        vc.id = ordersArray[indexPath.row].id
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true) 
    }
    
    
    
}
