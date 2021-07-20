//
//  UIViewController.swift
//  TheiOSChallenge
//
//  Created by Adonis Rumbwere on 17/7/2021.
//

import UIKit

extension UIViewController {
    
    
    func dismissKeyboard(){
        
        view.endEditing(true)
    }
    
    func checkEmptyFields(fields: [UITextField]) -> Bool {
        
        for textfield in fields {
            
            if textfield.text == nil || textfield.text! == "" {
                
                return false
            }
        }
        
        return true
        
    }
    
    func fadeViewInThenOut(view : UIView, delay: TimeInterval) {
        let animationDuration = 0.25
        
        // Fade in the view
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            view.alpha = 1
        }) { (Bool) -> Void in
            
            // After the animation completes, fade out the view after a delay
            UIView.animate(withDuration: animationDuration, delay: delay, options: [.curveEaseOut], animations: { () -> Void in
                view.alpha = 0
            }, completion: nil)
        }
    }
    
    func showGeneralAlert(title: String!, message: String!, vc: UIViewController) {
        
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

                   // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
               
                    
            }))

                // show the alert
                vc.present(alert, animated: true, completion: nil)

    }
}

