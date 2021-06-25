//
//  CountryModel.swift
//  CountryFinder
//
//  Created by Daniel Duran Schutz on 22/06/21.
//

import Foundation


// MARK: - CountryModel
struct CountryModel: Codable {
    let name: String
    let topLevelDomain: [String]
    let alpha2Code, alpha3Code: String
    let callingCodes: [String]
    let capital: String
    let altSpellings: [String]
    let region: String
    let subregion: String
    let population: Int
    let latlng: [Double]
    let demonym: String
    let area, gini: Double?
    let timezones, borders: [String]
    let nativeName: String
    let numericCode: String?
    let currencies, languages: [String]
    let translations: Translations
    let relevance: String?
}


// MARK: - Translations
struct Translations: Codable {
    let de, es, fr, ja: String?
    let it: String?
}
