//
//  ColorConversionsViewController.swift
//  DevUtilities
//
//  Created by Vittorio Picone on 21/06/2020.
//  Copyright © 2020 Vittorio Picone. All rights reserved.
//

import UIKit
import Foundation


class ColorConversionsViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var leftField: UITextField!
    @IBOutlet weak var centerField: UITextField!
    @IBOutlet weak var rightField: UITextField!
    
    @IBOutlet weak var colorSquare: UILabel!
    
    @IBOutlet weak var outRGB: UILabel!
    @IBOutlet weak var outHEX: UILabel!
    @IBOutlet weak var outHSV: UILabel!
    @IBOutlet weak var outHSL: UILabel!
    
    var selection = 0
    
    var Operations = ["RGB", "HEX", "HSV", "HSL"]
    
    struct hsv
    {
        var hue = 0.0;
        var saturation = 0.0;
        var value = 0.0;
    }
    
    struct hsl
    {
        var hue = 0.0;
        var saturation = 0.0;
        var lightness = 0.0;
    }
    
    struct rgb
    {
        var red   = 0
        var green = 0
        var blue  = 0
    }
    
    struct hex
    {
        var red   = ""
        var green = ""
        var blue  = ""
        var full  = ""
    }
    
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
        
        if(Operations[row] == "HEX")
        {
            leftField.isUserInteractionEnabled = false
            rightField.isUserInteractionEnabled = false
            
            centerField.attributedPlaceholder = NSAttributedString(string:"Enter HEX", attributes: nil)
            leftField.attributedPlaceholder = NSAttributedString(string:"Disabled", attributes: nil)
            rightField.attributedPlaceholder = NSAttributedString(string:"Disbled", attributes: nil)
        }
        else if(Operations[row] == "RGB")
        {
            leftField.isUserInteractionEnabled = true
            rightField.isUserInteractionEnabled = true
            
            centerField.attributedPlaceholder = NSAttributedString(string:"Enter GREEN", attributes: nil)
            leftField.attributedPlaceholder = NSAttributedString(string:"Enter RED", attributes: nil)
            rightField.attributedPlaceholder = NSAttributedString(string:"Enter BLUE", attributes: nil)
        }
        else if(Operations[row] == "HSL")
        {
            leftField.isUserInteractionEnabled = true
            rightField.isUserInteractionEnabled = true
            
            centerField.attributedPlaceholder = NSAttributedString(string:"Enter Sat.", attributes: nil)
            leftField.attributedPlaceholder = NSAttributedString(string:"Enter HUE", attributes: nil)
            rightField.attributedPlaceholder = NSAttributedString(string:"Enter Lit.", attributes: nil)
        }
        else if(Operations[row] == "HSV")
        {
            leftField.isUserInteractionEnabled = true
            rightField.isUserInteractionEnabled = true
            
            centerField.attributedPlaceholder = NSAttributedString(string:"Enter Sat.", attributes: nil)
            leftField.attributedPlaceholder = NSAttributedString(string:"Enter HUE", attributes: nil)
            rightField.attributedPlaceholder = NSAttributedString(string:"Enter Val.", attributes: nil)
        }
    }
    @IBAction func CalculateButton(_ sender: Any)
    {
        var hexStrc = hex()
        
        var HEX = ""
        
        var RGB = rgb()
        var HSV = hsv()
        var HSL = hsl()
        
        var ERROR_TOTAL = false
        
        if(Operations[selection] == "HEX")
        {
            HEX = centerField.text!
            let ArrayHEX = Array(HEX)
            
            let redHEX   = "\(ArrayHEX[0])\(ArrayHEX[1])"
            let greenHEX = "\(ArrayHEX[2])\(ArrayHEX[3])"
            let blueHEX  = "\(ArrayHEX[4])\(ArrayHEX[5])"
            
            var i = 0
            
            var ERROR = false
            
            while(i < HEX.count)
            {
                if(HEX[i] != "0" && HEX[i] != "1" && HEX[i] != "2" && HEX[i] != "3" && HEX[i] != "4" && HEX[i] != "5" && HEX[i] != "6" && HEX[i] != "7" && HEX[i] != "8" && HEX[i] != "9" && HEX[i] != "A" && HEX[i] != "B" && HEX[i] != "C" && HEX[i] != "D" && HEX[i] != "E" && HEX[i] != "F")
                {
                    ERROR = true
                }
                i+=1
            }
            if(ERROR == true)
            {
                ERROR_TOTAL = true
            }
            else
            {
            
                RGB.red   = Int(redHEX, radix: 16)!
                RGB.green = Int(greenHEX, radix: 16)!
                RGB.blue  = Int(blueHEX, radix: 16)!
                
                /*-------------------HEX-------------------*/
                
                HEX = "#"+HEX
                /*-------------------HSV-------------------*/
                let Rp = (Double(RGB.red)/255.0)
                let Gp = (Double(RGB.green)/255.0)
                let Bp = (Double(RGB.blue)/255.0)
                
                let Arrayed = [Rp, Gp, Bp]
                
                let Cmax = Arrayed.max()!
                let Cmin = Arrayed.min()!
                
                let Delta = Cmax - Cmin
                
                //Hue
                     if(Delta == 0){HSV.hue = 0}
                else if(Cmax == Rp)
                     {
                        HSV.hue = 60 * (((Gp-Bp)/Delta).truncatingRemainder(dividingBy: 6))
                     }
                else if(Cmax == Gp)
                     {
                        HSV.hue = 60 * (((Bp-Rp)/Delta)+2)
                     }
                else if(Cmax == Bp)
                     {
                        HSV.hue = 60 * (((Rp-Gp)/Delta)+4)
                     }
                print(Cmax)
                
                //Saturation
                if(Cmax == 0) {HSV.saturation = 0}
                if(Cmax != 0) {HSV.saturation = Delta/Cmax}
                
                //Value
                HSV.value = Cmax
                
                /*-------------------HSL-------------------*/
                HSL.hue = HSV.hue
                
                HSL.lightness = ((Cmax + Cmin)/2)
                
                if(Delta == 0) {HSL.saturation = 0}
                if(Delta != 0) {HSL.saturation = 1-abs(2*HSL.lightness-1)}
            }
        }
            
        else if(Operations[selection] == "RGB")
        {
            let RGB_STRING = leftField.text! + centerField.text! + rightField.text!
            
            var i = 0
            
            var ERROR = false
            
            while(i < RGB_STRING.count)
            {
                if
                (
                    RGB_STRING[i] != "0" && RGB_STRING[i] != "1" && RGB_STRING[i] != "2" && RGB_STRING[i] != "3" && RGB_STRING[i] != "4" && RGB_STRING[i] != "5" && RGB_STRING[i] != "6" && RGB_STRING[i] != "7" && RGB_STRING[i] != "8" && RGB_STRING[i] != "9"
                )
                {
                    ERROR = true
                }
                i+=1
            }
            if(ERROR == true)
            {
                ERROR_TOTAL = true
            }
            else
            {
                RGB.red = Int(leftField.text!)!
                RGB.green = Int(centerField.text!)!
                RGB.blue = Int(rightField.text!)!
                
                /*-------------------HEX-------------------*/
                
                hexStrc.red = String(format:"%02X", Int(RGB.red))
                hexStrc.green = String(format:"%02X", Int(RGB.green))
                hexStrc.blue = String(format:"%02X", Int(RGB.blue))
                
                hexStrc.full = hexStrc.red + hexStrc.green + hexStrc.blue
                
                HEX = "#" + hexStrc.full
                /*-------------------HSV-------------------*/
                let Rp = (Double(RGB.red)/255.0)
                let Gp = (Double(RGB.green)/255.0)
                let Bp = (Double(RGB.blue)/255.0)
                
                let Arrayed = [Rp, Gp, Bp]
                
                let Cmax = Arrayed.max()!
                let Cmin = Arrayed.min()!
                
                let Delta = Cmax - Cmin
                
                //Hue
                     if(Delta == 0){HSV.hue = 0}
                else if(Cmax == Rp)
                     {
                        HSV.hue = 60 * (((Gp-Bp)/Delta).truncatingRemainder(dividingBy: 6))
                     }
                else if(Cmax == Gp)
                     {
                        HSV.hue = 60 * (((Bp-Rp)/Delta)+2)
                     }
                else if(Cmax == Bp)
                     {
                        HSV.hue = 60 * (((Rp-Gp)/Delta)+4)
                     }
                print(Cmax)
                
                //Saturation
                if(Cmax == 0) {HSV.saturation = 0}
                if(Cmax != 0) {HSV.saturation = Delta/Cmax}
                
                //Value
                HSV.value = Cmax
                
                /*-------------------HSL-------------------*/
                HSL.hue = HSV.hue
                
                HSL.lightness = ((Cmax + Cmin)/2)
                
                if(Delta == 0) {HSL.saturation = 0}
                if(Delta != 0) {HSL.saturation = 1-abs(2*HSL.lightness-1)}
            }
        }
        else if(Operations[selection] == "HSL")
        {
            let HSL_STRING = leftField.text! + centerField.text! + rightField.text!
            
            var i = 0
            
            var ERROR = false
            
            while(i < HSL_STRING.count)
            {
                if
                (
                    HSL_STRING[i] != "0" && HSL_STRING[i] != "1" && HSL_STRING[i] != "2" && HSL_STRING[i] != "3" && HSL_STRING[i] != "4" && HSL_STRING[i] != "5" && HSL_STRING[i] != "6" && HSL_STRING[i] != "7" && HSL_STRING[i] != "8" && HSL_STRING[i] != "9" && HSL_STRING[i] != "."
                )
                {
                    ERROR = true
                }
                i+=1
            }
            if(ERROR == true)
            {
                ERROR_TOTAL = true
            }
            else
            {
                HSL.hue = Double(leftField.text!)!
                HSL.saturation = Double(centerField.text!)!/100
                HSL.lightness = Double(rightField.text!)!/100
                
                let C = (1-abs(2*HSL.lightness-1)) * HSL.saturation
                
                let X = C * (1 - abs((HSL.hue/60).truncatingRemainder(dividingBy: 2)-1))
                
                let m = HSL.lightness - C/2
                
                var Rp = 0.0
                var Gp = 0.0
                var Bp = 0.0
                
                if(HSL.hue >= 0 && HSL.hue < 60)
                {
                    Rp = C
                    Gp = X
                    Bp = 0
                }
                else if(HSL.hue >= 60 && HSL.hue < 120)
                {
                    Rp = X
                    Gp = C
                    Bp = 0
                }
                else if(HSL.hue >= 120 && HSL.hue < 180)
                {
                    Rp = 0
                    Gp = C
                    Bp = X
                }
                else if(HSL.hue >= 180 && HSL.hue < 240)
                {
                    Rp = 0
                    Gp = X
                    Bp = C
                }
                else if(HSL.hue >= 240 && HSL.hue < 300)
                {
                    Rp = X
                    Gp = 0
                    Bp = C
                }
                else if(HSL.hue >= 300 && HSL.hue < 360)
                {
                    Rp = C
                    Gp = 0
                    Bp = X
                }
                
                RGB.red = Int(round((Rp+m)*255))
                RGB.green = Int(round((Gp+m)*255))
                RGB.blue = Int(round((Bp+m)*255))
                
                HSV.hue = HSL.hue
                
                let Arrayed = [Rp, Gp, Bp]
                
                let Cmax = Arrayed.max()!
                let Cmin = Arrayed.min()!
                
                let Delta = Cmax - Cmin
                
                HSV.value = Cmax
                
                if(Cmax == 0) {HSV.saturation = 0}
                if(Cmax != 0) {HSV.saturation = Delta/Cmax}
                
                hexStrc.red = String(format:"%02X", Int(RGB.red))
                hexStrc.green = String(format:"%02X", Int(RGB.green))
                hexStrc.blue = String(format:"%02X", Int(RGB.blue))
                
                hexStrc.full = hexStrc.red + hexStrc.green + hexStrc.blue
                HEX = "#"+hexStrc.full
            }
        }
        else if(Operations[selection] == "HSV")
        {
            let HSL_STRING = leftField.text! + centerField.text! + rightField.text!
            
            var i = 0
            
            var ERROR = false
            
            while(i < HSL_STRING.count)
            {
                if
                (
                    HSL_STRING[i] != "0" && HSL_STRING[i] != "1" && HSL_STRING[i] != "2" && HSL_STRING[i] != "3" && HSL_STRING[i] != "4" && HSL_STRING[i] != "5" && HSL_STRING[i] != "6" && HSL_STRING[i] != "7" && HSL_STRING[i] != "8" && HSL_STRING[i] != "9" && HSL_STRING[i] != "."
                )
                {
                    ERROR = true
                }
                i+=1
            }
            if(ERROR == true)
            {
                ERROR_TOTAL = true
            }
            else
            {
                HSV.hue = Double(leftField.text!)!
                HSV.saturation = Double(centerField.text!)!/100
                HSV.value = Double(rightField.text!)!/100
                
                let C = HSV.value * HSV.saturation
                
                let X = C * (1 - abs((HSV.hue/60).truncatingRemainder(dividingBy: 2)-1))
                let m = HSV.value - C
                
                var Rp = 0.0
                var Gp = 0.0
                var Bp = 0.0
                
                if(HSV.hue >= 0 && HSV.hue < 60)
                {
                    Rp = C
                    Gp = X
                    Bp = 0
                }
                else if(HSV.hue >= 60 && HSV.hue < 120)
                {
                    Rp = X
                    Gp = C
                    Bp = 0
                }
                else if(HSV.hue >= 120 && HSV.hue < 180)
                {
                    Rp = 0
                    Gp = C
                    Bp = X
                }
                else if(HSV.hue >= 180 && HSV.hue < 240)
                {
                    Rp = 0
                    Gp = X
                    Bp = C
                }
                else if(HSV.hue >= 240 && HSV.hue < 300)
                {
                    Rp = X
                    Gp = 0
                    Bp = C
                }
                else if(HSV.hue >= 300 && HSV.hue < 360)
                {
                    Rp = C
                    Gp = 0
                    Bp = X
                }
                
                RGB.red = Int(round((Rp+m)*255))
                RGB.green = Int(round((Gp+m)*255))
                RGB.blue = Int(round((Bp+m)*255))
                
                HSL.hue = HSV.hue
                
                let Arrayed = [Rp, Gp, Bp]
                
                let Cmax = Arrayed.max()!
                let Cmin = Arrayed.min()!
                
                let Delta = Cmax - Cmin
                
                HSL.lightness = ((Cmax + Cmin)/2)
                
                if(Delta == 0) {HSL.saturation = 0}
                if(Delta != 0) {HSL.saturation = 1-abs(2*HSL.lightness-1)}
                
                hexStrc.red = String(format:"%02X", Int(RGB.red))
                hexStrc.green = String(format:"%02X", Int(RGB.green))
                hexStrc.blue = String(format:"%02X", Int(RGB.blue))
                
                hexStrc.full = hexStrc.red + hexStrc.green + hexStrc.blue
                
                HEX = "#"+hexStrc.full
                
                
            }
        }
        
        if(ERROR_TOTAL == true)
        {
            outHEX.text = "#ERROR"
            outRGB.text = "ERROR, ERROR, ERROR"
            outHSV.text = "ERROR°, ERROR%, ERROR%"
            outHSL.text = "ERROR°, ERROR%, ERROR%"
            
            let alert = UIAlertController(title: "ERROR", message: "ERROR IN THE TEXT FIELD!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            colorSquare.textColor = UIColor.init(red: CGFloat(255/255), green: CGFloat(20/255), blue: CGFloat(147/255), alpha: 100)
        }
        else
        {
            outHEX.text = HEX
            outRGB.text = "\(RGB.red), \(RGB.green), \(RGB.blue)"
            outHSV.text = "\(String(format: "%.1f", HSV.hue))°, \(String(format: "%.1f", HSV.saturation*100))%, \(String(format: "%.1f", HSV.value*100))%"
            outHSL.text = "\(String(format: "%.1f", HSL.hue))°, \(String(format: "%.1f", HSL.saturation*100))%, \(String(format: "%.1f", HSL.lightness*100))%"
            
            let foo = "0x"+hexStrc.full
            let fooInt = (foo as NSString).integerValue
            print(foo)
            
            print(fooInt)
            
            colorSquare.textColor = colorWithHexString(hex: HEX)
        }

    }
    
    @IBAction func ClearButton(_ sender: Any)
    {
        centerField.text = ""
        leftField.text   = ""
        rightField.text  = ""
        
        outRGB.text = ""
        outHEX.text = ""
        outHSL.text = ""
        outHSV.text = ""
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.hideskeyboard()
        
        leftField.isUserInteractionEnabled = true
        rightField.isUserInteractionEnabled = true
        
        centerField.text = ""
        leftField.text   = ""
        rightField.text  = ""
        
        outRGB.text = ""
        outHEX.text = ""
        outHSL.text = ""
        outHSV.text = ""
        // Do any additional setup after loading the view.
    }

    
    func colorWithHexString (hex:String) -> UIColor
    {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }

        if (cString.count != 6) {
            return UIColor.gray
        }

        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)

        var r:UInt64 = 0, g:UInt64 = 0, b:UInt64 = 0;
        Scanner(string: rString).scanHexInt64(&r)
        Scanner(string: gString).scanHexInt64(&g)
        Scanner(string: bString).scanHexInt64(&b)


        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
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

extension UIColor
{
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
    
    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }

    // let's suppose alpha is the first component (ARGB)
    convenience init(argb: Int) {
        self.init(
            red: (argb >> 16) & 0xFF,
            green: (argb >> 8) & 0xFF,
            blue: argb & 0xFF,
            a: (argb >> 24) & 0xFF
        )
    }
}
