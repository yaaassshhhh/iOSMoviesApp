//
//  LocationService.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 10/07/25.
//

import Foundation
import CoreLocation
import MapKit

protocol LocationServiceDelegate : AnyObject {
    func didUpdateLocation(_ loc : String)
    func didUpdateAuthorizationStatus(_ status : CLAuthorizationStatus)
}

class LocationService : NSObject, CLLocationManagerDelegate {
   private let locationManager = CLLocationManager()
    weak var delegate : LocationServiceDelegate?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyReduced
    }
    
    func requestLocationAccess() {
        print("Inside request location access")
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        print("Inside start updating location for location access")
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        print("Inside stop updating location for location access")
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let lastLocation = locations.last {
                
                let lat = lastLocation.coordinate.latitude
                let lon = lastLocation.coordinate.longitude
                print("lat and lon IS \(lat) \(lon)")
                getCityAndCountry(lat, lon){ locationName in
                    self.delegate?.didUpdateLocation(locationName)
                }
            }
    }
   
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            let status = manager.authorizationStatus
            delegate?.didUpdateAuthorizationStatus(status)
        }
    
    func getCityAndCountry(_ lat : Double,_ long : Double, completion : @escaping (String) -> Void ) {
        print("Inside getCityAndCountry")
        let location = CLLocation(latitude: lat, longitude: long)
        
        location.fetchCityAndCountry { city, country, error in
            guard let city = city, let country = country, error == nil else {
                completion("Unknown Location")
                return
            }
            completion("\(city), \(country)")
        }
    }
}

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        print("inside fetch city and country")
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
