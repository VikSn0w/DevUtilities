//
//  Time_Complexity.swift
//  DevUtilities
//
//  Created by Vittorio Picone on 05/06/2020.
//  Copyright © 2020 Vittorio Picone. All rights reserved.
//

import UIKit

class Time_Complexity: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate
{
    var selection = 0
    var Complexities = ["O(n^2)", "O(n*log(n))", "O(n)", "O(nk)", "O(n+k)"]
    
    @IBOutlet weak var MinusResult: UILabel!
    @IBOutlet weak var PlusResult: UILabel!
    @IBOutlet weak var OriginalNumber: UITextField!
    @IBOutlet weak var OriginalTime: UITextField!
    @IBOutlet weak var numberElements: UITextField!
    @IBOutlet weak var Costant: UILabel!
    @IBOutlet weak var Result: UILabel!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return Complexities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return Complexities[row];
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selection = row
        var flag = false
        print("Selected : \(Complexities[row])");
        if(Complexities[row] == "O(nk)" || Complexities[row] == "O(n+k)")
        {
            flag = true
        }
        else
        {
            flag = false
        }
        Costant.isUserInteractionEnabled = flag
        print(flag)
    }
    
    @IBAction func Cleat(_ sender: Any)
    {
        OriginalNumber.text = ""
        OriginalTime.text   = ""
        numberElements.text = ""
        Costant.text        = ""
        Result.text         = ""
        MinusResult.text    = ""
        Costant.isUserInteractionEnabled = false
        PlusResult.text     = ""
    }
    
    @IBAction func Calculate(_ sender: Any)
    {
        var aux = 0.0
        var aux2 = 0.0
        var finalaux = 0.0
        
        aux  = Double(Double(numberElements.text!)!/Double(OriginalNumber.text!)!)
        
        switch (Complexities[selection])
        {
            case "O(n^2)":
                aux2     = aux*aux
                finalaux = aux2 * Double(Double(OriginalTime.text!)!)
            break;
                
            case "O(n*log(n))":
                aux2     = aux * log10(val: aux)
                finalaux = aux2 * Double(Double(OriginalTime.text!)!)
            break;
                
            case "O(n)":
                finalaux = aux * Double(Double(OriginalTime.text!)!)
            break;
                
            case "O(n+k)":
                if(Costant.text == "")
                {
                    let alert = UIAlertController(title: "ERROR", message: "The costant field is empty!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                else
                {
                    aux2     = aux + Double(Costant.text!)!
                    finalaux = aux2 * Double(Int(OriginalTime.text!)!)
                }
            break;
                
            case "O(nk)":
                if(Costant.text == "")
                {
                    let alert = UIAlertController(title: "ERROR", message: "The costant field is empty!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                else
                {
                    aux2     = aux * Double(Costant.text!)!
                    finalaux = aux2 * Double(Int(OriginalTime.text!)!)
                }
            break;
                
            default: break;
        }
        
        let Plus2percent  = finalaux + (finalaux*2)/100
        let Minus2percent = finalaux - (finalaux*2)/100
        PlusResult.text = String("\(String(Plus2percent))")
        
        Result.text = String("\(String(finalaux))")
        MinusResult.text = String("\(String(Minus2percent))")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        Costant.isUserInteractionEnabled = false
        self.hideskeyboard()
        OriginalNumber.text = ""
        OriginalTime.text   = ""
        numberElements.text = ""
        Costant.text        = ""
        Result.text         = ""
        
    }
    
    func log10(val: Double) -> Double{return (log(val)/log(10.0))}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
