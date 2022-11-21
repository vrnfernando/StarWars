//
//  HTTPService.swift
//  StarWars
//
//  Created by Vishwa Fernando on 2022-11-21.
//

import Foundation
import Alamofire
import ObjectMapper


protocol PlanetDataAPIDelegate: AnyObject {
    
    func getPlanetList(response: Planets)
    func getPlanetList(_ error: Error)
    
}

class HTTPService: NSObject {
    
    weak var planetDataAPIDelegate : PlanetDataAPIDelegate?
    
    //URL
    static var url: NSString = "https://swapi.dev/"
    
    //Paths
    static var apiPath_planets = "api/planets/"
    
    //Pagination
    var isPaginating = false
    
    var baseURL : NSString?
    var headers  : HTTPHeaders
    
    init(baseURL: NSString! = url){
        self.baseURL = baseURL
        self.headers = ["Content-Type":"application/json"]
    }
    
    /// Get Request
    /// - Parameters:
    ///   - parameters: <#parameters description#>
    ///   - contextPath: url path
    ///   - completionHandler: <#completionHandler description#>
    func getRequest(_ parameters: [String: AnyObject]?, contextPath: NSString, completionHandler: @escaping (HTTPResponse) -> Void) {
        
        let urlString   = "\(self.baseURL!)\(contextPath)" as URLConvertible

        Alamofire.request(urlString, method: .get, parameters: nil, headers: self.headers).responseJSON { (response) in
            
            var httpResponse: HTTPResponse! = nil
            
            if let errorCode       = response.result.error,
               let errorMessage    = response.result.error?.localizedDescription {
                
                httpResponse                = HTTPResponse(result: nil, error: nil)
                print("alamofire error")
                print("getRequest -> error code: \(errorCode)")
                print("getRequest -> error message: \(errorMessage)")
                
            } else {
                
                do {
                    let jsonResult = try JSON(data: response.data!)
                    if response.response!.statusCode >= 200 && response.response!.statusCode < 300 {
                        httpResponse        = HTTPResponse(result: jsonResult, error: nil)
                        
                    }else{
                        
                        httpResponse        = HTTPResponse(result: nil, error: jsonResult as? Error)
                    }
                    
                } catch {
                    print("Error")
                }
            }
            if httpResponse != nil {
                completionHandler(httpResponse)
            }
        }
    }
    
}

extension HTTPService: GetPlanetsProtocol {
    
    /// Get Planet data list API request
    func getPlanetsList(contextPath: NSString, pagination: Bool) {
        
        if pagination {
            self.isPaginating = true
        }
        
        var _contextPath = ""
        if contextPath != "" {
            _contextPath = contextPath as String
        }
        
        getRequest(nil, contextPath: _contextPath as NSString) { (response) in
            
            let responseError = response.responseError
            let responseResult  = response.responseResult
            
            if let error = responseError {
                self.planetDataAPIDelegate?.getPlanetList(error)
                return
            }
            
            if let json = responseResult {
                
                if let jsonString   = json.rawString() {
                    if let planet     = Mapper<Planets>().map(JSONString: jsonString) {
                        self.planetDataAPIDelegate?.getPlanetList(response: planet)
                        if pagination {
                            self.isPaginating = false
                        }
                    }
                    return
                }else{
                    let exception               = json.error
                    self.planetDataAPIDelegate?.getPlanetList(exception!)
                    return
                }
            }
            return
        }
    }
    
}
