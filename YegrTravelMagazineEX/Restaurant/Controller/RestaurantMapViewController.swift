//
//  RestaurantMapViewController.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/30/24.
//

import UIKit
import MapKit
import CoreLocation

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
    
    let locationManager = CLLocationManager()
    
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
    var locationStatus: CLAuthorizationStatus?
    var mycoordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationUI()
        setSegmentControll()
        setInitialMap()
        configureLocation()
        checkCurrentLocationAuthorization()
    }
    
    func configureLocation() {
        locationManager.delegate = self
        restaurantMapView.showsUserLocation = true
        restaurantMapView.setUserTrackingMode(.follow, animated: true)
    }
        
    func navigationUI() {
        navigationController?.navigationBar.tintColor = UIColor(named: "ButtonColor")
        
        let right = UIBarButtonItem(image: UIImage(systemName: "location.fill"), style: .plain, target: self, action: #selector(loactionBarButtonClicked))
        navigationItem.rightBarButtonItem = right
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "ButtonColor")
    }
    
    func sesacLocation() {
        let sesacLocation = CLLocationCoordinate2D(latitude: 37.517742, longitude: 126.886463)
        restaurantMapView.region = MKCoordinateRegion(center: sesacLocation, latitudinalMeters: 300, longitudinalMeters: 300)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = sesacLocation
        annotation.title = "SeSAC 영등포 캠퍼스"
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
    
    func setInitialMap() {
        restaurantInfo = RestaurantList.restaurantArray
        for item in restaurantInfo {
            setLocation(latitude: item.latitude, longitude: item.longitude, name: item.name)
        }
    }
    
    func alert(title: String, message: String, cancelHandler: UIAlertAction, okHandler: UIAlertAction) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = okHandler
        let cancelButtion = cancelHandler
        
        alert.addAction(okButton)
        alert.addAction(cancelButtion)
        present(alert, animated: true)
    }
    
    @objc func loactionBarButtonClicked() {
        guard let locationStatus = locationStatus else { return }
        switch locationStatus {
        case .notDetermined, .restricted, .denied:
            alert(
                title: "위치 서비스를 사용할 수 없습니다.",
                message: "'설정 > 개인정보 보호'에서\n위치 서비스를 켜주세요.(필수권한)",
                cancelHandler: UIAlertAction(title: "취소", style: .cancel),
                okHandler: UIAlertAction( title: "설정으로 이동", style: .default) { _ in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
            )
        default:
            guard let mycoordinate = mycoordinate else { return }
            setRegionAndAnnotation(center: mycoordinate)
        }
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

extension RestaurantMapViewController {
    func checkDeviceLocationAuthorization() {
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization()
        } else {
            alert(title: "위치 서비스가 꺼져 있어서, 위치 권한을 요청할 수 없습니다.", message: "", cancelHandler: UIAlertAction(title: "취소", style: .cancel), okHandler: UIAlertAction(title: "설정으로 이동", style: .default, handler: { _ in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
        }
    }
    
    func checkCurrentLocationAuthorization() {
        
        if #available(iOS 14.0, *) {
            locationStatus = locationManager.authorizationStatus
        } else {
            locationStatus = CLLocationManager.authorizationStatus()
        }
        
        switch locationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            sesacLocation()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            print(#function)
        }
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 300, longitudinalMeters: 300)
        restaurantMapView.setRegion(region, animated: true)
    }
}

extension RestaurantMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate)
            mycoordinate = coordinate
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function, "iOS14+")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, "iOS14-")
        checkDeviceLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function, "iOS14+")
    }
}
