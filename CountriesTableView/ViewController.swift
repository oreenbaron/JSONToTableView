//
//  ViewController.swift
//  CountriesTableView
//
//  Created by Oreen Baron on 5/29/18.
//  Copyright © 2018 Oreen Baron. All rights reserved.
//

import UIKit
import Alamofire

struct Country : Decodable {
    let name : String
    let capital : String
}

class ViewController: UIViewController, UITableViewDataSource {
    
   
    @IBOutlet weak var countriesTableView: UITableView!
    var countries = [Country]()
    let url = URL(string: "https://restcountries.eu/rest/v2/all")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
        
        countriesTableView.dataSource = self
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countriesTableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = countries[indexPath.row].name
        cell?.detailTextLabel?.text = countries[indexPath.row].capital
        
        return cell!
    }
    
    func parseJSON() {
        
        Alamofire.request(url!).responseJSON { (response) in
            let result = response.data
            
            do {
                self.countries = try JSONDecoder().decode([Country].self, from: result!)
                
                for country in self.countries {
                    print(country.name + ": " + country.capital )
                    //                    self.countryName.text = country.name
                    //                    self.capitalName.text = country.capital
                }
                
                self.countriesTableView.reloadData()
                
            } catch {
                print("Error")
            }
            
        }
    }
}

