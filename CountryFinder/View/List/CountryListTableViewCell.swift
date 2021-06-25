//
//  CountryListTableViewCell.swift
//  CountryFinder
//
//  Created by Daniel Duran Schutz on 23/06/21.
//

import Foundation
import UIKit

class CountryListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainCointainerView: UIView!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var propertiesContainerView: UIView!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryCapitalNameLabel: UILabel!
    @IBOutlet weak var countryRegionLabel: UILabel!

    var countryNameLabelString: String?
    var countryCapitalNameLabelString: String?
    var countryRegionLabelString: String?
    let noCountryString = "No country"
    let noCapitalString = "No capital"
    let noRegionString = "No region"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCellData(country:CountryModel){
        
        let name = country.name == "" ? noCountryString : country.name
        let capital = country.capital == "" ? noCapitalString : country.capital
        let region = country.region == "" ? noRegionString : country.region
        
        self.countryNameLabelString = name
        self.countryCapitalNameLabelString = capital
        self.countryRegionLabelString = region
        
        configureMainCointainerView()
        configureGoButton()
        configureCountryNameLabel()
        configureCountryCapitalNameLabel()
        configureCountryRegionLabel()
        
    }
 
    func configureGoButton(){
        goButton.layer.cornerRadius = 3
        goButton.tintColor = .white
    }
    
    func configureCountryNameLabel(){
        countryNameLabel.text = countryNameLabelString?.uppercased()
        countryNameLabel.addCharacterSpacing()
    }
    
    func configureMainCointainerView(){
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            self.mainCointainerView.layer.borderWidth = 1
            self.mainCointainerView.layer.borderColor = UIColor.lightGray.cgColor.copy(alpha: 0.4)
            self.mainCointainerView.dropShadow(color: UIColor.lightGray, opacity: 0.15, offSet: CGSize(width: 5, height: 5), radius: 1, scale: false)
            self.mainCointainerView.layer.cornerRadius = 3
        })
    }
    
    func configureCountryCapitalNameLabel(){
        self.countryCapitalNameLabel.text = countryCapitalNameLabelString?.lowercased()
        
    }
    
    func configureCountryRegionLabel(){
        self.countryRegionLabel.text = countryRegionLabelString?.uppercased()
    }

    
}
