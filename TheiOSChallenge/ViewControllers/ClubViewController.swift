//
//  ClubViewController.swift
//  TheiOSChallenge
//
//  Created by Adonis Rumbwere on 17/7/2021.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

import FirebaseCore
import FirebaseAuth
import GoogleSignIn


class ClubViewController: UIViewController {
    
    let activity = ["Swimming","Cycling","Hiking","Rowing","Gym","Rowing"]
    var selectedActivity: String?
    
    var registrationType:String = "Club"

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailField2: UITextField!
    @IBOutlet weak var clubNameField: UITextField!
    @IBOutlet weak var clubActivityField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    
    
    private let validationLabel: UILabel = {
     let validationLabel = UILabel()
        validationLabel.textAlignment = .left
        validationLabel.text = "Fill in all necessary fields"
        validationLabel.font = .systemFont(ofSize: 13, weight: .regular)
        validationLabel.textColor = .red
     return validationLabel
         
     }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(validationLabel)
        validationLabel.alpha = 0
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        createActivityPicker()

    }
    
    
    override func viewDidLayoutSubviews() {
        
        validationLabel.frame = CGRect(x:20 ,
                                       y: repeatPasswordField.frame.origin.y+repeatPasswordField.frame
                                        .size.height+145,
                                       width: view.frame.size.width,
                                       height: 40)
        
    }
    
    func createActivityPicker() {
        let activityPicker = UIPickerView()
        activityPicker.delegate = self
        
        clubActivityField.inputView = activityPicker
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        emailField.becomeFirstResponder()
        
    }
    
    
    
    @IBAction func regType(_ sender: Any) {
        
        let IndiVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IndividualViewController")
        
        IndiVC.modalPresentationStyle = .fullScreen
        IndiVC.modalTransitionStyle = .coverVertical
        
        self.present(IndiVC, animated: true)
        
    }
    
    
    @IBAction func registerBtn(_ sender: Any) {
        
        if checkInputErrors() {
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            let headers: HTTPHeaders = [
                      "Content-Type": "application/json",
                      "Accept": "*/*"
                  ]
            
            let parameters = [
                
                "registration_type": self.registrationType,
                "second_email" : emailField2.text!,
                "email" : emailField.text!,
                "name": clubNameField.text!,
                "club_activity":clubActivityField.text!,
                "password": passwordField.text!
                
                 ]
            
            Alamofire.request(REGISTER, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (registrationResponse) in
                
                //print("Reg Response: \(registrationResponse.result.value)")
                //print("Parameters: \(parameters)")
                
                switch registrationResponse.result {
                    
                    case let .success(value):
                        let registrationResponse = JSON(value)
                        
                        MBProgressHUD.hide(for: self.view, animated: true)
                        
                        if registrationResponse["success"].stringValue == "true" {
                            
                            
                            self.showGeneralAlert(title: "Account Created", message: "Please, check your email!", vc: self)
                            
                            
                        } else {
                            
                            self.showGeneralAlert(title: "Error", message: "email or club name is already registered", vc: self)
                            
                            
                        }
                        
                        
                    case let .failure(error):
                        
                        //print("Error:\(error.localizedDescription)")
                        
                        self.showGeneralAlert(title: "Error", message: "\(error.localizedDescription)", vc: self)
                        
                        MBProgressHUD.hide(for: self.view, animated: true)
                }
                
            }
            
        }
        
    }
    
    @IBAction func googleBtn(_ sender: Any) {
        
        GIDSignIn.sharedInstance()?.signIn()
        
    }
    
    
    //MARK:- TEXTFIELD VALIDATIONS
    func checkInputErrors() -> Bool {

        if checkEmptyFields(fields: [emailField, repeatPasswordField, clubNameField,passwordField, ]) {

            if passwordField.text != repeatPasswordField.text! {

                validationLabel.text = "Your passwords do not match"
                fadeViewInThenOut(view: validationLabel, delay:2)
                return false

            }

            return true

        }

        validationLabel.text = "Please fill out all fields"
        fadeViewInThenOut(view: validationLabel, delay: 1)
        return false

    }
    

}


extension ClubViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activity.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activity[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedActivity = activity[row]
        clubActivityField.text = selectedActivity
        
    
    }
    
    
    
}
