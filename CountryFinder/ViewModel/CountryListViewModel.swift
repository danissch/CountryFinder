//
//  CountryListViewModel.swift
//  CountryFinder
//
//  Created by Daniel Duran Schutz on 22/06/21.
//

import Foundation

class CountryListViewModel {
    
    private var privCountryList = [CountryModel]()
    var countryList: [CountryModel] {
        get { return privCountryList }
    }
    
    private var privFilteredCountryList = [CountryModel]()
    var filteredCountryList: [CountryModel] {
        get { return privFilteredCountryList }
        set { privCountryList = newValue }
    }
        
    init() {}
    
    func getCountryList() {
        
        let headers = [
            "x-rapidapi-key": MainConfiguration.shared.apikey,
            "x-rapidapi-host": MainConfiguration.shared.host
        ]

        let request = NSMutableURLRequest(url: NSURL(string: MainConfiguration.shared.allCountriesUrl ?? "")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
//                print(response as? HTTPURLResponse)
                do {
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode([CountryModel].self, from: data)
                        self.privCountryList = response
                        print(self.privCountryList.count)
                    }
                } catch {
                    print("error:\(error)")
                }
                
            }
        })

        dataTask.resume()
    }
    
    
}

extension CountryListViewModel {
    
}

