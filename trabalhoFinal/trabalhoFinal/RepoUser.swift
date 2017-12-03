//
//  RepoUser.swift
//  trabalhoFinal
//
//  Created by Daniel Garcia on 01/12/2017.
//  Copyright © 2017 Daniel Garcia. All rights reserved.
//

import Foundation


struct Repos: Codable {
    let name: String
    let html_url: String
    let owner: Owner
}

struct Owner: Codable {
    let avatar_url: String
    let login: String
}

struct User: Codable {
    let avatar_url: String?
    let login: String
    let company: String?
    let name: String?
}

var users : [User] = []
var lastIndex: Int = 0

