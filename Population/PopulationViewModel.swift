//
//  PopulationViewModel.swift
//  Population
//
//  Created by Tekla on 11/30/23.
//

import Foundation
import GenericNetworkLayer

protocol PopulationViewModelDelegate: AnyObject {
    func populationFetched(_ population: TotalPopulation)
    func suggestionFetched(_ countries: [String])
    func showError(_ error: Error)
}

final class PopulationViewModel {
    
    weak var delegate: PopulationViewModelDelegate?
    
    func viewDidLoad(countryName: String, date: String) {
        fetchPopulationData(countryName: countryName, date: date)
    }
    
    private func fetchPopulationData(countryName: String, date: String) {
        guard let url = URL(string: "https://d6wn6bmjj722w.population.io:443/1.0/population/\(countryName)/\(date)/") else { return }
        
        NetworkManager().request(with: url) { [weak self] (result: Result<PopulationResponse, Error>) in
            switch result {
            case .success(let response):
                self?.delegate?.populationFetched(response.totalPopulation)
            case .failure(let failure):
                print(failure.localizedDescription)
                break
            }
        }
    }
    
    func fetchSuggestions() {
        guard let url = URL(string: "https://d6wn6bmjj722w.population.io:443/1.0/countries") else { return }
        
        NetworkManager().request(with: url) { [weak self] (result: Result<CountryModel, Error>) in
            switch result {
            case .success(let response):
                self?.delegate?.suggestionFetched(response.countries)
            case .failure(let failure):
                print(failure.localizedDescription)
                break
            }
        }
    }
    
}

 
