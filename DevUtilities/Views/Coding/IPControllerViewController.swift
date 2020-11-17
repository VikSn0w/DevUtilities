//
//  ViewController.swift
//  DevUtilities
//
//  Created by Vittorio Picone on 04/06/2020.
//  Copyright © 2020 Vittorio Picone. All rights reserved.
//

import UIKit

class IPControllerViewController: UIViewController
{
    @IBOutlet weak var FieldPrimoOttetto: UITextField!
    @IBOutlet weak var FieldSecondoOttetto: UITextField!
    @IBOutlet weak var FieldTerzoOttetto: UITextField!
    @IBOutlet weak var FieldQuartoOttetto: UITextField!
    @IBOutlet weak var FieldSubnetMaskSL: UITextField!
    
    @IBOutlet weak var SubnetLabel: UILabel!
    @IBOutlet weak var BroadcastLabel: UILabel!
    @IBOutlet weak var ReteLabel: UILabel!
    @IBOutlet weak var TipoLabel: UILabel!
    @IBOutlet weak var ClasseField: UILabel!
    @IBOutlet weak var IPBinarioLabel: UILabel!
    @IBOutlet weak var SubnetMaskLabel: UILabel!
    
    class IPAddress
    {
        var PrimoOttetto   : Int = 0;
        var SecondoOttetto : Int = 0;
        var TerzoOttetto   : Int = 0;
        var QuartoOttetto  : Int = 0;
        
        var Broadcast      : String = "";
        var Rete           : String = "";
        
        var Esteso         : String = "";
        
        var Tipo           : String = "";
    }
    class SubnetMask
    {
        var PrimoOttetto   : Int = 0;
        var SecondoOttetto : Int = 0;
        var TerzoOttetto   : Int = 0;
        var QuartoOttetto  : Int = 0;
        
        var SlashNotation  : Int = 0;
    }
    
