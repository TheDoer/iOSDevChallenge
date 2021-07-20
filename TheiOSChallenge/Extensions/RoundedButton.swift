//
//  RoundedButton.swift
//  TheiOSChallenge
//
//  Created by Adonis Rumbwere on 17/7/2021.
//

import UIKit

class CustomRoundedButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setRadiusAndShadow()
        
    }
    
    func setRadiusAndShadow(){
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 3, height: 3)
        //layer.shadowColor = #colorLiteral(red: 0.7927846909, green: 0.0404618904, blue: 0.00875054393, alpha: 1)
         
        
    }
    
}
