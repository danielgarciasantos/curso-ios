//
//  Constants.swift
//  network
//
//  Created by Lucas Paim on 24/11/2017.
//  Copyright © 2017 Lucas Paim. All rights reserved.
//

import Foundation
import MBProgressHUD

struct AppConfig {
    static let kHttpEndpoint = "http://localhost:8000/api"
    static let applicationJson = "application/json"
    static let AcceptLanguage = "pt-br"
}

struct ParamentrosLogin {
    static let client_id = "POWKMslbDUk6stRakfRl0P4ial3SHqbnOPDTp57x"
    static let client_secret = "bXl0uNV6ufUnvZJYae66OIbZ34KLvSkwpcleyeUCVrzmQWYGbJEGtTbP6tZuaKG53qEywDg5KXSSAvH969VkDCm247aTq2Hb8F47Hvt8gK2s2qzjzyO73KrL4Qmdd4CJ"
}

extension UIViewController{
    
    func showLoanding() {
        let progressView = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressView.label.text = "Loading..."
        progressView.mode = .indeterminate
    }
    
    func hideLoading() {
        OperationQueue.main.addOperation {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
