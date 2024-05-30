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
    }
    
    func setSegmentControll() {
        categorySegmentControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
    }
    
    func setLocation(latitude: Double, longitude: Double, name: String ) {
        let currentLocation = CLLocationCoordinate2D(latitude: latitude, longitude: latitude)
        restaurantMapView.region = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 500, longitudinalMeters: 500)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = currentLocation
        annotation.title = "\(name)"
        restaurantMapView.addAnnotation(annotation)
    }
    
    func updateMap() {
            switch categoryType {
            case .all:
                restaurantInfo = RestaurantList.restaurantArray
            case .korean:
                restaurantInfo = RestaurantList.restaurantArray.filter{ $0.category == "한식"}
            case .cafe:
                restaurantInfo = RestaurantList.restaurantArray.filter{ $0.category == "카페"}
            case .snack:
                restaurantInfo = RestaurantList.restaurantArray.filter{ $0.category == "분식"}
            case .chinese:
                restaurantInfo = RestaurantList.restaurantArray.filter{ $0.category == "중식"}
            case .japan:
                restaurantInfo = RestaurantList.restaurantArray.filter{ $0.category == "일식"}
            case .western:
                restaurantInfo = RestaurantList.restaurantArray.filter{ $0.category == "양식"}
            case .lightWastern:
                restaurantInfo = RestaurantList.restaurantArray.filter{ $0.category == "경양식"}
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
        switch segment.selectedSegmentIndex {
        case 0:
            categoryType = .all
        case 1:
            categoryType = .korean
        case 2:
            categoryType = .cafe
        case 3:
            categoryType = .snack
        case 4:
            categoryType = .chinese
        case 5:
            categoryType = .japan
        case 6:
            categoryType = .western
        case 7:
            categoryType = .lightWastern
        default:
            break
        }
        updateMap()
    }

}
