//
//  InAppOpen_Credits.swift
//  DevUtilities
//
//  Created by Vittorio Picone on 04/06/2020.
//  Copyright © 2020 Vittorio Picone. All rights reserved.
//

import UIKit

class InAppOpen_Credits: UIViewController {

    @IBAction func instagramViksn0w(_ sender: Any)
    {
        if let appURL = URL(string: "instagram://user?username=viksn0w")
        {
            let canOpen = UIApplication.shared.canOpenURL(appURL)
            print("\(canOpen)")
            
            let appName = "Instagram"
            let appScheme = "\(appName)://user?username=viksn0w"
            let appSchemeURL = URL(string: appScheme)
            if UIApplication.shared.canOpenURL(appSchemeURL! as URL)
            {
                UIApplication.shared.open(appSchemeURL!, options: [:], completionHandler: nil)
            }
            else
            {
                let alert = UIAlertController(title: "\(appName) ERROR", message: "The app named \(appName) was not found, try the web [Web] version!" , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func InstagramViksn0wDesign(_ sender: Any)
    {
        if let appURL = URL(string: "instagram://user?username=viksn0w.design")
        {
            let canOpen = UIApplication.shared.canOpenURL(appURL)
            print("\(canOpen)")
            
            let appName = "Instagram"
            let appScheme = "\(appName)://user?username=viksn0w.design"
            let appSchemeURL = URL(string: appScheme)
            if UIApplication.shared.canOpenURL(appSchemeURL! as URL)
            {
                UIApplication.shared.open(appSchemeURL!, options: [:], completionHandler: nil)
            }
            else
            {
                let alert = UIAlertController(title: "\(appName) ERROR", message: "The app named \(appName) was not found, try the web [Web] version!" , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func TwitterViksn0w1(_ sender: Any)
    {
        if let appURL = URL(string: "twitter://user?screen_name=viksn0w1")
        {
            let canOpen = UIApplication.shared.canOpenURL(appURL)
            print("\(canOpen)")
            
            let appName = "Twitter"
            let appScheme = "\(appName)://user?screen_name=viksn0w1"
            let appSchemeURL = URL(string: appScheme)
            if UIApplication.shared.canOpenURL(appSchemeURL! as URL)
            {
                UIApplication.shared.open(appSchemeURL!, options: [:], completionHandler: nil)
            }
            else
            {
                let alert = UIAlertController(title: "\(appName) ERROR", message: "The app named \(appName) was not found, try the web [Web] version!" , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
