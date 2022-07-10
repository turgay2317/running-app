//
//  RunningViewModel.swift
//  RunnerRunner
//
//  Created by Turgay Ceylan on 10.07.2022.
//

import Foundation
import RealmSwift

class RunningViewModel {
    
    private var realm : Realm?
    private var results : Results<Running>?
    
    init(){
        do{
            realm = try Realm()
            print("Connection OK")
        }catch{
            print("Connection error")
        }
    }
    
    func save(running : Running){
        if realm != nil {
            do{
                try realm!.write({
                    realm!.add(running)
                    print("Running added")
                })
            }catch{
                print("Running added error!")
            }
        }
    }
    
    func fetch(){
        if realm != nil {
            do{
                try realm!.write({
                    results = realm?.objects(Running.self)
                })
            }catch{
                print("Running select error!")
            }
        }
    }
    
    func delete(running : Running){
        if realm != nil {
            do {
                try realm?.write({
                    realm?.delete(running)
                })
            }catch{
                print("Delete error")
            }
        }
    }
    
    func getResults() -> Results<Running>? {
        return self.results
    }
    
}
