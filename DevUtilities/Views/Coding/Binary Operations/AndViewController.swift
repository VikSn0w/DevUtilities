//
//  AndViewController.swift
//  DevUtilities
//
//  Created by Vittorio Picone on 05/06/2020.
//  Copyright © 2020 Vittorio Picone. All rights reserved.
//

import UIKit

class AndViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate
{
    var selection = 0
    
    var Operations = ["And [ & ]", "Or [ | ]", "Not [ ! ]"]
    
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
        print("Selected : \(Operations[row])");
        if(Operations[selection] == "Not [ ! ]")
        {
            insertSecond.isUserInteractionEnabled = false
        }
        else
        {
            insertSecond.isUserInteractionEnabled = true
        }
    }


    @IBOutlet weak var insertFirst: UITextField!
    @IBOutlet weak var insertSecond: UITextField!
    @IBOutlet weak var Result: UILabel!
    
    
    @IBAction func Clear(_ sender: Any)
    {
        insertFirst.text = ""
        insertSecond.text = ""
        Result.text = ""
        insertSecond.isUserInteractionEnabled = true
    }
    
    @IBAction func Calculate(_ sender: Any)
    {
        if(Operations[selection] == "And [ & ]")
        {
            let first  = insertFirst.text
            let second = insertSecond.text
            
            let number1 = strtoul(first, nil, 2)
            let number2 = strtoul(second, nil, 2)

            let result = number1 & number2
            
            let str = String(result, radix: 2)
            
            Result.text = pad(string: str, toSize: first!.count)
        }
        else if(Operations[selection] == "Or [ | ]")
        {
            let first  = insertFirst.text
            let second = insertSecond.text
            
            let number1 = strtoul(first, nil, 2)
            let number2 = strtoul(second, nil, 2)

            let result = number1 & number2
            
            let str = String(result, radix: 2)
            
            Result.text = pad(string: str, toSize: first!.count)
        }
            
        else if(Operations[selection] == "Not [ ! ]")
        {
            let first  = insertFirst.text
            insertSecond.isUserInteractionEnabled = false
            
            let charArray = Array(first!)
            
            var result = ""
            
            var i = 0
            while(i < charArray.count)
            {
                     if(charArray[i] == "1"){result = result + "0"}
                else if(charArray[i] == "0"){result = result + "1"}
                i += 1
            }
            Result.text = String(result)//pad(string: str, toSize: first!.count)
        }
    }
    
    func pad(string : String, toSize: Int) -> String
    {
        var padded = string
        for _ in 0..<(toSize - string.count) {padded = "0" + padded}
        return padded
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.hideskeyboard()
        insertFirst.text = ""
        insertSecond.text = ""
        Result.text = ""
        insertSecond.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
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
