//
//  PopulationViewModel.swift
//  Population
//
//  Created by Tekla on 11/30/23.
//

import Foundation
import GenericNetworkLayer

protocol PopulationViewModelDelegate: AnyObject {
    func populationFetched(_ population: [TotalPopulation])
    func showError(_error: Error)
}

final class PopulationViewModel {
    
    weak var delegate: PopulationViewModelDelegate?
    
    func viewDidLoad(countryName: String) {
        fetchPopulation(countryName: countryName)
    }
    
    private func fetchPopulation(countryName: String) {
        guard let url = URL(string: "https://d6wn6bmjj722w.population.io:443/1.0/population/\(countryName)/today-and-tomorrow/") else { return }
        
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
}
