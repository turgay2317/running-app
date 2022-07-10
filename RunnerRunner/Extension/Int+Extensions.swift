//
//  Int+Extensions.swift
//  RunnerRunner
//
//  Created by Turgay Ceylan on 10.07.2022.
//

import Foundation

extension Int {
    func convertTimerData() -> String{
        let hour = self / 3600
        let minutes = (self - hour * 3600) / 60
        let seconds = self - hour * 3600 - minutes * 60
        
        return String(format: "%02d:%02d:%02d", hour, minutes, seconds)
        
    }
}
