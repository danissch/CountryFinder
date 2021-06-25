//
//  CountryListViewModel.swift
//  CountryFinder
//
//  Created by Daniel Duran Schutz on 22/06/21.
//

import Foundation

protocol CountryListViewModelDelegate {
    func onCountriesLoaded()
}

class CountryListViewModel {
    var delegate: CountryListViewModelDelegate?
    
    private var privCountryList = [CountryModel]()
    var countryList: [CountryModel] {
        get { return privCountryList }
    }
    
    private var privFilteredCountryList = [CountryModel]()
    var filteredCountryList: [CountryModel] {
        get { return privFilteredCountryList }
        set { privFilteredCountryList = newValue }
    }
        
    init() {}
    
    func getCountryList() {
        let headers = [
            "x-rapidapi-key": MainConfiguration.shared.apikey,
            "x-rapidapi-host": MainConfiguration.shared.host
        ]
        let request = NSMutableURLRequest(url: NSURL(string: MainConfiguration.shared.allCountriesUrl)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error ?? "")
            } else {
                do {
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode([CountryModel].self, from: data)
                        self.privCountryList = response
                        print(self.privCountryList.count)
                        self.delegate?.onCountriesLoaded()
                    }
                } catch {
                    print("error:\(error)")
                }
                
            }
        })

        dataTask.resume()
    }
    
    func countryCount() -> Int {
        return countryList.count
    }
    
    func filteredCountryCount() -> Int {
        return filteredCountryList.count
    }
    
    
}


