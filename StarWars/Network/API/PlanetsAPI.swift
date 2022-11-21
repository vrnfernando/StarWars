//
//  GetPlanetsAPI.swift
//  StarWars
//
//  Created by Vishwa Fernando on 2022-11-21.
//

import Foundation

/// API Protocol 
protocol GetPlanetsProtocol {
    
    func getPlanetsList(contextPath: NSString, pagination: Bool)
    
}
