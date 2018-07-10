//
//  ViewController.swift
//  SunSetApp
//
//  Created by Ahmed Koriem on 7/10/18.
//  Copyright © 2018 Ahmed Koriem. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var LaResult: UILabel!
    @IBOutlet weak var TxtCityName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func BuGetSunSet(_ sender: Any) {
        let url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22\(TxtCityName.text!)%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
        GetUrl(url: url)
    }
    func GetUrl(url : String) {
        //di 3ashan n2dr n3ml ay 7aga tanya w manfdlsh mstanyen el natiga bas ya3ny asjt3'l parallel
        DispatchQueue.global().async {
            
        do{ let AppUrl = URL(string: url)
        let data = try Data(contentsOf: AppUrl!)
        let Jason = try JSONSerialization.jsonObject(with: data) as! [String : Any]
            let Query = Jason["query"] as! [String : Any]
            let Result = Query["results"] as! [String : Any]
            let Channel = Result["channel"] as! [String : Any]
            let Astronomy = Channel["astronomy"] as! [String : Any]
            //print(Astronomy["sunset"]!)
            //To Accses to UI lazm ntl3 mn el threading elly 3amlino
            DispatchQueue.main.sync {
                
                self.LaResult.text = "SunSet at \(Astronomy["sunset"]!)"
            }
        }
        catch
        {
            print("fi moshkla f el Server ya 3m enta")
        }
        }
    }


}

