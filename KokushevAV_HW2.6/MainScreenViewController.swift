//
//  MainScreenViewController.swift
//  KokushevAV_HW2.6
//
//  Created by Александр Кокушев on 13.03.2020.
//  Copyright © 2020 Александр Кокушев. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsVC = segue.destination as! SettingsViewController
        settingsVC.delegate = self
        settingsVC.mainScreenColor = view.backgroundColor
    }
}

extension MainScreenViewController: SetBackgroundColor {
    func getColor(color: UIColor) {
        self.view.backgroundColor = color
    }
}
