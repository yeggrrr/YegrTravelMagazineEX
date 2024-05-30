//
//  RestaurantMapViewController.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/30/24.
//

import UIKit
import MapKit

enum CategoryType: Int {
    case all = 0
    case korean
    case cafe
    case snack
    case chinese
    case japan
    case western
    case lightWastern
}

class RestaurantMapViewController: UIViewController {
    @IBOutlet var restaurantMapView: MKMapView!
    @IBOutlet var categorySegmentControl: UISegmentedControl!
    
    let categoryList: [(category: String, type: CategoryType)] = [
        ("전체", .all),
        ("한식", .korean),
        ("카페", .cafe),
        ("분식", .snack),
        ("중식", .chinese),
        ("일식", .japan),
        ("양식", .western),
        ("경양식", .lightWastern)
    ]
    
    var categoryType: CategoryType = .all
    let restaurantList = RestaurantList.restaurantArray
    var restaurantInfo: [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationUI()
        setSegmentControll()
    }
        
    func navigationUI() {
        navigationController?.navigationBar.tintColor = UIColor(named: "ButtonColor")
        
        let right = UIBarButtonItem(image: UIImage(systemName: "location.fill"), style: .plain, target: self, action: #selector(filterButtonClicked))
        navigationItem.rightBarButtonItem = right
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "ButtonColor")
    }
    
    func CurrentLocation() {
        let currentLocation = CLLocationCoordinate2D(latitude: 37.517742, longitude: 126.886463)
        restaurantMapView.region = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 300, longitudinalMeters: 300)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = currentLocation
        annotation.title = "내 위치"
        restaurantMapView.addAnnotation(annotation)
        categorySegmentControl.selectedSegmentIndex = 0
    }
    
    func setSegmentControll() {
        categorySegmentControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
    }
    
    func setLocation(latitude: Double, longitude: Double, name: String ) {
        let currentLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        restaurantMapView.region = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 400, longitudinalMeters: 400)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = currentLocation
        annotation.title = "\(name)"
        restaurantMapView.addAnnotation(annotation)
    }
    
    func updateMap() {
        if categoryType == .all {
            restaurantInfo = RestaurantList.restaurantArray
        } else {
            for item in categoryList {
                if categoryType == item.type {
                    restaurantInfo = RestaurantList.restaurantArray.filter{ $0.category == item.category }
                    break
                }
            }
        }
        
        restaurantMapView.removeAnnotations(restaurantMapView.annotations)
        for item in restaurantInfo {
            setLocation(latitude: item.latitude, longitude: item.longitude, name: item.name)
        }
    }
    
    @objc func filterButtonClicked() {
        CurrentLocation()
    }
    
    @objc func segmentValueChanged(segment: UISegmentedControl) {
        let index = segment.selectedSegmentIndex
        if let type = CategoryType(rawValue: index) {
            categoryType = type
        } else {
            categoryType = .all
        }
        
        updateMap()
    }
}
