//
//  PopulationViewModel.swift
//  Population
//
//  Created by Tekla on 11/30/23.
//

import Foundation
import GenericNetworkLayer

protocol PopulationViewModelDelegate: AnyObject {
    func populationTodayFetched(_ population: TotalPopulation)
    func populationTomorrowFetched(_ population: TotalPopulation)
    func suggestionFetched(_ countries: [String])
    func showError(_ error: Error)
}

final class PopulationViewModel {
    
    weak var delegate: PopulationViewModelDelegate?
    
    func viewTodayDidLoad(countryName: String) {
        fetchPopulationTodayData(countryName: countryName)
    }
    
    func viewTomorrowDidLoad(countryName: String) {
        fetchPopulationTomorrowData(countryName: countryName)
    }
    
    private func fetchPopulationTodayData(countryName: String) {
        guard let url = URL(string: "https://d6wn6bmjj722w.population.io:443/1.0/population/\(countryName)/2023-12-01/") else { return }
        
        NetworkManager().request(with: url) { [weak self] (result: Result<PopulationResponse, Error>) in
            switch result {
            case .success(let response):
                self?.delegate?.populationTodayFetched(response.totalPopulation)
            case .failure(let failure):
                print(failure.localizedDescription)
                break
            }
        }
    }
    
    private func fetchPopulationTomorrowData(countryName: String) {
        guard let url = URL(string: "https://d6wn6bmjj722w.population.io:443/1.0/population/\(countryName)/2023-12-02/") else { return }
        
        NetworkManager().request(with: url) { [weak self] (result: Result<PopulationResponse, Error>) in
            switch result {
            case .success(let response):
                self?.delegate?.populationTomorrowFetched(response.totalPopulation)
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

 
