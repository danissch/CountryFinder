//
//  CountryListViewController.swift
//  CountryFinder
//
//  Created by Daniel Duran Schutz on 22/06/21.
//

import UIKit

class CountryListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var countryListViewModel: CountryListViewModel?
    private let heightForCells:CGFloat = 130
    private let heightForHeader:CGFloat = 60
    private let heightForFooter:CGFloat = 60
    let searchBarHeight:Int = 60
    var customSearchBar:CustomSearchBar?
    var isSearching: Bool = false
    var searchTextFieldValue: String = ""
    var searchTextFieldIsFirstResponder: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        registerViewsTableView()
        setSomeCustomConfigurations()
        getCountries()
        self.hideKeyboardWhenTappedAround()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tableView.layoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else { print("Portrait") }
        handleSomeOrientationBehaviors()
    }
    
}

// self managament functions
extension CountryListViewController {
    func registerViewsTableView(){
        let headernib = UINib(nibName: "ListHeaderView", bundle: nil)
        tableView.register(headernib, forHeaderFooterViewReuseIdentifier: "listHeaderView")
        
        tableView.register(UINib(nibName: "CountryListTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CountryListTableViewCell")
        
        tableView.register(UINib(nibName:"NoRecordsFoundTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "NoRecordsFoundTableViewCell")
        
    }
    
    func setSomeCustomConfigurations(){
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = heightForCells
    }
    
    func handleSomeOrientationBehaviors(){
        guard let searchTextFieldIsFirstResponder = customSearchBar?.searchTextField.isFirstResponder else { return }
        self.searchTextFieldIsFirstResponder = searchTextFieldIsFirstResponder
        
        self.customSearchBar?.searchTextField.resignFirstResponder()
        self.tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            if searchTextFieldIsFirstResponder {
                self.customSearchBar?.searchTextField.text = self.searchTextFieldValue
                self.customSearchBar?.searchTextField.becomeFirstResponder()
            }
            
        })
    }
}



//ViewModel Relation
extension CountryListViewController: CountryListViewModelDelegate {
    
    func setupViewModel(){
        self.countryListViewModel = CountryListViewModel()
        self.countryListViewModel?.delegate = self
    }
    
    func getCountries(){
        countryListViewModel?.getCountryList()
    }
    
    func onCountriesLoaded() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

//TableView Relation
extension CountryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let countryListCount = self.countryListViewModel?.countryCount()
        if isSearching{ return countryListViewModel?.filteredCountryCount() ?? 0 }
        return  ((countryListCount == 0 ? 1 : countryListCount) ?? 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCount = isSearching ? countryListViewModel?.filteredCountryCount() : countryListViewModel?.countryCount()
        
        if listCount == 0  {
            let noRowsCell = tableView.dequeueReusableCell(withIdentifier: "NoRecordsFoundTableViewCell", for: indexPath) as! NoRecordsFoundTableViewCell
            noRowsCell.messageLabel.text = ""
            return noRowsCell
        }
        
        guard let countryListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CountryListTableViewCell") as? CountryListTableViewCell else {
            return UITableViewCell()
        }
        
        if let item = isSearching ? countryListViewModel?.filteredCountryList[indexPath.row] : countryListViewModel?.countryList[indexPath.row] {
            countryListTableViewCell.setCellData(country: item)
        }
        
        return countryListTableViewCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
        
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = ListHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: heightForHeader))
        headerView.setConfigFromViewController(title: "", view: getSearchBarView() ?? UISearchBar())
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeader
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return heightForFooter
        }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 70))
        footerView.backgroundColor = .clear
        return footerView
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryCount = countryListViewModel?.countryCount()
        if countryCount == 0 { return }
                
        let list = isSearching ? countryListViewModel?.filteredCountryList : countryListViewModel?.countryList
        
        if let dataItem = list?[indexPath.row] {
            let vc = CountryDetailViewController.instantiateFromXIB() as CountryDetailViewController
            vc.setCountryDetail(country: dataItem)
            pushVc(vc, animated: true, navigationBarIsHidden: false)
        }
        
    }
    
    
}
