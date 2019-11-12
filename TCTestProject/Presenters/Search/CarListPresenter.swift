//
//  CarListPresenter.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 10/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import UIKit

protocol CarListViewContract:NSObjectProtocol {
    func didLoadCars()
    func didFailLoadingCars(error:Error?)
    func didUpdateCars(searchText:String?)
}

class CarListPresenter: NSObject {
    private let service:CarListService
    private weak var delegate:CarListViewContract?
    var isFiltering:Bool = false
    var filteredCarDataSources:[Car]?
    var carDataSources:[Car]?
    weak var viewController:CarListViewController?
    
    init(service:CarListService) {
        self.service = service
    }
    
    func setDelegate(delegate:CarListViewContract?) {
        self.delegate = delegate
    }
    
    func loadAllCars() {
        self.service.getAllCars { [weak self] (cars, error) in
            DispatchQueue.main.async {
                self?.carDataSources = cars
                if (error != nil) {
                    self?.delegate?.didFailLoadingCars(error: error!)
                }
                else {
                    self?.delegate?.didLoadCars()
                }
            }
        }
    }
    
    func filterCars(searchText:String?) {
        guard let searchText = searchText, searchText != "" else {
            self.isFiltering = false
            self.delegate?.didLoadCars()
            return
        }
        self.isFiltering = true
        self.filteredCarDataSources = self.carDataSources!.filter { (car: Car) -> Bool in
            return ((car.make?.lowercased().contains(searchText.lowercased()))! || (car.model?.lowercased().contains(searchText.lowercased()))!)
        }
        self.delegate?.didUpdateCars(searchText: searchText)
    }
    
    func didSelectCarAtIndex(index:Int) {
        let carDetailVC:CarDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CarDetailViewController") as! CarDetailViewController
        if self.isFiltering {
            carDetailVC.car = self.filteredCarDataSources![index]
        }
        else {
            carDetailVC.car = self.carDataSources![index]
        }
        self.viewController?.navigationController?.pushViewController(carDetailVC, animated: true)
    }
}
