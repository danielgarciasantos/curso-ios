//
//  PostRoute.swift
//  network
//
//  Created by Lucas Paim on 24/11/2017.
//  Copyright © 2017 Lucas Paim. All rights reserved.
//

import Foundation
import EasyRest


enum Route: Routable {
    
    case loginRoute(username:String, password:String)
    case getAllTasksRoute
    case salvarTask(task: Result)
    
    var rule: Rule {
        switch self {
        case .getAllTasksRoute:
            return Rule(method: .get, path: "/v1/tasks/",
                        isAuthenticable: false, parameters: [:])
        case let .loginRoute(username, password):
            return Rule(method: .post, path: "/oauth/token/",
                        isAuthenticable: false, parameters: [.query:
                            ["client_id": ParamentrosLogin.client_id,
                             "client_secret": ParamentrosLogin.client_secret,
                             "grant_type" : "password",
                             "username": username,
                             "password": password]
                ])
        case let .salvarTask(task):
            return Rule(method: .post, path: "/v1/tasks/",
                        isAuthenticable: false, parameters: [.body: task])
        }
    }
    
}

