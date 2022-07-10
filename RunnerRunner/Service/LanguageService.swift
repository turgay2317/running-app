//
//  LanguageService.swift
//  RunnerRunner
//
//  Created by Turgay Ceylan on 10.07.2022.
//

import Foundation
import UIKit
import Localize_Swift

class LanguageService{
    
    var flags : [String:UIImageView] = [:]
    
    init(){
    }
    
    func addFlag(key : String, flag : UIImageView){
         flags[key] = flag
    }
    
    func configuration(){
        for flag in flags {
            flag.value.isUserInteractionEnabled = true
            let gestureRecognizer = LanguageTapGesture(target: self, action: #selector(change(sender:)))
            gestureRecognizer.setLanguage(flag.key)
            flag.value.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    func getStrings(_ going : Bool) -> [String]{
        var strings : [String] = []
        strings.append(going == true ? "swipeText2".localized() : "swipeText".localized())
        strings.append("chooseText".localized())
        strings.append("historyText".localized())
        return strings
    }
    
    @objc func change(sender : LanguageTapGesture){
        Localize.setCurrentLanguage(sender.getLanguage())
    }
    
    
    
}
