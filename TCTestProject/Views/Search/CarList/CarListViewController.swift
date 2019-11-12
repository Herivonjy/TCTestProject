//
//  CarListViewController.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 10/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import UIKit

class CarListViewController: UIViewController {
    private let carPresenter = CarListPresenter(service: CarListService())
    @IBOutlet weak var carsTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setup()
        //self.registerKeyBoardObserver()
    }
    
    func setup() {
        self.title = carListTitle
        self.carPresenter.viewController = self
        self.carPresenter.setDelegate(delegate: self)
        self.carPresenter.loadAllCars()
        self.searchBar.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.unregisterKeyBoardObserver()
    }
}

//MARK: - CarListViewContract Delegate

extension CarListViewController:CarListViewContract {
    func didFailLoadingCars(error: Error?) {
        print("didFailLoadingCars : \(String(describing: error))")
    }
    
    func didUpdateCars(searchText: String?) {
        self.carsTableView.reloadData()
    }
    
    func didLoadCars() {
        // print("\(cars as Any)\n ResultCount : \(String(describing: cars?.count))")
        self.carsTableView.reloadData()
    }
}

//MARK: - TaleView Delegate

extension CarListViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.carPresenter.isFiltering {
            return self.carPresenter.filteredCarDataSources?.count ?? 0
        }
        return self.carPresenter.carDataSources?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarListCellIdentifier")! as! CarListCell
        let car = (self.carPresenter.isFiltering) ? self.carPresenter.filteredCarDataSources![indexPath.row] : self.carPresenter.carDataSources![indexPath.row]
        cell.setup(car: car, searchText: searchBar.text)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.carPresenter.didSelectCarAtIndex(index: indexPath.row)
    }
}

//MARK: - SearchBar Delegate
extension CarListViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText : \(searchText)")
        self.carPresenter.filterCars(searchText: searchText)
    }
}

