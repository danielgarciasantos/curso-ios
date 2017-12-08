//
//  Login.swift
//  TodoDocker
//
//  Created by Daniel Garcia on 06/12/2017.
//  Copyright © 2017 Daniel Garcia. All rights reserved.
//

import Foundation
import EasyRest
import Genome

class Login: BaseModel {
    
    var access_token: String?
    var expires_in: Int?
    var token_type: String?
    var scope: String?
    var refresh_token: String?
    
    override func sequence(_ map: Map) throws {
        try access_token <~> map["access_token"]
        try expires_in <~ map["expires_in"]
        try token_type <~ map["token_type"]
        try scope <~ map["scope"]
        try refresh_token <~ map["scope"]
    }
    
}

var loginModel = Login()
