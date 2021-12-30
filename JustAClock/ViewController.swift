//
//  ViewController.swift
//  JustAClock
//
//  Created by Jay Lee on 2021/12/30.
//

import UIKit

enum Theme: Int, CaseIterable {
    case light
    case dark

    mutating func update() {
        self = .init(rawValue: (rawValue + 1) % Self.allCases.count)!
    }
}

class ViewController: UIViewController {
    private lazy var timer = Timer.scheduledTimer(
        timeInterval: 1.0,
        target: self,
        selector: #selector(updateTime),
        userInfo: nil,
        repeats: true
    )

    private let calendar = Calendar.current

    private var theme = Theme.light {
        didSet {
            switch theme {
            case .light:
                view.backgroundColor = .white
                timeLabel.textColor = .black

            case .dark:
                view.backgroundColor = .black
                timeLabel.textColor = .white
            }
        }
    }

    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var tapGestureRecognizer: UITapGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateTime()
        RunLoop.current.add(timer, forMode: .common)
        tapGestureRecognizer.addTarget(self, action: #selector(updateTheme))
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

    @objc
    func updateTheme() {
        theme.update()
    }
}
