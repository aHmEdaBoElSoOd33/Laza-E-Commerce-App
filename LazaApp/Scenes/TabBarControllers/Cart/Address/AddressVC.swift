//
//  AddressVC.swift
//  LazaApp
//
//  Created by Ahmed on 25/03/2023.
//

import UIKit
import CoreLocation


class AddressVC: UIViewController{
    
    
    @IBOutlet weak var deleteLocationBtn: UIButton!
    @IBOutlet weak var addressNameTxtField: UITextField!
    @IBOutlet weak var notesTxtView: UITextView!
    @IBOutlet weak var detailsTxtField: UITextField!
    @IBOutlet weak var regionTxtField: UITextField!
    @IBOutlet weak var cityTxtField: UITextField!
    @IBOutlet weak var saveAddressBtn: UIButton!
    @IBOutlet weak var addCoordinatorsBtn: UIButton!
    
    static let ID = String(describing: AddressVC.self)
    var state : String?
    var locationManager = CLLocationManager()
    var address : AddressDetailsData?
    var addressApi = AddressApi()
    var latitude : Double?
    var longtiude : Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        addressApi.delegate = self
        locationManager.delegate = self
        uiSetUp()
        hideKeyboardWhenTappedAround()
    }
    

    func uiSetUp(){
        if state == "add"{
            addCoordinatorsBtn.isHidden = false
            addCoordinatorsBtn.layer.borderWidth = 1
            addCoordinatorsBtn.layer.borderColor = UIColor(named: "BackGrpundColor")?.cgColor
            saveAddressBtn.setTitle("Save Address", for: .normal)
            deleteLocationBtn.isHidden = true
        }else{
            addCoordinatorsBtn.isHidden = true
            saveAddressBtn.setTitle("Update Address", for: .normal)
            deleteLocationBtn.isHidden = false
            deleteLocationBtn.layer.borderWidth = 1
            deleteLocationBtn.layer.borderColor = UIColor(named: "Color")?.cgColor
            addressNameTxtField.text = address?.name
            cityTxtField.text = address?.city
            regionTxtField.text = address?.region
            detailsTxtField.text = address?.details
            notesTxtView.text = address?.notes
        }
    }
    
    func validateAddAddress(){
        
        if latitude == nil || longtiude == nil{
            showALert(message: "Add Coordinates")
        }else{
            
            
            
            guard let name = addressNameTxtField.text, !name.trimmingCharacters(in: .whitespaces).isEmpty else {
                showALert(message: "please enter Address Name")
                return
            }
            
            guard let city = cityTxtField.text, !city.trimmingCharacters(in: .whitespaces).isEmpty else {
                showALert(message: "please enter City")
                return
            }
            
            guard let region = regionTxtField.text, !region.trimmingCharacters(in: .whitespaces).isEmpty else {
                showALert(message: "please enter Region")
                return
            }
            guard let details = detailsTxtField.text, !details.trimmingCharacters(in: .whitespaces).isEmpty else {
                showALert(message: "please enter Details")
                return
            }
            
            
            
            addressApi.AddAddress(name: name , city: city, region: region, details: details, latitude: String(latitude!), longitude: String(longtiude!), notes: notesTxtView.text)
            
        }
        
       
    }
    
    func validateUpdateAddress(){
        
        
            
            
            
            guard let name = addressNameTxtField.text, !name.trimmingCharacters(in: .whitespaces).isEmpty else {
                showALert(message: "please enter Address Name")
                return
            }
            
            guard let city = cityTxtField.text, !city.trimmingCharacters(in: .whitespaces).isEmpty else {
                showALert(message: "please enter City")
                return
            }
            
            guard let region = regionTxtField.text, !region.trimmingCharacters(in: .whitespaces).isEmpty else {
                showALert(message: "please enter Region")
                return
            }
            guard let details = detailsTxtField.text, !details.trimmingCharacters(in: .whitespaces).isEmpty else {
                showALert(message: "please enter Details")
                return
            }
             
        addressApi.UpdateAddress(id: (address?.id)!, name: name, city: city, region: region, details: details, latitude: String((address?.latitude)!), longitude:String((address?.longitude)!) , notes: notesTxtView.text)
    }
    
    
    @IBAction func saveAddress(_ sender: UIButton) {
        print(latitude)
        print(longtiude)
        
        if sender.titleLabel?.text == "Save Address"{
            validateAddAddress()
        }else{
            validateUpdateAddress()
        }
        
        
      
        
    }
    
    
    @IBAction func deleteLocationBtn(_ sender: Any) {
        
        addressApi.DeleteAddress(id: (address?.id)!)
        
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func addCoordinators(_ sender: Any) {
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
}



extension AddressVC : CLLocationManagerDelegate, AddressApiDelegate {
    func deleteAddressIsDone(message: String) {
        showAlertDeleteAddress(massege: message)
    }
    
    func deleteAddressIsFail(message: String) {
        showALert(message: message)
    }
    
    func UpdateAdressIsDone(message: String) {
        showALert(message: "Updated Successfully")
    }
    
    func UpdateAdressIsFail(message: String) {
        showALert(message: "Updated Successfully")
    }
    
      
    func AddAdressIsDone(message: String) {
        showALert(message: "Added Successfully")
    }
    
    func AddAdressIsFail(message: String) {
        showALert(message: "Added Successfully")
    }
    
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showALert(message: error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        var coord = locationObj.coordinate
        latitude = coord.latitude
        longtiude = coord.longitude 
        print(coord.latitude)
        print(coord.longitude)
        showALert(message: "Coordinates Added")
    }
    
}
