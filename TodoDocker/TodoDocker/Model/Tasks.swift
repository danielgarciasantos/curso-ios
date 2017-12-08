//
//  Tasks.swift
//  TodoDocker
//
//  Created by Daniel Garcia on 07/12/2017.
//  Copyright © 2017 Daniel Garcia. All rights reserved.
//

import Foundation
import EasyRest
import Genome

class Task: BaseModel {
    var count: Int?
    var next: String?
    var previous: String?
    var results : [Result]?
    
    override func sequence(_ map: Map) throws {
        try count <~> map["count"]
        try next <~ map["next"]
        try previous <~ map["previous"]
        try results <~ map["results"]
    }
    
}


class Result: BaseModel {
    
    var id: String?
    var expiration_date: String?
    var title: String?
    var descriptionn: String?
    var is_complete: Bool?
    var id_owner : String?
    
    
    override func sequence(_ map: Map) throws {
        try id <~> map["id"]
        try expiration_date <~> map["expiration_date"]
        try title <~> map["title"]
        try descriptionn <~> map["description"]
        try is_complete <~> map["is_complete"]
        try id_owner <~> map["id_owner"]
    }
    
}

