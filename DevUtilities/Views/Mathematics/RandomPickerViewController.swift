//
//  RandomPickerViewController.swift
//  DevUtilities
//
//  Created by Vittorio Picone on 05/06/2020.
//  Copyright © 2020 Vittorio Picone. All rights reserved.
//

import UIKit

class RandomPickerViewController: UIViewController {

    @IBOutlet weak var insertMin: UITextField!
    @IBOutlet weak var insertMax: UITextField!
    @IBOutlet weak var labelOut: UILabel!
    
    @IBAction func Pick(_ sender: Any)
    {
        let Min = Int(insertMin.text!)
        let Max = Int(insertMax.text!)
        labelOut.text = String(Int.random(in:  Min! ... Max!))
        if(Min! >= Max!){labelOut.text = "Insert Error (1)"}
    }
    
    @IBAction func Clear(_ sender: Any)
    {
        insertMax.text = ""
        insertMin.text = ""
        labelOut.text  = ""
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        insertMax.text = ""
        insertMin.text = ""
        labelOut.text  = ""
        self.hideskeyboard()
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
