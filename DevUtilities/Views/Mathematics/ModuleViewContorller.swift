//
//  ModuleViewContorller.swift
//  DevUtilities
//
//  Created by Vittorio Picone on 05/06/2020.
//  Copyright © 2020 Vittorio Picone. All rights reserved.
//

import UIKit

class ModuleViewContorller: UIViewController
{

    @IBOutlet weak var insertA: UITextField!
    @IBOutlet weak var insertB: UITextField!
    @IBOutlet weak var showModule: UILabel!
    
    @IBAction func Calculate(_ sender: Any)
    {
        let A = Int(insertA.text!)
        let B = Int(insertB.text!)
        
        let module = Int(A! % B!)
         
        showModule.text = String(module)
     }
    

    @IBAction func Clear(_ sender: Any)
    {
        insertA.text    = ""
        insertB.text    = ""
        showModule.text = ""
     }
    

     override func viewDidLoad()
     {
         super.viewDidLoad()
         self.hideskeyboard()
         showModule.text = ""
     }

}
