//
//  UserRegistration.swift
//  TheiOSChallenge
//
//  Created by Adonis Rumbwere on 17/7/2021.
//

import Foundation
import SwiftyJSON

class UserName {

    
    private var _userName: String!
    
    var userName: String {
        if _userName == nil {
            _userName = ""
        }
        
        return _userName
   }
    
    init(userNameDict: JSON) {
        self._userName = userNameDict["data"]["name"].stringValue
    }

}
