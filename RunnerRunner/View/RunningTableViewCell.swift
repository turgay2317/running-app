//
//  RunningTableViewCell.swift
//  RunnerRunner
//
//  Created by Turgay Ceylan on 10.07.2022.
//

import UIKit

class RunningTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var kcalLabel: UILabel!
    @IBOutlet weak var meterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(time : String, kcal : String, meter : String){
        timeLabel.text = time
        kcalLabel.text = kcal
        meterLabel.text = meter
    }

}
