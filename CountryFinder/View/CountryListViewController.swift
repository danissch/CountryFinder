//
//  CountryListViewController.swift
//  CountryFinder
//
//  Created by Daniel Duran Schutz on 22/06/21.
//

import UIKit

class CountryListViewController: UIViewController {

    var countryListViewModel: CountryListViewModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        getCountries()
    }


}

extension CountryListViewController {
    func setupViewModel(){
        self.countryListViewModel = CountryListViewModel()
//        NetworkService.get.afSessionManager = AFSessionManager()
//        countryListViewModel.networkService = NetworkService.get
//        self.countryListViewModel = countryListViewModel
    }
    
    func getCountries(){
        countryListViewModel?.getCountryList()
    }
}
