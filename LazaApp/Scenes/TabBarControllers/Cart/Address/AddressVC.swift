//
//  AddressVC.swift
//  LazaApp
//
//  Created by Ahmed on 25/03/2023.
//

import UIKit

class AddressVC: UIViewController {
    @IBOutlet weak var deleteLocationBtn: UIButton!
    @IBOutlet weak var addressNameTxtField: UITextField!
    @IBOutlet weak var notesTxtView: UITextView!
    @IBOutlet weak var detailsTxtField: UITextField!
    @IBOutlet weak var regionTxtField: UITextField!
    @IBOutlet weak var cityTxtField: UITextField!
    @IBOutlet weak var saveAddressBtn: UIButton!
    static let ID = String(describing: AddressVC.self)
    @IBOutlet weak var addCoordinatorsBtn: UIButton!
    
    var state : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSetUp() 
    }
    

    func uiSetUp(){
        
        if state == "add"{
            addCoordinatorsBtn.isHidden = false
            addCoordinatorsBtn.layer.borderWidth = 1
            addCoordinatorsBtn.layer.borderColor = UIColor(named: "BackGrpundColor")?.cgColor
            saveAddressBtn.titleLabel?.text = "Save Address"
            deleteLocationBtn.isHidden = true
        }else{
            addCoordinatorsBtn.isHidden = true
            saveAddressBtn.titleLabel?.text = "Update Address"
            deleteLocationBtn.isHidden = false
            deleteLocationBtn.layer.borderWidth = 1
            deleteLocationBtn.layer.borderColor = UIColor(named: "Color")?.cgColor
        }
        
        
    }
    
    
    
    
    @IBAction func saveAddress(_ sender: Any) {
        
        
        
    }
    
    
    @IBAction func deleteLocationBtn(_ sender: Any) {
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func addCoordinators(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
