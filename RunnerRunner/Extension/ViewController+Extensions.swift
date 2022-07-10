//
//  ViewController+Extensions.swift
//  RunnerRunner
//
//  Created by Turgay Ceylan on 10.07.2022.
//

import Foundation
import UIKit

/* UI */
extension ViewController {
    
    func swipeConfiguration(){
        let swipRecognizer = UIPanGestureRecognizer(target: self, action: #selector(swiped(sender:)))
        swipButton.addGestureRecognizer(swipRecognizer)
    }
    
    func startRun(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tickTimer), userInfo: nil, repeats: true)
        manager?.startUpdatingLocation()
    }
    
    func stopRun(){
        timer?.invalidate()
        let last = Running()
        last.kcal = kcal
        last.distance = distance
        last.seconds = timerSeconds
        runningViewModel.save(running: last)
        tableView.reloadData()
        reset()
    }
    
    func reset(){
        timeLabel.text = "00:00:00"
        kcalLabel.text = "0 kcal"
        meterLabel.text = "0 m"
    }
    
    @objc func tickTimer(){
        timerSeconds += 1
        timeLabel.text = timerSeconds.convertTimerData()
        kcal += Float.random(in: 0.13...0.20)
        kcalLabel.text = String(format: "%.2f kcal",kcal)
    }
    
    @objc func swiped(sender : UIPanGestureRecognizer){
        let referenceX = swipButton.center.x
        
        if let sliderView = sender.view {
                        
            if sender.state == .began || sender.state == .changed {
                
                let translation = sender.translation(in: self.view)
                
                swipButton.center.x = translation.x
                
            }else if sender.state == .ended {
                if isRunningStarted {
                    sliderView.tintColor = .none
                    swipButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                    swipLabel.text = "swipeText".localized()
                    stopRun()
                }else{
                    sliderView.tintColor = .purple
                    swipButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                    swipLabel.text = "swipeText2".localized()
                    startRun()
                }
                isRunningStarted = !isRunningStarted
                sliderView.center.x = referenceX
            }
        }
    }
}

/* Table View */
extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? RunningTableViewCell
        let res = runningViewModel.getResults()?[indexPath.row]
        cell?.setCell(
            time: (res?.seconds.convertTimerData())!,
            kcal: String(format: "%.2f m", res?.distance ?? 0),
            meter: String(format: "%.2f kcal",res?.kcal ?? 0)
        )
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return runningViewModel.getResults()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let row = runningViewModel.getResults()?[indexPath.row] {
                runningViewModel.delete(running: row)
                tableView.reloadData()
            }
        }
    }
    
    func tableConfiguration(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func mapViewConfiguration(){
        mapView.userTrackingMode = .follow
        mapView.showsUserLocation = true
    }
    
}


