//
//  SettingsViewController.swift
//  KokushevAV_HW2.6
//
//  Created by Александр Кокушев on 12.03.2020.
//  Copyright © 2020 Александр Кокушев. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redValue: UILabel!
    @IBOutlet var greenValue: UILabel!
    @IBOutlet var blueValue: UILabel!
    
    @IBOutlet var colorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        blueSlider.tintColor = .blue
    }

    @IBAction func sliderBeenMoved(_ sender: UISlider) {

        switch sender {
        case redSlider:
            redValue.text = String(format: "%.2f", sender.value)
        case greenSlider:
            greenValue.text = String(format: "%.2f", sender.value)
        case blueSlider:
            blueValue.text = String(format: "%.2f", sender.value)
        default:
            break
        }
        
        updateColor()
        
    }
}

// MARK: Change color in view
extension SettingsViewController {
    
   private func updateColor() {
        
        let alphaDefault = CGFloat(1.0)
        
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: alphaDefault)
    }
}
