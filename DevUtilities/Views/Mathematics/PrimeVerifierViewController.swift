//
//  PrimeVerifierViewController.swift
//  DevUtilities
//
//  Created by Vittorio Picone on 05/06/2020.
//  Copyright © 2020 Vittorio Picone. All rights reserved.
//

import UIKit

class PrimeVerifierViewController: UIViewController {

    @IBOutlet weak var numberIN: UITextField!
    @IBOutlet weak var labelOUT: UILabel!
    
    @IBAction func Verify(_ sender: Any)
    {
        var D = 1
        var C = 0
        let number = Int(numberIN.text!)

        repeat
        {
            if (number! % D == 0)
            {
                C = C + 1
            }
            else
            {
            }
            D = D + 1
            
        }while(D <= number!)

        if ( C <= 2 )
        {
            labelOUT.text = "Prime"
        }
        else
        {
            labelOUT.text = "Not prime"
        }
    }
    
    
    @IBAction func Clear(_ sender: Any)
    {
        labelOUT.text = ""
        numberIN.text = ""
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.hideskeyboard()
        labelOUT.text = ""
    }
}
