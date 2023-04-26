//
//  TransactionTypeSwitch.swift
//  Expenses Tracker
//
//  Created by Adrian Vîslă on 23.04.2023.
//

import UIKit

class TransactionTypeSwitch: UIControl {
    let leftButton = UIButton()
    let rightButton = UIButton()
    var selectedSide: Int = 0 {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        print("called setupUI")
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.backgroundColor = .red
        leftButton.setTitle("Expense", for: .normal)
        leftButton.setTitleColor(.label, for: .normal)
        leftButton.isEnabled = false
        addSubview(leftButton)
        
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.backgroundColor = .green
        rightButton.setTitle("Income", for: .normal)
        rightButton.setTitleColor(.label, for: .normal)
        addSubview(rightButton)
        
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftButton.topAnchor.constraint(equalTo: topAnchor),
            leftButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            leftButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightButton.topAnchor.constraint(equalTo: topAnchor),
            rightButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            rightButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        ])
        
        selectedSide = 0
        self.isUserInteractionEnabled = true
    }
    
    private func updateUI() {
        UIView.animate(withDuration: 0.1, animations: {
            self.leftButton.alpha = self.selectedSide == 0 ? 1 : 0.2
            self.rightButton.alpha = self.selectedSide == 1 ? 1 : 0.2
        })
    }
    
    @objc private func leftButtonTapped() {
        selectedSide = 0
        leftButton.isEnabled = false
        rightButton.isEnabled = true
        print("Changed to 0")
    }
    
    @objc private func rightButtonTapped() {
        selectedSide = 1
        rightButton.isEnabled = false
        leftButton.isEnabled = true
        print("Changed to 1")
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        
        if leftButton.point(inside: touch.location(in: leftButton), with: event) {
            UIView.animate(withDuration: 0.1, animations: {
                self.leftButton.alpha = 0.7
            })
        }
        
        if rightButton.point(inside: touch.location(in: rightButton), with: event) {
           UIView.animate(withDuration: 0.1, animations: {
               self.rightButton.alpha = 0.7
           })
        }
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        UIView.animate(withDuration: 0.1, animations: {
            self.leftButton.alpha = self.selectedSide == 0 ? 1 : 0.2
            self.rightButton.alpha = self.selectedSide == 1 ? 1 : 0.2
        })
    }
}
