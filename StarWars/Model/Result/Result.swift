//
//  Result.swift
//  StarWars
//
//  Created by Vishwa Fernando on 2022-11-21.
//

import Foundation
import UIKit
import ObjectMapper

class Result_ : NSObject, Mappable {
    
    var name                : NSString = ""
    var rotation_period     : NSString = ""
    var orbital_period      : NSString = ""
    var diameter            : NSString = ""
    var climate             : NSString = ""
    var gravity             : NSString = ""
    var terrain             : NSString = ""
    var surface_water       : NSString = ""
    var population          : NSString = ""
    var residents           : [NSString] = []
    var films               : [NSString] = []
    var created             : NSString = ""
    var edited              : NSString = ""
    var url                 : NSString = ""
    

    init(name: NSString, rotation_period: NSString, orbital_period: NSString, diameter: NSString, climate: NSString, gravity: NSString, terrain: NSString, surface_water: NSString, population: NSString, residents: [NSString], films: [NSString], created: NSString, edited: NSString, url: NSString) {
        
        self.name               = name
        self.rotation_period    = rotation_period
        self.orbital_period     = orbital_period
        self.diameter           = diameter
        self.climate            = climate
        self.gravity            = gravity
        self.terrain            = terrain
        self.surface_water      = surface_water
        self.population         = population
        self.residents          = residents
        self.films              = films
        self.created            = created
        self.edited             = edited
        self.url                = url
        
    }
    
    required internal init?(map: Map){ }
    
    internal func mapping(map: Map) {
        
        name                <- map["name"]
        rotation_period     <- map["rotation_period"]
        orbital_period      <- map["orbital_period"]
        diameter            <- map["diameter"]
        climate             <- map["climate"]
        gravity             <- map["gravity"]
        terrain             <- map["terrain"]
        surface_water       <- map["surface_water"]
        population          <- map["population"]
        residents           <- map["residents"]
        films               <- map["films"]
        created             <- map["created"]
        edited              <- map["edited"]
        url                 <- map["url"]
        
    }
    
    deinit {
        print("deinit - Result")
    }
    
}
