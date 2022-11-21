//
//  Planets.swift
//  StarWars
//
//  Created by Vishwa Fernando on 2022-11-21.
//

import Foundation
import UIKit
import ObjectMapper

class Planets: NSObject, Mappable {
    
    var count    : NSNumber = 0
    var next     : NSString = ""
    var previous : NSString = ""
    var result   : [Result_] = []

    init(count: NSNumber, next: NSString, previous : NSString, result: [Result_]) {
        
        self.count    = count
        self.next     = next
        self.previous = previous
        self.result   = result
        
    }
    
    required internal init?(map: Map){ }
    
    internal func mapping(map: Map) {
        
        count    <- map["count"]
        next     <- map["next"]
        previous <- map["previous"]
        result   <- map["results"]
        
    }
    
    deinit {
        print("deinit - Planets")
    }
    
}
