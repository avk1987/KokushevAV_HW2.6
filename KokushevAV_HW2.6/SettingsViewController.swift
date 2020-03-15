//
//  SettingsViewController.swift
//  KokushevAV_HW2.6
//
//  Created by Александр Кокушев on 12.03.2020.
//  Copyright © 2020 Александр Кокушев. All rights reserved.
//

import UIKit

protocol SetBackgroundColor {
    func getColor(color: UIColor)
}
class SettingsViewController: UIViewController {

    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    @IBOutlet var redValue: UILabel!
    @IBOutlet var greenValue: UILabel!
    @IBOutlet var blueValue: UILabel!
    
    @IBOutlet var colorView: UIView!
    
    var delegate: SetBackgroundColor!
    var mainScreenColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        blueSlider.tintColor = .blue
        
        createButtonOnKeyboard()
        updateValues(source: .startup)
        updateColor()
        
    }
    
    @IBAction func sliderBeenMoved() {
        // можно было создать для слайдера свой case, но в его обработке нет спецефических действий как у ввода с клаваиатуры или захвата цвета с пред. экрана. Сделал просто nil
        updateValues(source: nil)
        updateColor()
    }
    
    @IBAction func DoneButtonPressed() {
        delegate.getColor(color: colorView.backgroundColor!)
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: Private methods
extension SettingsViewController {
   
    private enum Source {
        case startup
        case textfield
    }
    
    private func createButtonOnKeyboard() {
        
        let bar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                         action: #selector(doneFromKeyboardPressed))
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                       target: nil,
                                       action: nil)
        
        bar.setItems([flexible, doneButton], animated: false)
        bar.sizeToFit()
        
        self.redTextField.inputAccessoryView = bar
        self.greenTextField.inputAccessoryView = bar
        self.blueTextField.inputAccessoryView = bar
    }
    
    @objc private func doneFromKeyboardPressed() {
        
        updateValues(source: .textfield)
        updateColor()
        view.endEditing(true)
    }
    
    private func updateValues(source: Source?) {
       
        //Есои задали цвет с клаиватуры то требуется проверить и заполнить введенные данные
        if source == .textfield {
            //если будут введены ошибочные значения, например только точки то ничего не произойдет
            guard var redVal = Float(redTextField.text ?? "0") else { return }
            guard var greenVal = Float(greenTextField.text ?? "0") else { return }
            guard var blueVal = Float(blueTextField.text ?? "0") else { return }
            
            redVal = redVal > 1 ? 1.00 : redVal
            redVal = redVal < 0 ? 0.00 : redVal
            greenVal = greenVal > 1 ? 1.00 : greenVal
            greenVal = greenVal < 0 ? 0.00 : greenVal
            blueVal = blueVal > 1 ? 1.00 : blueVal
            blueVal = blueVal < 0 ? 0.00 : blueVal
            
            redSlider.value = redVal
            greenSlider.value = greenVal
            blueSlider.value = blueVal
            
        } else if source == .startup {
            //если цвет пришел с другого экрана то проверять его не надо, надо разобрать его на rdg и применить к слайдерам
            let ciColor = CIColor(color: mainScreenColor)
            redSlider.value = Float(ciColor.red)
            greenSlider.value = Float(ciColor.green)
            blueSlider.value = Float(ciColor.blue)
            
        }
       
        // а это надо делать в любом случае
        redValue.text = String(format: "%.2f", redSlider.value)
        redTextField.text = redValue.text
        
        greenValue.text = String(format: "%.2f", greenSlider.value)
        greenTextField.text = greenValue.text
        
        blueValue.text = String(format: "%.2f", blueSlider.value)
        blueTextField.text = blueValue.text
        
    }
    
   private func updateColor() {
        
        let alphaDefault = CGFloat(1.0)
        
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: alphaDefault)
    }

}
