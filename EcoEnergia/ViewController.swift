//
//  ViewController.swift
//  EcoEnergia
//
//  Created by Rudson Lima on 08/11/15.
//  Copyright © 2015 Liveo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var potenciaTextField: UITextField!
    @IBOutlet weak var usoDiarioTextField: UITextField!
    @IBOutlet weak var diasMesLabel: UILabel!
    @IBOutlet weak var calculedButton: UIButton!
    @IBOutlet weak var consumoEletroPauloLabel: UILabel!
    @IBOutlet weak var consumoLightLabel: UILabel!
        
    @IBOutlet weak var custoEnergiaSegmentControl: UISegmentedControl!
    
    let precoKWhEletroPaulo: Double = 0.28 // R$ / KWh
    let precoKWhLight: Double = 0.39
    
    var dias = 0
    var minutos: Int = 0
    var potenciaEmWatts: Int = 0;
    
    @IBAction func sliderChanged(sender: UISlider) {
        let progresso = lroundf(sender.value)
        diasMesLabel.text = "\(progresso)"
        dias = progresso
    }
    
    @IBAction func toggleControl(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            consumoLightLabel.hidden = false
            consumoEletroPauloLabel.hidden = true
        }else{
            consumoLightLabel.hidden = true
            consumoEletroPauloLabel.hidden = false
        }
    }
    
    @IBAction func calculoConsumo(sender: UIButton) {
        // E = P.t
        // C = (Watts X Horas X Dias) / 1000
        
        let consumoDiarioEmKwh = Double(minutos)/60 * Double(potenciaEmWatts)/1000
        let consumoMensalKWh = consumoDiarioEmKwh * Double(dias)
        let valorAPagarEletroPaulo = consumoMensalKWh * precoKWhEletroPaulo
        let valorAPagarLight = consumoMensalKWh * precoKWhLight
        
        consumoLightLabel.text = "R$ \(NSString(format: "%.2f", valorAPagarLight))"
        consumoEletroPauloLabel.text = "R$ \(NSString(format: "%.2f", valorAPagarEletroPaulo))"
        consumoLightLabel.hidden = false
    }
    
    @IBAction func touchBackground() {
        potenciaTextField.resignFirstResponder()
        usoDiarioTextField.resignFirstResponder()
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        
        if textField.text!.isEmpty {
            return true
        }
        
        switch textField{
        
        case potenciaTextField:
            if let value = Int(potenciaTextField.text!) {
                if (value > 0){
                    potenciaEmWatts = value
                    return true
                }
            }
            
        case usoDiarioTextField:
            
            if let value = Int(usoDiarioTextField.text!) {
                if (value <= 60*24) && value > 0 {
                    minutos = value
                    return true
                }
             }
            
        default:
            break
        
        }
        
        return false
    }
    
    // Depois de digitar e teclar enter, o teclado irá desaparecer
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //O obj que usuário está interagindo atualmente
        textField.resignFirstResponder()
        return true
    }
    
    // Quando um dos campos de texto terminou a parte de edição
    func textFieldDidEndEditing(textField: UITextField) {
        calculedButton.enabled = !potenciaTextField.text!.isEmpty && !usoDiarioTextField.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        calculedButton.enabled = false
        consumoEletroPauloLabel.hidden = true
        consumoLightLabel.hidden = true
        diasMesLabel.text = "31"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

