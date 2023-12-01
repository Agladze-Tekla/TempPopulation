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
        stack.spacing = 110
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let todayStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 50
        return stack
    }()
    
    private let tomorrowStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 50
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
    
    private let todayDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private let tomorrowDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private let searchBar = UISearchBar()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private let viewModel = PopulationViewModel()
    
    private var suggestions: [String] = []
    
    private var searchCountry = ""
    
    private let today = "2023-12-01"
    
    private let tomorrow = "2023-12-02"
    
    private var todayPopulation = ""
    
    private var tomorrowPopulation = ""
    
    //MARK: - ViewLifeCycle()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModelDelegate()
    }
    
    //MARK: - Private Methods
    private func setupView() {
        setupBackground()
        setupSearchController()
        setupSearchTableView()
        addSubviews()
        setupConstraints()
        viewModel.fetchSuggestions()
    }
    
    private func setupBackground() {
        view.backgroundColor = .black
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(todayStackView)
        mainStackView.addArrangedSubview(tomorrowStackView)
        addTodaySubviews()
        addTomorrowSubviews()
    }
    
    private func addTodaySubviews() {
        todayStackView.addArrangedSubview(populationTodayLabel)
        todayStackView.addArrangedSubview(todayDateLabel)
        todayStackView.addArrangedSubview(populationTodayNumberLabel)
    }
    
    private func addTomorrowSubviews() {
        tomorrowStackView.addArrangedSubview(populationTomorrowLabel)
        tomorrowStackView.addArrangedSubview(tomorrowDateLabel)
        tomorrowStackView.addArrangedSubview(populationTomorrowNumberLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        setupTableViewConstraints()
    }
    
    private func setupTableViewConstraints() {
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
        tableView.delegate = self
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "Country")
    }
    
    private func setupViewModelDelegate() {
        viewModel.delegate = self
    }
    
    private func fetchInfo() {
        viewModel.viewDidLoad(countryName: searchCountry, date: today)
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
        self.suggestions = countries
        print(suggestions)
    }
    
    func populationFetched(_ population: TotalPopulation) {
        DispatchQueue.main.async {
            //TODO: - Fix label information.
            self.todayDateLabel.text = "Date: \(self.today)"
            self.tomorrowDateLabel.text = "Date: \(self.tomorrow)"
            self.populationTodayNumberLabel.text = "Population : \((population.population))"
            self.populationTomorrowNumberLabel.text = "Population: \(String(population.population))"
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
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        tableView.isHidden = true
        searchCountry = searchBar.text ?? ""
        fetchInfo()
        }
}

// MARK: - UITableViewDataSource Extension
extension PopulationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: - Fix TableViewCell
        //let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath) as? CountryTableViewCell else {
            fatalError("Could not dequeue NewsCell") }
        //cell.textLabel?.text = suggestions[indexPath.row]
        cell.configure()//suggestions[indexPath.row])
            return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 160
        }
}

