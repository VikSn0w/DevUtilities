//
//  ConversionsController.swift
//  DevUtilities
//
//  Created by Vittorio Picone on 21/06/2020.
//  Copyright © 2020 Vittorio Picone. All rights reserved.
//

import UIKit

class ConversionsController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate
{
    var selection = 0

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var decOUT: UILabel!
    @IBOutlet weak var hexOUT: UILabel!
    @IBOutlet weak var octOUT: UILabel!
    @IBOutlet weak var binOCT: UILabel!
    
    var Operations = ["DEC", "HEX", "OCT", "BIN"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Operations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return Operations[row];
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selection = row
        
        if(Operations[row] == "DEC")
        {
            textField.attributedPlaceholder = NSAttributedString(string:"Enter Decimal", attributes: nil)
        }
        else if(Operations[row] == "HEX")
        {
            textField.attributedPlaceholder = NSAttributedString(string:"Enter Hexadecimal", attributes: nil)
        }
        else if(Operations[row] == "OCT")
        {
            textField.attributedPlaceholder = NSAttributedString(string:"Enter Octal", attributes: nil)
        }
        else if(Operations[row] == "BIN")
        {
            textField.attributedPlaceholder = NSAttributedString(string:"Enter Binary", attributes: nil)
        }
    }
    
    @IBAction func Calculate(_ sender: Any)
    {
        var binary = ""
        var decimal = ""
        var HEX = ""
        var OCT = ""
        
        var decimalL = 0
        
        if(Operations[selection] == "DEC")
        {
            decimal = textField.text!

            var i = 0
            let size = decimal.count
            var ERROR = 0
            
            while(i < size)
            {
                if(decimal[i] != "0" || decimal[i] != "1" || decimal[i] != "2" || decimal[i] != "3" || decimal[i] != "4" || decimal[i] != "5" || decimal[i] != "6" || decimal[i] != "7" || decimal[i] != "8" || decimal[i] != "9")
                {
                    ERROR = 1
                }
                i+=1
            }
            
            if(ERROR == 1)
            {
                print("error")
                decimal = "ERROR"
                binary = "ERROR"
                OCT = "ERROR"
                HEX = "ERROR"
                let alert = UIAlertController(title: "ERROR", message: "ERROR IN THE TEXT FIELD!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            if(ERROR == 0)
            {
                binary = String(Int(decimal)!, radix: 2)
                HEX = String(Int(decimal)!, radix: 16)
                OCT = String(Int(decimal)!, radix: 8)
            }
        }

        if(Operations[selection] == "HEX")
        {
            HEX = textField.text!
            let size = HEX.count
            var ERROR = false
            
            var i = 0
            
            while(i < size)
            {
                if(HEX[i] != "0" || HEX[i] != "1" || HEX[i] != "2" || HEX[i] != "3" || HEX[i] != "4" || HEX[i] != "5" || HEX[i] != "6" || HEX[i] != "7" || HEX[i] != "8" || HEX[i] != "9" || HEX[i] != "A" || HEX[i] != "B" || HEX[i] != "C" || HEX[i] != "D" || HEX[i] != "E" || HEX[i] != "F")
                {
                    ERROR = true
                }
                i+=1
            }
            if(ERROR == true)
            {
                decimal = "ERROR"
                binary = "ERROR"
                OCT = "ERROR"
                HEX = "ERROR"
                let alert = UIAlertController(title: "ERROR", message: "ERROR IN THE TEXT FIELD!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            else
            {
                decimalL = Int(HEX, radix: 16)!
                decimal = String(decimalL)
                binary = String(Int(decimal)!, radix: 2)
                OCT = String(Int(decimal)!, radix: 8)
            }
        }
        
        if(Operations[selection] == "OCT")
        {
            OCT = textField.text!
            
            var i = 0
            let size = OCT.count
            var ERROR = false
            
            while(i < size)
            {
                if(OCT[i] != "0" || OCT[i] != "1" || OCT[i] != "2" || OCT[i] != "3" || OCT[i] != "4" || OCT[i] != "5" || OCT[i] != "6" || OCT[i] != "7")
                {
                    ERROR = true
                }
                i+=1
            }
            if(ERROR == true)
            {
                decimal = "ERROR"
                binary = "ERROR"
                OCT = "ERROR"
                HEX = "ERROR"
                let alert = UIAlertController(title: "ERROR", message: "ERROR IN THE TEXT FIELD!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            else
            {
                decimalL = Int(OCT, radix: 8)!
                decimal = String(decimalL)
                binary = String(Int(decimal)!, radix: 2)
                HEX = String(Int(decimal)!, radix: 16)
            }
        }
        
        if(Operations[selection] == "BIN")
        {
            binary = textField.text!
            
            var i = 0
            let size = binary.count
            var ERROR = false
            
            while(i < size)
            {
                if(binary[i] != "0" || binary[i] != "1")
                {
                    ERROR = true
                }
                i+=1
            }
            if(ERROR == true)
            {
                decimal = "ERROR"
                binary = "ERROR"
                OCT = "ERROR"
                HEX = "ERROR"
                let alert = UIAlertController(title: "ERROR", message: "ERROR IN THE TEXT FIELD!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            else
            {
                decimalL = Int(binary, radix: 2)!
                decimal = String(decimalL)
                OCT = String(Int(decimal)!, radix: 8)
                HEX = String(Int(decimal)!, radix: 16)
            }
        }
        
        print("dec: \(decimal)\nhex: \(HEX)\noct: \(OCT)\nbin: \(binary)\n")
        
        decOUT.text = decimal
        hexOUT.text = HEX
        octOUT.text = OCT
        binOCT.text = binary
    }
    
    @IBAction func ClearButton(_ sender: Any)
    {
        textField.text = ""
        decOUT.text    = ""
        hexOUT.text    = ""
        octOUT.text    = ""
        binOCT.text    = ""
    }
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.hideskeyboard()
        textField.text = ""
        textField.text = ""
        decOUT.text    = ""
        hexOUT.text    = ""
        octOUT.text    = ""
        binOCT.text    = ""
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension Int
{
    fileprivate func createString(radix: Int) -> String
    {
        let final = String(self, radix: radix, uppercase: true)
        return final
    }
    
    func decToBinString() -> String
    {
        let result = createString(radix: 2)
        return result
    }
        //10 -> 8
    func decToOctString() -> String
    {
        let result = createString(radix: 8)
        return result
    }

        //10 -> 16
    func decToHexString() -> String
    {
        let result = createString(radix: 16)
        return result
    }
}
extension String
{
    subscript(i: Int) -> String
    {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
