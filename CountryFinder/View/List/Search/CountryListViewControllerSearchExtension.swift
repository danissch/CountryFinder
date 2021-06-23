//
//  CountryListViewController.swift
//  CountryFinder
//
//  Created by Daniel Duran Schutz on 23/06/21.
//

import Foundation
import UIKit

extension CountryListViewController: UISearchBarDelegate{
    
    func addSearch() -> CustomSearchBar? {
        searchView = CustomSearchBar.init(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: searchBarHeight))
        searchView = searchView?.getSearchBar(delegate: self as UISearchBarDelegate) as? CustomSearchBar
        searchView?.resignFirstResponder()
        return searchView
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isEditing = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isEditing = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isEditing = false
        searchBar.text = ""
//        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isEditing = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
//            self.searchLocation(toLookFor: "")
            self.tableView.reloadData()
        } else {
            isEditing = true
//            self.searchLocation(toLookFor: searchBar.text ?? "")
//            self.tableView.reloadData()
        }
        
    }
    
}
