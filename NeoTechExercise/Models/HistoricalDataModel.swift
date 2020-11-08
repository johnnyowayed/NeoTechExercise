//
//  HistoricalDataModel.swift
//  NeoTechExercise
//
//  Created by Johnny Owayed on 11/7/20.
//

import UIKit

struct HistoricalDataModel {
    var date:String = ""
    var dateJs:String = ""
    var smartWealthValue:Double = 0
    var benchmarkValue:Double = 0
    
    init(data: [String:Any]) {
        if let date = data["date"] as? String{
            self.date = date
        }
        if let dateJs = data["date_js"] as? String{
            self.dateJs = dateJs
        }
        if let smartWealthValue = data["smartWealthValue"] as? Double{
            self.smartWealthValue = smartWealthValue
        }
        if let benchmarkValue = data["benchmarkValue"] as? Double{
            self.benchmarkValue = benchmarkValue
        }
    }
}
