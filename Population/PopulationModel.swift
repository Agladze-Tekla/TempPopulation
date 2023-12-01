//
//  PopulationModel.swift
//  Population
//
//  Created by Tekla on 11/30/23.
//

import Foundation

// Mark: - CountryModel
struct CountryModel: Decodable {
    let countries: [String]
}

// MARK: - PopulationResultModel
struct PopulationResponse: Decodable {
    let totalPopulation: [TotalPopulation]

    enum CodingKeys: String, CodingKey {
        case totalPopulation = "total_population"
    }
}

// MARK: - TotalPopulation
struct TotalPopulation: Decodable {
    let date: String
    let population: Int
}
