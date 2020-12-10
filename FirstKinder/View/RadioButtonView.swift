//
//  RadioButtonView.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/10.
//
import UIKit

class RadioButtonView: UIView {
    var firstButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var secondButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var thirdButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var fourthButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var fifthButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var sixthButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawRadioButtons(firstButton, secondButton, thirdButton)
        addFunctionsForButtons()
        self.firstButton.tintColor = .red
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func drawRadioButtons(_ firstButton: UIButton, _ secondButton: UIButton, _ thirdButton: UIButton) {
        
        var stack: UIStackView?
        stack = UIStackView(arrangedSubviews: [firstButton, secondButton, thirdButton])
        
        addSubview(stack!)
        stack!.isUserInteractionEnabled = true
        stack!.translatesAutoresizingMaskIntoConstraints = false
        stack!.axis = .horizontal
        stack!.alignment = .center
        stack!.spacing = 10
        stack!.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    func setButtonTitles(firstTitle: String, secondTitle: String, thirdTitle: String) {
        self.firstButton.setTitle(firstTitle, for: .normal)
        self.secondButton.setTitle(secondTitle, for: .normal)
        self.thirdButton.setTitle(thirdTitle, for: .normal)
    }
    func addFunctionsForButtons() {
        self.firstButton.addTarget(self, action: #selector(fristButtonSelected), for: .touchUpInside)
        self.secondButton.addTarget(self, action: #selector(secondButtonSelected), for: .touchUpInside)
        self.thirdButton.addTarget(self, action: #selector(thirdButtonSelected), for: .touchUpInside)
    }
    @objc func fristButtonSelected() {
        self.firstButton.tintColor = .red
        self.secondButton.tintColor = .white
        self.thirdButton.tintColor = .white
    }
    @objc func secondButtonSelected() {
        self.firstButton.tintColor = .white
        self.secondButton.tintColor = .red
        self.thirdButton.tintColor = .white
    }
    @objc func thirdButtonSelected() {
        self.firstButton.tintColor = .white
        self.secondButton.tintColor = .white
        self.thirdButton.tintColor = .red
    }
}
