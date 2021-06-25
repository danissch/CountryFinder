//
//  CountryDetailViewController.swift
//  CountryFinder
//
//  Created by Daniel Duran Schutz on 23/06/21.
//

import Foundation
import UIKit
import MapKit

class CountryDetailViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    private var country: CountryModel?
    @IBOutlet weak var centerCountryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.country?.name
        mapView.delegate = self
        backButton()
        
        centerCountryButton.layer.cornerRadius = centerCountryButton.frame.height / 2
        centerCountryButton.backgroundColor = UIColor.lightGray
        centerCountryButton.setTitleColor(.white, for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.setLocation()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func centerCountryButtonAction(_ sender: Any) {
        setLocation()
    }
    
    func setCountryDetail(country: CountryModel){
        self.country = country
    }
    
    private func processLocation() ->  CLLocation {
        let latlng = country?.latlng
        guard let latt = latlng?[0] else { return CLLocation() }
        guard let long = latlng?[1] else { return CLLocation() }
        let initialLocation = CLLocation(latitude: latt, longitude: long)
        return initialLocation
    }

    private func setCenterCoordinate(coordinate: CLLocationCoordinate2D, zoomLevel: Int, animated: Bool) {
        let span = MKCoordinateSpan(latitudeDelta: 0,
                                    longitudeDelta: 360 / pow(2, Double(zoomLevel)) * Double(mapView.frame.size.width) / 256)
        mapView.setRegion(MKCoordinateRegion(center: coordinate, span: span),
                          animated: animated)
    }
    
    private func setLocation(){
        self.setCenterCoordinate(coordinate: CLLocationCoordinate2D(latitude: self.processLocation().coordinate.latitude, longitude: self.processLocation().coordinate.longitude), zoomLevel: 5, animated: true)
    }
    
}
