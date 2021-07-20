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
import TextFieldEffects

import FirebaseCore
import FirebaseAuth
import GoogleSignIn


class IndividualViewController: UIViewController, UIPickerViewDelegate {
    
    //let parser = Parser()
    var registrationType:String = "Individual"
    
    
    
    @IBOutlet weak var emailField: YokoTextField!
    @IBOutlet weak var userNameField: YokoTextField!
    @IBOutlet weak var passwordField: YokoTextField!
    @IBOutlet weak var repeatPasswordField: YokoTextField!
    
    
    
    private let validationLabel: UILabel = {
     let validationLabel = UILabel()
        validationLabel.textAlignment = .left
        validationLabel.text = "Fill in all necessary fields"
        validationLabel.font = .systemFont(ofSize: 13, weight: .regular)
        validationLabel.textColor = .red
     return validationLabel
         
     }()
    
    
    private let userNameCheckLable: UILabel = {
     let userNameCheckLable = UILabel()
        userNameCheckLable.textAlignment = .left
        userNameCheckLable.text = "User is available"
        userNameCheckLable.font = .systemFont(ofSize: 13, weight: .bold)
        userNameCheckLable.textColor = .systemGreen
     return userNameCheckLable
         
     }()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        UserNameAndClubNameCheck {
            print("User Names Downloaaded")
        }
        
        view.addSubview(validationLabel)
        view.addSubview(userNameCheckLable)
        
        validationLabel.alpha = 0
        userNameCheckLable.alpha = 0

    }
    
    override func viewDidLayoutSubviews() {
        
        validationLabel.frame = CGRect(x:20 ,
                                       y: repeatPasswordField.frame.origin.y+repeatPasswordField.frame
                                        .size.height+155,
                                       width: view.frame.size.width,
                                       height: 40)
        
        userNameCheckLable.frame = CGRect(x:25 ,
                                       y: userNameField.frame.origin.y+userNameField.frame
                                        .size.height+150,
                                       width: view.frame.size.width,
                                       height: 40)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        emailField.becomeFirstResponder()
        
    }
    
    @IBAction func RegTypeSwitch(_ sender: Any) {
        
        let clubVC = UIStoryboard(name: "Club", bundle: nil).instantiateViewController(withIdentifier: "ClubViewController")
        
        clubVC.modalPresentationStyle = .fullScreen
        clubVC.modalTransitionStyle = .coverVertical
        
        self.present(clubVC, animated: true)
        
    }
    
    func UserNameAndClubNameCheck(completed: @escaping DownloadComplete){
        Alamofire.request(ALL_USERS, method: .get).responseJSON { (usersResponse) in
        
            //print("AllUSERS: \(usersResponse.result.value)")
            
            switch usersResponse.result {
                
                case let .success(value):
                    print("get usernamaes response: \(value)")
                    
                    let getUsernames = JSON(value)
                    if getUsernames["success"].boolValue == true {
                        for i in 0..<getUsernames["data"].count {
                            print(getUsernames["data"].count)
                            Check.sharedInstance.notAvaiilableNames.append(getUsernames["data"][i].stringValue)
                        }
                    }
                    
                    completed()
                    print("Data:\(Check.sharedInstance.notAvaiilableNames)")
                    
                case let .failure(error):
                    print(error)
            }
        
        }
        
    }
    
    func RegisterIndividualUser(completed: @escaping DownloadComplete){
        
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let parameters = [
            
            "email" : emailField.text!,
            "second_email" : "",
            "name": userNameField.text!,
            "password": passwordField.text!,
            "registration_type": "Individual",
            "club_activity": ""
        
        ]
        
        let headers: HTTPHeaders = [
                  "Content-Type": "application/json",
                  "Accept": "*/*"
              ]
        
        
        Alamofire.request(REGISTER, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (registrationResponse) in
            //print("Reg Response: \(registrationResponse.result)")
            
            print("Params:\(parameters)")
            print("Response: \(registrationResponse.result.value)")
            
            switch registrationResponse.result {
                
                case let .success(value):
                    let registrationResponse = JSON(value)
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                    if registrationResponse["success"].stringValue == "true" {
                        
                        
                        self.showGeneralAlert(title: "Account Created Successfully", message: "Please, check your email!", vc: self)
                        
                    } else {
                        
                        self.showGeneralAlert(title: "Error", message: "", vc: self)
                        
                    }
                    
                    
                case let .failure(error):
                    
                    print("error")
                    
                    self.showGeneralAlert(title: "Error", message: "Something went wrong", vc: self)
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
            }
            
        }
        
    }
    
    
    @IBAction func registerBtn(_ sender: Any) {
        
        if checkInputErrors() {
        

        RegisterIndividualUser {
            print("Registering user")
        }
            
        }
        
    }
    
    
    @IBAction func googleBtn(_ sender: Any) {
        
        GIDSignIn.sharedInstance()?.signIn()
        
    }
    
    
    //MARK:- TEXTFIELD VALIDATIONS
    func checkInputErrors() -> Bool {

        if checkEmptyFields(fields: [emailField, repeatPasswordField, userNameField,passwordField, ]) {

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
