//
//  ViewController.swift
//  RunnerRunner
//
//  Created by Turgay Ceylan on 10.07.2022.
//

import UIKit
import Localize_Swift
import MapKit

class ViewController :  UIViewController, MKMapViewDelegate, UIApplicationDelegate{
    
    var runningViewModel = RunningViewModel()

    /* Swip Buttons */
    @IBOutlet weak var swipButton: UIButton!
    @IBOutlet weak var swipLabel: UILabel!
    @IBOutlet weak var swipeRightLabel: UILabel!
    
    /* Flags */
    @IBOutlet weak var flagEN: UIImageView!
    @IBOutlet weak var flagDE: UIImageView!
    @IBOutlet weak var flagTR: UIImageView!
    @IBOutlet weak var flagIT: UIImageView!
    @IBOutlet weak var flagES: UIImageView!
    @IBOutlet weak var flagFR: UIImageView!
    
    @IBOutlet weak var chooseLanguageLabel: UILabel!
    @IBOutlet weak var runningHistoryLabel: UILabel!
    
    /* Statics Labels */
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var kcalLabel: UILabel!
    @IBOutlet weak var meterLabel: UILabel!
    
    /* Views */
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    var manager : CLLocationManager?
    var firstLocation : CLLocation!
    var lastLocation : CLLocation!
    var flags : [String : UIImageView] = [:]
    var isRunningStarted : Bool = false
    var timerSeconds : Int = 0
    var timer : Timer?
    var kcal : Float = 0.00
    var distance : Float = 0.00

    override func viewDidLoad() {
        super.viewDidLoad()
        languageConfiguration()
        swipeConfiguration()
        managerConfiguration()
        mapViewConfiguration()
        runningViewModel.fetch()
        tableConfiguration()
    }

}

class LanguageTapGesture: UITapGestureRecognizer {
    private var lang = String()
    
    func setLanguage(_ code : String){
        self.lang = code
    }
    
    func getLanguage() -> String{
        return self.lang
    }
}

/* Location */
extension ViewController : CLLocationManagerDelegate {
    
    private func privacyCheck(){
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            manager?.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if isRunningStarted {
            if firstLocation == nil {
                firstLocation = locations.first
            }else if let location = locations.last {
                distance += Float(lastLocation.distance(from: location))
                
                meterLabel.text = String(format: "%.2f m", distance)
                
            }
            lastLocation = locations.last
        }
    }
    
    func managerConfiguration(){
        manager = CLLocationManager()
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        manager?.activityType = .fitness
        manager?.delegate = self
        manager?.distanceFilter = 5
        privacyCheck()
        manager?.startUpdatingLocation()
    }
}

/* Flag and Language */
extension ViewController {
    
    private func loadTexts(){
        swipeRightLabel.text = isRunningStarted ? "swipeText2".localized() : "swipeText".localized()
        chooseLanguageLabel.text = "chooseText".localized()
        runningHistoryLabel.text = "historyText".localized()
    }
    
    private func loadFlagsToDictionary(){
        flags["en"] = flagEN
        flags["de"] = flagDE
        flags["tr"] = flagTR
        flags["it"] = flagIT
        flags["es"] = flagES
        flags["fr"] = flagFR
    }
    
    @objc func changeLanguage(sender : LanguageTapGesture){
        Localize.setCurrentLanguage(sender.getLanguage())
        loadTexts()
    }
    
    private func languageConfiguration(){
        loadFlagsToDictionary()
        
        for flag in flags {
            flag.value.isUserInteractionEnabled = true
            let gestureRecognizer = LanguageTapGesture(target: self, action: #selector(changeLanguage(sender:)))
            gestureRecognizer.setLanguage(flag.key)
            flag.value.addGestureRecognizer(gestureRecognizer)
        }
        loadTexts()
    }
    
}
