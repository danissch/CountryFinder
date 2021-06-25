//
//  MainConfiguration.swift
//  CountryFinder
//
//  Created by Daniel Duran Schutz on 22/06/21.
//

import Foundation

class MainConfiguration {
    static let shared = MainConfiguration()
    
    var apikey: String = ""
    var host: String = ""
    var allCountriesUrl: String = ""
    
    func readPropertyList(){
        var format = PropertyListSerialization.PropertyListFormat.xml //format of the property list
            var plistData:[String:AnyObject] = [:]  //our data
        let plistPath:String? = Bundle.main.path(forResource: "config", ofType: "plist")! //the path of the data
        let plistXML = FileManager.default.contents(atPath: plistPath!)! //the data in XML format
        do{ //convert the data to a dictionary and handle errors.
            plistData = try PropertyListSerialization.propertyList(from: plistXML,options: .mutableContainersAndLeaves,format: &format)as! [String:AnyObject]
             
            //assign the values in the dictionary to the properties
            apikey = plistData["APIKEY"] as! String
            host = plistData["HOST"] as! String
            allCountriesUrl = "\(plistData["ALL_COUNTRIES_URL"] as! String)?x-rapidapi-key=\(apikey)&x-rapidapi-host=\(host)"
        }
        catch{ // error condition
            print("Error reading plist: \(error), format: \(format)")
        }
    }
}
