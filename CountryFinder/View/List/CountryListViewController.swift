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
    private let heightForHeader:CGFloat = 110
    let searchBarHeight:Int = 80
    var searchView:CustomSearchBar?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        registerViewsTableView()
        getCountries()
        
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
        return self.countryListViewModel?.countryCount() ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCount = countryListViewModel?.countryCount()
        if listCount == 0  {
            let noRowsCell = tableView.dequeueReusableCell(withIdentifier: "NoRecordsFoundTableViewCell", for: indexPath) as! NoRecordsFoundTableViewCell
            noRowsCell.messageLabel.text = ""
            return noRowsCell
        }
        
        guard let countryListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CountryListTableViewCell") as? CountryListTableViewCell else {
            return UITableViewCell()
        }
        countryListTableViewCell.selectedBackgroundView = setBackgroundCellView()
        
        if let item = countryListViewModel?.countryList[indexPath.row] {
            countryListTableViewCell.setCellData(country: item)
        }
        
        return countryListTableViewCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCells
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ListHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: heightForHeader))
        headerView.setConfigFromViewController(title: "", view: addSearch() ?? UISearchBar())
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeader
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 70
        }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 70))
        footerView.backgroundColor = .clear
        return footerView
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if countryListViewModel?.countryCount() == 0 { return }
        let list = countryListViewModel?.countryList
        
        if let dataItem = list?[indexPath.row] {
            let vc = CountryDetailViewController.instantiateFromXIB() as CountryDetailViewController
            print("appflow:: dataItem.name selected: \(dataItem.name)")
            pushVc(vc, animated: true, navigationBarIsHidden: false)
        }
        
    }
    
    func setBackgroundCellView() -> UIView {
        let backGroundSelectedView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: heightForCells))
        let topColor = UIColor.init(red: 105/255, green: 185/255, blue: 227/255, alpha: 1.0).cgColor
        let bottomColor = UIColor.init(red: 151/255, green: 205/255, blue: 239/255, alpha: 1.0).cgColor
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: backGroundSelectedView.frame.height)
        layer.colors = [topColor, bottomColor]
        layer.locations = [0.0, 1.0]
        
        backGroundSelectedView.clipsToBounds = true
        backGroundSelectedView.layer.addSublayer(layer)
        return backGroundSelectedView
    }
    
    
}
