//
//  ApiCalls.swift
//  NeoTechExercise
//
//  Created by Johnny Owayed on 11/7/20.
//

import UIKit
import Alamofire

class ApiCalls {
    
    final class func fetchPortfolios(successCallback: ((_ fetchResult:[[String:Any]]) -> ())? = nil, errorCallback: ((_ error:AFError?) -> ())? = nil) {
        let path = "http://localhost:3000/portfolios"
        AF.request(path, method: HTTPMethod.get, encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { (response) in
            switch response.result {
                case .success:
                print()
                    let response = response.value as? [[String:Any]] ?? [[String:Any]]()
                    if let successCallback = successCallback {
                        successCallback(response)
                    }
                case .failure:
                    let error = response.error
                    if let errorCallback = errorCallback {
                        errorCallback(error)
                    }
            }
        }
    }
    
    final class func fetchOptions(successCallback: ((_ fetchResult:[[String:Any]]) -> ())? = nil, errorCallback: ((_ error:AFError?) -> ())? = nil) {
        let path = "http://localhost:3000/options"
        AF.request(path, method: HTTPMethod.get, encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { (response) in
            switch response.result {
                case .success:
                print()
                    let response = response.value as? [[String:Any]] ?? [[String:Any]]()
                    if let successCallback = successCallback {
                        successCallback(response)
                    }
                case .failure:
                    let error = response.error
                    if let errorCallback = errorCallback {
                        errorCallback(error)
                    }
            }
        }
    }
    
    final class func fetchHistoricalData(successCallback: ((_ fetchResult:[[String:Any]]) -> ())? = nil, errorCallback: ((_ error:AFError?) -> ())? = nil) {
        let path = "http://localhost:3000/historical_data"
        AF.request(path, method: HTTPMethod.get, encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { (response) in
            switch response.result {
                case .success:
                print()
                    let response = response.value as? [[String:Any]] ?? [[String:Any]]()
                    if let successCallback = successCallback {
                        successCallback(response)
                    }
                case .failure:
                    let error = response.error
                    if let errorCallback = errorCallback {
                        errorCallback(error)
                    }
            }
        }
    }
}
