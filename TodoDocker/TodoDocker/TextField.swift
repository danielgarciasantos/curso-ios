//
//  TextField.swift
//  TodoDocker
//
//  Created by Daniel Garcia on 07/12/2017.
//  Copyright © 2017 Daniel Garcia. All rights reserved.
//

import Foundation
import UIKit

class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 5);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}
