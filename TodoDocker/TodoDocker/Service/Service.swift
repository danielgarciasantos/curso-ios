//
//  PostService.swift
//  network
//
//  Created by Lucas Paim on 24/11/2017.
//  Copyright © 2017 Lucas Paim. All rights reserved.
//

import Foundation
import EasyRest


class AppService: Service<Route> {
    
    override var base: String { return AppConfig.kHttpEndpoint }
    override var interceptors: [Interceptor]? {return [CurlInterceptor()]}
    
    func postLogin(username: String, password: String, Success: @escaping (Response<Login>?) -> Void,
                  onError: @escaping (RestError?) -> Void,
                  always: @escaping () -> Void) {
        try! call(.loginRoute(username: username, password: password), type: Login.self, onSuccess: Success,
                  onError: onError, always: always)
    }
    
    func getAllTasks(Success: @escaping (Response<Task>?) -> Void,
                   onError: @escaping (RestError?) -> Void,
                   always: @escaping () -> Void) {
        try! call(.getAllTasksRoute , type: Task.self, onSuccess: Success,
                  onError: onError, always: always)
    }
    
    func salvarTask(task: Result, Success: @escaping (Response<Result>?) -> Void,
                     onError: @escaping (RestError?) -> Void,
                     always: @escaping () -> Void) {
        try! call(.salvarTask(task: task), type: Result.self, onSuccess: Success,
                  onError: onError, always: always)
    }
    
    func editarTask(task: Result, Success: @escaping (Response<Result>?) -> Void,
                    onError: @escaping (RestError?) -> Void,
                    always: @escaping () -> Void) {
        try! call(.editarTask(task: task), type: Result.self, onSuccess: Success,
                  onError: onError, always: always)
    }
    
}

