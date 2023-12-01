//
//  PopulationViewController.swift
//  Population
//
//  Created by Tekla on 11/30/23.
//

import UIKit

final class PopulationViewController: UIViewController{
  
    //MARK: - Private Properties
    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 130
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let todayStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 60
        return stack
    }()
    
    private let tomorrowStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 60
        return stack
    }()
    
    private let populationTodayLabel: UILabel = {
        let label = UILabel()
        label.text = "Population Today:"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    private let populationTomorrowLabel: UILabel = {
        let label = UILabel()
        label.text = "Population Tomorrow:"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    private let populationTodayNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Population Tomorrow:"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private let populationTomorrowNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Population Tomorrow:"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private let viewModel = PopulationViewModel()
    
    //MARK: - ViewLifeCycle()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModelDelegate()
        viewModel.viewDidLoad(countryName: "Brazil")
    }
    
    //MARK: - Private Methods
    private func setupView() {
        setupBackground()
        addSubviews()
        setupConstraints()
    }
    
    private func setupBackground() {
        view.backgroundColor = .black
    }
    
    private func addSubviews() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(todayStackView)
        mainStackView.addArrangedSubview(tomorrowStackView)
        todayStackView.addArrangedSubview(populationTodayLabel)
        todayStackView.addArrangedSubview(populationTodayNumberLabel)
        tomorrowStackView.addArrangedSubview(populationTomorrowLabel)
        tomorrowStackView.addArrangedSubview(populationTomorrowNumberLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupViewModelDelegate() {
        viewModel.delegate = self
    }
}

// MARK: - Exstensions
extension PopulationViewController: PopulationViewModelDelegate {
    func populationFetched(_ population: [TotalPopulation]) {
        DispatchQueue.main.async {
            //self.populationTodayNumberLabel.text =
            print("It's working")
        }
    }
    
    func showError(_error: Error) {
        print("Error")
    }
    
    
}
