//
//  Running.swift
//  RunnerRunner
//
//  Created by Turgay Ceylan on 10.07.2022.
//

import Foundation
import RealmSwift

class Running : Object {
    /* distance meter */
    @objc dynamic var distance : Float = 0.00
    /* calories kcal */
    @objc dynamic var kcal : Float = 0.00
    /* time seconds */
    @objc dynamic var seconds : Int = 0
    
    override init(){
        super.init()
    }
}
