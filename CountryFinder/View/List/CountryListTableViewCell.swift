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
    
    @IBOutlet weak var propertiesStackView: UIStackView!

    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryCapitalNameLabel: UILabel!
    @IBOutlet weak var countryRegionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCellData(country:CountryModel){
        self.countryNameLabel.text = country.name
        self.countryCapitalNameLabel.text = country.capital
        self.countryRegionLabel.text = country.region
    }
    
}
