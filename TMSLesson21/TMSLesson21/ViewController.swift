//
//  ViewController.swift
//  TMSLesson21
//
//  Created by Mac on 6.02.24.
//

import UIKit

class ViewController: UIViewController {
    
    private let label = UILabel()
    private let changeButton = UIButton()
    private let resetButton = UIButton()
    private let segmentedControl = UISegmentedControl(items: ["Color", "Style", "Font size"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabel()
        setupBlurBackground()
        setupButtons()
        setupSegmentedControl()
    }
    
    private func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Пример атрибутного текста"
        label.textColor = .cyan
        label.textAlignment = .center
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
        
    }
    
    private func setupButtons() {
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        changeButton.setTitle("Change", for: .normal)
        changeButton.setTitleColor(.systemBlue, for: .normal)
        changeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
        view.addSubview(changeButton)
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.systemRed, for: .normal)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        view.addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            changeButton.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: 120),
            changeButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            resetButton.centerXAnchor.constraint(equalTo: view.rightAnchor,constant:-120),
            resetButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40)
        ])
    }
    
    private func setupSegmentedControl() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        view.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -30),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupBlurBackground() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.alpha = 0.6
        view.addSubview(blurView)
        view.sendSubviewToBack(blurView)
        
        NSLayoutConstraint.activate([
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func changeButtonTapped() {
        let plainString = "Пример атрибутного текста"
        
        let attributedString = NSMutableAttributedString(string: plainString)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: 6))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: NSRange(location: 7, length: 12))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.yellow, range: NSRange(location: 19, length: 6))
        
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 20), range: NSRange(location: 0, length: 6))
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.italicSystemFont(ofSize: 16), range: NSRange(location: 7, length: 12))
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 14), range: NSRange(location: 19, length: 6))
        
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
        label.attributedText = attributedString
        
    }
    
    @objc func labelTapped(_ gesture: UITapGestureRecognizer) {
        print("Press text")
        
        let location = gesture.location(in: gesture.view)
        
        if let tappedCharacterIndex = getTappedCharacterIndex(at: location) {
            print("Pressed text \(tappedCharacterIndex)")
            UIApplication.shared.open(URL(string: "https://www.example.com")!, options: [:], completionHandler: nil)
        }
    }
    
    func getTappedCharacterIndex(at location: CGPoint) -> Int? {
        guard let attributedText = label.attributedText else {
            return nil
        }
        
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: label.bounds.size)
        let textStorage = NSTextStorage(attributedString: label.attributedText ?? NSAttributedString())
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        textContainer.size = label.bounds.size
        
        let characterIndex = layoutManager.characterIndex(for: location, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return characterIndex
    }
    
    @objc private func resetButtonTapped() {
        label.attributedText = NSAttributedString(string: "Пример атрибутного текста")
        label.textColor = .cyan
    }
    
    @objc private func segmentedControlValueChanged() {
        let selectedSegmentIndex = segmentedControl.selectedSegmentIndex
        
        switch selectedSegmentIndex {
        case 0:
            label.textColor = .red
        case 1:
            label.font = UIFont.boldSystemFont(ofSize: 20)
        case 2:
            label.font = UIFont.systemFont(ofSize: 16)
        default:
            break
        }
    }
    
    
}

