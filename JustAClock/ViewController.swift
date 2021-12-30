//
//  ViewController.swift
//  JustAClock
//
//  Created by Jay Lee on 2021/12/30.
//

import UIKit

class ViewController: UIViewController {
    private lazy var timer = Timer.scheduledTimer(
        timeInterval: 1.0,
        target: self,
        selector: #selector(updateTime),
        userInfo: nil,
        repeats: true
    )
    private let calendar = Calendar.current

    @IBOutlet private var timeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateTime()
        RunLoop.current.add(timer, forMode: .common)
    }

    @objc
    func updateTime() {
        let date = Date()
        let components = calendar.dateComponents([.hour, .minute, .second], from: date)
        timeLabel.text = String(
            format: "%02d:%02d:%02d",
            components.hour!,
            components.minute!,
            components.second!
        )
    }
}
