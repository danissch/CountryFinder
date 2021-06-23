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

//typealias CountryModel = [CountryModelElement]





//
//// MARK: - CountryModel
//struct CountryModel: Codable {
//    let name: String
//    let topLevelDomain: [TopLevelDomain]
//    let alpha2Code, alpha3Code: String
//    let callingCodes: [CallingCode]
//    let capital: String
//    let altSpellings: [[String: String]]
//    let region, subregion: String
//    let population: Int
//    let latlng: [[String: Int]]
//    let demonym: String
//    let area: Int
//    let gini: Double
//    let timezones: [CallingCode]
//    let borders: [[String: String]]
//    let nativeName, numericCode: String
//    let currencies: [CallingCode]
//    let languages: [[String: String]]
//    let translations: [Translation]
//    let relevance: String
//}
//
//struct TopLevelDomain:Codable {
//    let the0: String
//
//    enum CodingKeys: String, CodingKey {
//        case the0 = "0"
//    }
//}
//// MARK: - CallingCode
//struct CallingCode: Codable {
//    let the0: String
//
////    enum CodingKeys: String, CodingKey {
////        case the0 = "0"
////    }
//}
//
//// MARK: - Translation
//struct Translation: Codable {
//    let de, es, fr, ja: String?
//    let it: String?
//}








//
//struct CountryModel: Decodable {
//
//    let name: String
//    let topLevelDomain: [[String: String]]
//    let alpha2Code, alpha3Code: String
//    let callingCodes: [[String: String]]
//    let capital: String
//    let altSpellings: [[String: String]]
//    let region, subregion: String
//    let population: Int
//    let latlng: [[String: Int]]
//    let demonym: String
//    let area: Int
//    let gini: Double
//    let timezones: [[String: String]]
//    let borders: [[String: String]]
//    let nativeName, numericCode: String
//    let currencies: [[String: String]]
//    let languages: [[String: String]]
//    let translations: [[String: String]]
//    let relevance: String
//
//    enum CodingKeys: String, CodingKey {
//        case name
//        case topLevelDomain
//        case alpha2Code, alpha3Code
//        case callingCodes
//        case capital
//        case altSpellings
//        case region, subregion
//        case population
//        case latlng
//        case demonym
//        case area
//        case gini
//        case timezones
//        case borders
//        case nativeName, numericCode
//        case currencies
//        case languages
//        case translations
//        case relevance
//    }
//
//}

