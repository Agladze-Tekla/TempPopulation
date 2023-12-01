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
    
    private let searchBar = UISearchBar()
    
    private let tableView = UITableView()

    private let viewModel = PopulationViewModel()
    
    private var suggestions: [String] = []
    
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
        setupSearchController()
        setupSearchTableView()
        addSubviews()
        setupConstraints()
    }
    
    private func setupBackground() {
        view.backgroundColor = .black
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
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
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    tableView.topAnchor.constraint(equalTo: view.topAnchor),
                    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                ])
    }
    
    private func setupSearchController() {
        searchBar.delegate = self
        searchBar.placeholder = "Search Country"
        navigationItem.titleView = searchBar
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelSearch))
    }
    
    private func setupSearchTableView() {
        tableView.dataSource = self
    }
    
    private func setupViewModelDelegate() {
        viewModel.delegate = self
    }
    
    // MARK: - Actions
        @objc private func cancelSearch() {
            if let searchBar = navigationItem.titleView as? UISearchBar {
                searchBar.text = ""
                searchBar.resignFirstResponder()
            }
            suggestions.removeAll()
            tableView.reloadData()
        }
}

// MARK: - Exstensions
extension PopulationViewController: PopulationViewModelDelegate {
    func suggestionFetched(_ countries: [String]) {
        suggestions = countries
    }
    
    func populationFetched(_ population: [TotalPopulation]) {
        DispatchQueue.main.async {
            //self.populationTodayNumberLabel.text =
            print("It's working")
        }
    }
    
    func showError(_ error: Error) {
        print("Error")
    }
}

// MARK: - UISearchBarDelegate Extension
extension PopulationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        suggestions = suggestions.filter { $0.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource Extension

extension PopulationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
                cell.textLabel?.text = suggestions[indexPath.row]
                return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestions.count
    }
}
