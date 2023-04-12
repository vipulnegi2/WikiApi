//
//  MainViewController.swift
//  Hive
//
//  Created by Vipul Negi on 10/04/23.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var searchBarView: UISearchBar!
    
    lazy var viewModel = {
        ResultsViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        resultTableView.dataSource = self
        resultTableView.allowsSelection = false
        resultTableView.separatorColor = .gray
        resultTableView.bounces = false
        resultTableView.register(ResultTableViewCell.nib, forCellReuseIdentifier: ResultTableViewCell.identifier)
    }
    
    func initViewModel(searchText: String) {
        viewModel.getResults(str: searchText)
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.resultTableView.reloadData()
            }
        }
    }
    
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        initViewModel(searchText: searchText)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.resultCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as? ResultTableViewCell else { fatalError("xib does not exists") }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        if cellVM.imageUrl.isEmpty {
            cell.titleLeadingConstraint.constant = 0.0
        } else {
            cell.titleLeadingConstraint.constant = 20.0
        }
        cell.cellViewModel = cellVM
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Results"
    }

    
}
