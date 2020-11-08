//
//  OptionModel.swift
//  NeoTechExercise
//
//  Created by Johnny Owayed on 11/7/20.
//

import UIKit

struct OptionModel {
    var id:String = ""
    var name:String = ""
    var description:String = ""
    var riskScore:Double = 0
    
    init(data: [String:Any]) {
        if let id = data["id"] as? String{
            self.id = id
        }
        if let name = data["name"] as? String{
            self.name = name
        }
        if let description = data["short_description"] as? String{
            self.description = description
        }
        if let riskScore = data["risk_score"] as? Double{
            self.riskScore = riskScore
        }
    }
}
