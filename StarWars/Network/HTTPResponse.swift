//
//  HTTPResponse.swift
//  StarWars
//
//  Created by Vishwa Fernando on 2022-11-21.
//

import Foundation
import UIKit

class HTTPResponse: NSObject {
    
    var responseStatus  : Bool  = true
    var responseResult  : JSON?
    var responseError   : Error?
    
    init(status: Bool, result: JSON? = nil, error: Error? = nil) {
        self.responseStatus     = status
        self.responseResult     = result
        self.responseError      = error
    }
    
    init(result: JSON? = nil, error: Error? = nil) {
        self.responseResult     = result
        self.responseError      = error
    }
}