    @IBAction func CalculateButton(_ sender: Any)
    {
        if(FieldPrimoOttetto.text == nil || FieldSecondoOttetto.text == nil || FieldTerzoOttetto.text == nil || FieldTerzoOttetto.text == nil || FieldQuartoOttetto.text == nil || FieldSubnetMaskSL.text == nil || FieldPrimoOttetto.text == "" || FieldSecondoOttetto.text == nil || FieldTerzoOttetto.text == "" || FieldTerzoOttetto.text == "" || FieldQuartoOttetto.text == "" || FieldSubnetMaskSL.text == "")
        {
            let alert = UIAlertController(title: "ERRORE", message: "C'è qualche casella vuota!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else
        {
            TipoLabel.text = ""
            let PrimoOttettoIP         = Int(FieldPrimoOttetto!.text!)!
            IPAddress().PrimoOttetto   = PrimoOttettoIP
            
            let SecondoOttettoIP       = Int(FieldSecondoOttetto!.text!)!
            IPAddress().SecondoOttetto = SecondoOttettoIP
            
            let TerzoOttettoIP         = Int(FieldTerzoOttetto!.text!)!
            IPAddress().TerzoOttetto   = TerzoOttettoIP
            
            let QuartoOttettoIP        = Int(FieldQuartoOttetto!.text!)!
            IPAddress().QuartoOttetto  = QuartoOttettoIP
            
            let SlashNotation          = Int(FieldSubnetMaskSL!.text!)!
            SubnetMask().SlashNotation = SlashNotation
            
            //-----------------------------CONTROLLI----------------------------------
            if(SlashNotation < 0 || SlashNotation > 32)
            {
                SubnetLabel.text = "ERRORE"
                let alert = UIAlertController(title: "ERRORE", message: "La Slash Notation comprende valori tra 0 e 32!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            if
            (
                PrimoOttettoIP < 0   || PrimoOttettoIP > 255 ||
                SecondoOttettoIP < 0 || SecondoOttettoIP > 255 ||
                TerzoOttettoIP < 0   || TerzoOttettoIP > 255 ||
                QuartoOttettoIP < 0  || QuartoOttettoIP > 255
            )
            {
                SubnetLabel.text = "ERRORE"
                let alert = UIAlertController(title: "ERRORE", message: "Gli ottetti degli IP possono avere solo valori compresi tra 0 e 255", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            //-----------------------------CALCOLO SUBNET MASK!----------------------------------
            var PrimoOttettoSN = 0
            var SecondoOttettoSN = 0
            var TerzoOttettoSN = 0
            var QuartoOttettoSN = 0
            
            if(SlashNotation >= 0)
            {
                PrimoOttettoSN = Int(pow(Double(2), Double((8-(SlashNotation%8)))))-1;
                if(SlashNotation > 8)
                {
                    PrimoOttettoSN   = 255;
                    SecondoOttettoSN = Int(pow(Double(2), Double((8-(SlashNotation%8)))))-1;
                    
                    if(SlashNotation > 16)
                    {
                        PrimoOttettoSN = 255; SecondoOttettoSN = 255;
                        TerzoOttettoSN = Int(pow(Double(2), Double((8-(SlashNotation%8)))))-1;
                        
                        if(SlashNotation > 24)
                        {
                            PrimoOttettoSN  = 255; SecondoOttettoSN = 255; TerzoOttettoSN   = 255;
                            QuartoOttettoSN = Int(pow(Double(2), Double((8-(SlashNotation%8)))))-1;
                        }
                    }
                }
            }
            
            SubnetLabel.text = String(PrimoOttettoSN) + "." + String(SecondoOttettoSN) + "." + String(TerzoOttettoSN) + "." + String(QuartoOttettoSN)
            
            //-----------------------------CALCOLO BROADCAST!----------------------------------
            var PrimoOttettoBR   = PrimoOttettoIP   |  ~PrimoOttettoSN
            var SecondoOttettoBR = SecondoOttettoIP |  ~SecondoOttettoSN
            var TerzoOttettoBR   = TerzoOttettoIP   |  ~TerzoOttettoSN
            var QuartoOttettoBR  = QuartoOttettoIP  |  ~QuartoOttettoSN
            
            //PRIMO OTTETTO
            let Px = PrimoOttettoBR;
            let Py = ~Px;
            let Pz = PrimoOttettoIP;
            PrimoOttettoBR = (-(Py+Pz)+255)+Pz;
            
            //SECONDO OTTETTO
            let Sx = SecondoOttettoBR;
            let Sy = ~Sx;
            let Sz = SecondoOttettoIP;
            SecondoOttettoBR = (-(Sy+Sz)+255)+Sz;
            
            //TERZO OTTETTO
            let Tx = TerzoOttettoBR;
            let Ty = ~Tx;
            let Tz = TerzoOttettoIP;
            TerzoOttettoBR = (-(Ty+Tz)+255)+Tz;

            //QUARTO OTTETTO
            let Qx = QuartoOttettoBR;
            let Qy = ~Qx;
            let Qz = QuartoOttettoIP;
            QuartoOttettoBR = (-(Qy+Qz)+255)+Qz;
            
            BroadcastLabel.text = String(PrimoOttettoBR) + "." + String(SecondoOttettoBR) + "." + String(TerzoOttettoBR) + "." + String(QuartoOttettoBR)
            let Broadcast = String(PrimoOttettoBR) + "." + String(SecondoOttettoBR) + "." + String(TerzoOttettoBR) + "." + String(QuartoOttettoBR)
            
            //-------------------------------CALCOLO RETE!----------------------------------
            let PrimoOttettoRT   = PrimoOttettoIP   &  PrimoOttettoSN
            let SecondoOttettoRT = SecondoOttettoIP &  SecondoOttettoSN
            let TerzoOttettoRT   = TerzoOttettoIP   &  TerzoOttettoSN
            let QuartoOttettoRT  = QuartoOttettoIP  &  QuartoOttettoSN
            
            ReteLabel.text = String(PrimoOttettoRT) + "." + String(SecondoOttettoRT) + "." + String(TerzoOttettoRT) + "." + String(QuartoOttettoRT)
            let Rete = String(PrimoOttettoRT) + "." + String(SecondoOttettoRT) + "." + String(TerzoOttettoRT) + "." + String(QuartoOttettoRT)
            //-------------------------------TIPO-------------------------------------
            let Esteso = String(PrimoOttettoIP) + "." + String(SecondoOttettoIP) + "." + String(TerzoOttettoIP) + "." + String(QuartoOttettoIP)
            
            switch (Esteso)
            {
                case Broadcast:
                    TipoLabel.text = "Broadcast"
                break;
                    
                case Rete:
                    TipoLabel.text = "Rete"
                break;
                    
                default:
                    TipoLabel.text = "Host"
                break;
            }
            
            switch(PrimoOttettoIP)
            {
                case 0..<128:
                    ClasseField.text = "A";
                break;
                    
                case 128..<192:
                    ClasseField.text = "B";
                break;
                    
                case 192..<224:
                    ClasseField.text = "C";
                break;
                
                case 224..<240:
                    ClasseField.text = "D";
                break;
                    
                case 240..<248:
                    ClasseField.text = "E";
                break;
                    
                default:
                    ClasseField.text = "Classe non definita";
                break;
                    
            }
            
            func Bitted(string : String, toSize: Int) -> String
            {
                var bitted = string
                for _ in 0..<(toSize - string.count)
                {
                    bitted = "0" + bitted
                }
                return bitted
            }
            
            let PrimoOttettoIPString   = String(PrimoOttettoIP, radix: 2)
            let SecondoOttettoIPString = String(SecondoOttettoIP, radix: 2)
            let TerzoOttettoIPString   = String(TerzoOttettoIP, radix: 2)
            let QuartoOttettoIPString  = String(QuartoOttettoIP, radix: 2)
            
            IPBinarioLabel.text = Bitted(string: PrimoOttettoIPString, toSize: 8) + "." + Bitted(string: SecondoOttettoIPString, toSize: 8) + "." + Bitted(string: TerzoOttettoIPString, toSize: 8) + "." + Bitted(string: QuartoOttettoIPString, toSize: 8)
            
            let PrimoOttettoSNString   = String(PrimoOttettoSN, radix: 2)
            let SecondoOttettoSNString = String(SecondoOttettoSN, radix: 2)
            let TerzoOttettoSNString   = String(TerzoOttettoSN, radix: 2)
            let QuartoOttettoSNString  = String(QuartoOttettoSN, radix: 2)
            
            SubnetMaskLabel.text = Bitted(string: PrimoOttettoSNString, toSize: 8) + "." + Bitted(string: SecondoOttettoSNString, toSize: 8) + "." + Bitted(string: TerzoOttettoSNString, toSize: 8) + "." + Bitted(string: QuartoOttettoSNString, toSize: 8)
        }
        
        //-------------------------------CALCOLO BINARIO-------------------------------------
        
        
        
    }
    
    @IBAction func PulisciButton(_ sender: Any)
    {
        FieldPrimoOttetto.text   = ""
        FieldSecondoOttetto.text = ""
        FieldTerzoOttetto.text   = ""
        FieldQuartoOttetto.text  = ""
        FieldSubnetMaskSL.text   = ""
        
        SubnetLabel.text     = "0.0.0.0"
        BroadcastLabel.text  = "0.0.0.0"
        ReteLabel.text       = "0.0.0.0"
        TipoLabel.text       = "/////"
        ClasseField.text     = "/////"
        IPBinarioLabel.text  = "00000000.00000000.00000000.00000000"
        SubnetMaskLabel.text = "00000000.00000000.00000000.00000000"
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.hideskeyboard()
    }
}
