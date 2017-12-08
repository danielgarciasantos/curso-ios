//
//  CurlInterceptor.swift
//  TodoDocker
//
//  Created by Daniel Garcia on 07/12/2017.
//  Copyright © 2017 Daniel Garcia. All rights reserved.
//

import Foundation
import EasyRest
import Alamofire
import Genome

class CurlInterceptor: Interceptor {
    
    required init() {}
    
    func responseInterceptor<T>(_ api: API<T>, response: DataResponse<Any>) where T : NodeInitializable {
    }
    
    func requestInterceptor<T>(_ api: API<T>) where T : NodeInitializable {
        api.headers["Authorization"] = "Bearer \(loginModel.access_token ?? "")"
    }
    
}
