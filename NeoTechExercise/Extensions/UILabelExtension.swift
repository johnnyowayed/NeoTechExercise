//
//  UILabelExtension.swift
//  NeoTechExercise
//
//  Created by Johnny Owayed on 11/7/20.
//

import UIKit

extension UILabel {
    func applyRegularFont(ofSize size:CGFloat = 14) {
        self.font = UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    func applySemiBoldFont(ofSize size:CGFloat = 14) {
        self.font = UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    
    func applyBoldFont(ofSize size:CGFloat = 14) {
        self.font = UIFont.systemFont(ofSize: size, weight: .bold)
    }
}
