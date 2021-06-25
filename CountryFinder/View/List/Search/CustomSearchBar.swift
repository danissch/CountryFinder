//
//  CustomSearchBar.swift
//  CountryFinder
//
//  Created by Daniel Duran Schutz on 23/06/21.
//

import Foundation
import UIKit

class CustomSearchBar: UISearchBar {
    var searchTField: UITextField?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.autoresizingMask = [.flexibleWidth]
        self.autoresizesSubviews = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func getSearchBar(delegate:UISearchBarDelegate) -> UISearchBar{
        self.delegate = delegate
        customizeSearchField()
        return self
    }
    
    fileprivate func customizeSearchField(){
//        UISearchBar.appearance().setSearchFieldBackgroundImage(UIImage(), for: .normal)
        if (self.value(forKey: "searchField") as? UITextField) != nil {
            setSomeTextFieldCustomizations()
        }
        
    }
    
    func setRightImage(_ image: UIImage, searchTextField: UITextField, imageColor: UIColor) {
        showsBookmarkButton = true
        if let btn = searchTextField.rightView as? UIButton {
            btn.setImage(image, for: .normal)
            btn.setImage(image, for: .highlighted)
            btn.tintColor = imageColor
        }
    }
    
    func setSearchCancelButtonConfig(searchTextField: UITextField){
        UISearchBar.appearance().setPositionAdjustment(UIOffset(horizontal: -100, vertical: 0), for: .clear)
    }
    
    func setSomeTextFieldCustomizations(){
        self.backgroundColor = UIColor.clear
        searchTField = searchTextField
        searchTField?.placeholder = "Country, capital or region"
        searchTField?.leftView = .none

        NSLayoutConstraint.activate([
            searchTextField.widthAnchor.constraint(equalTo: self.widthAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: 50),
            searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            searchTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
        ])
        searchTextField.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.92)
        searchTextField.textColor = .systemGray
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            guard let image = UIImage(named:"search28") else { return }
            let tintedImage = image.withRenderingMode(.alwaysTemplate)
            self.setRightImage(tintedImage, searchTextField: (self.searchTField)!, imageColor: .gray)
            let borderBottom = CALayer()
            let borderWidth = CGFloat(1.0)
            borderBottom.borderColor = UIColor.systemGray3.cgColor
            let x:CGFloat = (self.searchTField?.rightView?.frame.width ?? 0) - 15
            let y = (self.searchTField?.frame.height ?? 0) - 1
            let width = (self.searchTField?.frame.width ?? 0) - ((self.searchTField?.rightView?.frame.width ?? 0) * 2)
            let height:CGFloat = 1.0
            borderBottom.frame = CGRect(
                x: x,
                y: y,
                width: width,
                height: height)
            borderBottom.borderWidth = borderWidth
            self.searchTField?.layer.addSublayer(borderBottom)
                
        }
    }
    
    func setNoResultsMessageSearch(viewController:UIViewController){
        let alert = UIAlertController(title: "No results", message: "Try another term", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
        self.text = ""
    }
        
    
}
