//
//  ViewController.swift
//  converter
//
//  Created by Lauriane Haydari on 12/06/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

let CURRENCY = "Currency"
let TEMPERATURE = "Temperature"
let DISTANCE =  "Distance"

class ViewController: UIViewController {

    @IBOutlet weak var currencyView: UIView!
    @IBOutlet weak var distanceView: UIView!
    @IBOutlet weak var temperatureView: UIView!
    
    let segueID = "Convert"
    var views: [UIView] = []
    
    // outlets are always creating from viewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
        views = [currencyView,distanceView,temperatureView]
        smoothCorner()
        // Do any additional setup after loading the view.
    }
    func smoothCorner() {
        for view in views {
            view.layer.cornerRadius = 10
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID {
            if let convertController = segue.destination as? ConvertController {
                    convertController.type = sender as? String
            }
        }
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        switch sender.tag {
        case 1: performSegue(withIdentifier: segueID, sender: CURRENCY)
        case 2: performSegue(withIdentifier: segueID, sender: DISTANCE)
        case 3: performSegue(withIdentifier: segueID, sender: TEMPERATURE)
        default:
            break
        }
    }
   


}

