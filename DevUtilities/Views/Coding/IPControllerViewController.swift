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
            var PrimoOttettoIP         = Int(FieldPrimoOttetto!.text!)!
            IPAddress().PrimoOttetto   = PrimoOttettoIP
            
            var SecondoOttettoIP       = Int(FieldSecondoOttetto!.text!)!
            IPAddress().SecondoOttetto = SecondoOttettoIP
            
            var TerzoOttettoIP         = Int(FieldTerzoOttetto!.text!)!
            IPAddress().TerzoOttetto   = TerzoOttettoIP
            
            var QuartoOttettoIP        = Int(FieldQuartoOttetto!.text!)!
            IPAddress().QuartoOttetto  = QuartoOttettoIP
            
            var SlashNotation          = Int(FieldSubnetMaskSL!.text!)!
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
                if(SlashNotation == 1) {PrimoOttettoSN = 128;}
                if(SlashNotation == 2) {PrimoOttettoSN = 192;}
                if(SlashNotation == 3) {PrimoOttettoSN = 224;}
                if(SlashNotation == 4) {PrimoOttettoSN = 240;}
                if(SlashNotation == 5) {PrimoOttettoSN = 248;}
                if(SlashNotation == 6) {PrimoOttettoSN = 252;}
                if(SlashNotation == 7) {PrimoOttettoSN = 254;}
                if(SlashNotation == 8) {PrimoOttettoSN = 255;}
                if(SlashNotation > 8)
                {
                    PrimoOttettoSN = 255
                    if(SlashNotation == 9)  {SecondoOttettoSN = 128;}
                    if(SlashNotation == 10) {SecondoOttettoSN = 192;}
                    if(SlashNotation == 11) {SecondoOttettoSN = 224;}
                    if(SlashNotation == 12) {SecondoOttettoSN = 240;}
                    if(SlashNotation == 13) {SecondoOttettoSN = 248;}
                    if(SlashNotation == 14) {SecondoOttettoSN = 252;}
                    if(SlashNotation == 15) {SecondoOttettoSN = 254;}
                    if(SlashNotation == 16) {SecondoOttettoSN = 255;}
                    if(SlashNotation > 16)
                    {
                        PrimoOttettoSN = 255; SecondoOttettoSN = 255;
                        if(SlashNotation == 17) {TerzoOttettoSN = 128;}
                        if(SlashNotation == 18) {TerzoOttettoSN = 192;}
                        if(SlashNotation == 19) {TerzoOttettoSN = 224;}
                        if(SlashNotation == 20) {TerzoOttettoSN = 240;}
                        if(SlashNotation == 21) {TerzoOttettoSN = 248;}
                        if(SlashNotation == 22) {TerzoOttettoSN = 252;}
                        if(SlashNotation == 23) {TerzoOttettoSN = 254;}
                        if(SlashNotation == 24) {TerzoOttettoSN = 255;}
                        if(SlashNotation > 24)
                        {
                            PrimoOttettoSN = 255; SecondoOttettoSN = 255; TerzoOttettoSN = 255;
                            if(SlashNotation == 25) {QuartoOttettoSN = 128;}
                            if(SlashNotation == 26) {QuartoOttettoSN = 192;}
                            if(SlashNotation == 27) {QuartoOttettoSN = 224;}
                            if(SlashNotation == 28) {QuartoOttettoSN = 240;}
                            if(SlashNotation == 29) {QuartoOttettoSN = 248;}
                            if(SlashNotation == 30) {QuartoOttettoSN = 252;}
                            if(SlashNotation == 31) {QuartoOttettoSN = 254;}
                            if(SlashNotation == 32) {QuartoOttettoSN = 255;}
                        }
                    }
                }
                
                SubnetLabel.text = String(PrimoOttettoSN) + "." + String(SecondoOttettoSN) + "." + String(TerzoOttettoSN) + "." + String(QuartoOttettoSN)
            }
            
            
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
            
            if(Esteso == Broadcast)
            {
                TipoLabel.text = "Broadcast"
            }
            if(Esteso == Rete)
            {
                TipoLabel.text = "Rete"
            }
            if(Esteso != Rete && Esteso != Broadcast)
            {
                TipoLabel.text = "Host"
            }
            
            
            if(PrimoOttettoIP >= 0 && PrimoOttettoIP < 128)
            {
                ClasseField.text = "A";
            }
            if(PrimoOttettoIP >= 128 && PrimoOttettoIP < 192)
            {
                 ClasseField.text = "B";
            }
            if(PrimoOttettoIP >= 192 && PrimoOttettoIP < 224)
            {
                 ClasseField.text = "C";
            }
            if(PrimoOttettoIP >= 224 && PrimoOttettoIP < 240)
            {
                 ClasseField.text = "D";
            }
            if(PrimoOttettoIP >= 240 && PrimoOttettoIP < 248)
            {
                 ClasseField.text = "E";
            }
            if(PrimoOttettoIP >= 248)
            {
                 ClasseField.text = "Classe non definita";
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
