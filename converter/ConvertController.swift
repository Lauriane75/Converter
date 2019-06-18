//
//  ConvertController.swift
//  converter
//
//  Created by Lauriane Haydari on 12/06/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

class ConvertController: UIViewController {
// outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var entryView: UIView!
    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var resultView: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
// properties
    var type: String?
    var views: [UIView] = []
    var isReverse = false
    let euros = "€"
    let dollars = "$"
    let km = "km"
    let mi = "miles"
    let celsius = "°C"
    let fahrenheit = "°F"
    let format = "%.2f"
// overide func from UIViewController like viewDidLoad
    
// viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        if let choice = type {
            titleLabel.text = "Converter of : " + choice
            views.append(contentsOf: [resultView, entryView])
            smoothCorner()
            typeChoice(choice )
        } else {
            dismiss(animated: true, completion: nil)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyBoard() {
        view.endEditing(true)
    }
// functions
func typeChoice(_ choice: String) {
        switch choice {
        case CURRENCY: setUp(euros, dollars)
        case DISTANCE: setUp(km, mi)
        case TEMPERATURE: setUp(celsius, fahrenheit)
        default:
            break
        }
    }
    func setUp(_ primary: String, _ secondary: String) {
        if !isReverse {
            titleLabel.text = "Convert to " + primary + " in " + secondary
            toDoLabel.text = "Type your value of " + primary
        } else {
            titleLabel.text = "Convert to " + secondary + " in " + primary
            toDoLabel.text = "Type your value of " + secondary
        }
    }
    func smoothCorner() {
        for view in views {
            view.layer.cornerRadius = 10
        }
    }
// logique
    func calculate() {
        if let myType = type, let textTypped = dataTextField.text, let double = Double(textTypped) {
            switch myType {
            case CURRENCY:
                resultLabel.text = isReverse ? euro(double) : dollar(double)
            case DISTANCE:
                resultLabel.text = isReverse ? mile(double) : kilometer(double)
            case TEMPERATURE:
                resultLabel.text = isReverse ? celsiu(double) : fahrenheit(double)
            default:
                break
            }
        }
    }
    func dollar(_ euros: Double) -> String {
        return String(format: format, (euros / 0.81)) + " $"
    }
    func euro(_ dollars: Double) -> String {
        return String(format: format, (dollars * 0.81)) + " €"
    }
    func mile(_ kilometers: Double) -> String {
        return String(format: format, (kilometers * 0.621)) + " mi"
    }
    func kilometer(_ miles: Double) -> String {
        return String(format: format, (miles / 0.621)) + " km"
    }
    
    func celsiu(_ fahrenheits: Double) -> String {
        return String(format: format, (fahrenheits - 32) / 1.8 ) + " °C"
    }
    func fahrenheit(_ celsius: Double) -> String {
        return String(format: format, (celsius * 1.8) + 32 ) + " °F"
    }
    
    
// actions
    @IBAction func textChanged(_ sender: Any) {
        calculate()
    }
    @IBAction func changeButton(_ sender: UIButton) {
        guard type != nil else { return }
        isReverse = !isReverse
        typeChoice(type!)
        calculate()
    }
    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
