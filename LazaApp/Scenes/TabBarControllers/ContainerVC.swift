//
//  ContainerVC.swift
//  LazaApp
//
//  Created by Ahmed on 18/03/2023.
//

import UIKit

class ContainerVC: UITabBarController {

    static let ID = String(describing: ContainerVC.self)
    var selectedPage = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = selectedPage
    }
     

}
