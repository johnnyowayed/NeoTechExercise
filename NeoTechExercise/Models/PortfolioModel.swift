//
//  PortfolioModel.swift
//  NeoTechExercise
//
//  Created by Johnny Owayed on 11/7/20.
//

import Foundation

struct PortfolioModel {
    var id:String = ""
    var name:String = ""
    var balance:Double = 0
    var totalEarnings:Double = 0
    var latestDailyEarnings:Double = 0
    var modifiedRiskScore:Double = 0
    var investmentType:String = ""
    var createdAt:String = ""
    
    init(data: [String:Any]? = nil) {
        if let id = data?["id"] as? String{
            self.id = id
        }
        if let name = data?["name"] as? String{
            self.name = name
        }
        if let balance = data?["balance"] as? Double{
            self.balance = balance
        }
        if let totalEarnings = data?["total_earnings"] as? Double{
            self.totalEarnings = totalEarnings
        }
        if let latestDailyEarnings = data?["latest_daily_earning"] as? Double{
            self.latestDailyEarnings = latestDailyEarnings
        }
        if let modifiedRiskScore = data?["modified_risk_score"] as? Double{
            self.modifiedRiskScore = modifiedRiskScore
        }
        if let investmentType = data?["investment_type"] as? String{
            self.investmentType = investmentType
        }
        if let createdAt = data?["created_at"] as? String{
            self.createdAt = createdAt
        }
    }
}
