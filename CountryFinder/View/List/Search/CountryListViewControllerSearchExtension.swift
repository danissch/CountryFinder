//
//  CountryListViewController.swift
//  CountryFinder
//
//  Created by Daniel Duran Schutz on 23/06/21.
//

import Foundation
import UIKit

extension CountryListViewController: UISearchBarDelegate{
    
    func getSearchBarView() -> CustomSearchBar? {
        customSearchBar = CustomSearchBar.init(frame: CGRect(x: 0,
                                                             y: 0,
                                                             width: Int(UIScreen.main.bounds.width),
                                                             height: searchBarHeight))
        customSearchBar = customSearchBar?.getSearchBar(delegate: self as UISearchBarDelegate) as? CustomSearchBar
        customSearchBar?.resignFirstResponder()
        return customSearchBar
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isEditing = true
        searchBar.searchTextField.text = searchTextFieldValue
        searchTextFieldValue = ""
        searchTextFieldIsFirstResponder = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isEditing = false
        if searchTextFieldIsFirstResponder {
            searchTextFieldValue = searchBar.searchTextField.text ?? ""
            searchTextFieldIsFirstResponder = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isEditing = false
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isEditing = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            isSearching = false
            getCountries()
        } else {
            isSearching = true
            guard let predicateString = searchBar.text?.lowercased() else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                self.countryListViewModel?.filteredCountryList.removeAll(keepingCapacity: false)
                guard let newList = self.countryListViewModel?.countryList.filter({($0.name.lowercased().range(of: predicateString) != nil) || ($0.capital.lowercased().range(of: predicateString) != nil) || ($0.region.lowercased().range(of: predicateString) != nil)}) else { return }
                self.countryListViewModel?.filteredCountryList = newList
                
                self.isSearching = (self.countryListViewModel?.filteredCountryCount() == 0) ? false: true
                self.tableView.reloadData()
                if self.countryListViewModel?.filteredCountryCount() == 0 {
                    self.customSearchBar?.setNoResultsMessageSearch(viewController: self)
                }
            })
            
        }
        
    }
    
}
