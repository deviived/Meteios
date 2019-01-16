//
//  ViewController.swift/Users/pachecoluc/__DEV/Pongios/Pongios/ViewController.swift
//  Pongios
//
//  Created by PACHECO Luc on 14/01/2019.
//  Copyright © 2019 PACHECO Luc. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    let WEATHER_IMG = [
        "clear sky": "summer.png",
        "few clouds": "cloud.png",
        "scattered clouds": "cloud.png",
        "broken clouds": "cloudy-night.png",
        "shower rain": "rainy.png",
        "rain": "rainy.png",
        "thunderstorm": "lightning.png",
        "snow": "snow",
        "mist": "misty.png"
    ]
    
    let locManager = CLLocationManager()
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /* initialize location */
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        
        temp.text = "0°C"
    }
    
    func callApi(long: Double,lat: Double) {
        Alamofire.request(
            "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&APPID=16d6b1edb4636445686eb747a444bb7e")
            .responseJSON { response in
                //print(response)
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    
                    do {
                        let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                        if let myDictionary = dict
                        {
                            if let temp = myDictionary["main"]?["temp"] as? Double {
                                let tempC = temp - 273.15
                                self.temp.text = "\(Int(tempC))°C"
                            }
                            if let myCity = myDictionary["name"] as? String {
                                self.city.text = "\(myCity)"
                            }
                            if let weather = myDictionary["weather"] as? [[String: Any]] {
                                if let weather_item = weather[0]["description"] as? String {
                                    var imgName = "summer.png"
                                    if let kExist = self.WEATHER_IMG[weather_item] {
                                        imgName = self.WEATHER_IMG[weather_item]!
                                    }
                                    self.image = UIImage(named: imgName)
                                    self.weatherImage.image = self.image
                                    
                                }
                                
                            }
                        }
                        
                    } catch {
                        
                    }
                    
                }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let loc = locations.last!
        
        print("\(loc.coordinate.latitude) \(loc.coordinate.longitude)")
        callApi(long: loc.coordinate.longitude, lat: loc.coordinate.latitude)
    }
    
    func showAngryAlert() {
        let alert = UIAlertController()
        
        alert.title = "Angry react only \u{1F621}"
        alert.message = "Why do you do this ? Whyyyyyyyy ? \u{1F622}\u{1F622}\u{1F622}\u{1F622}"
        present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                guard let url = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                UIApplication.shared.open(url)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .restricted, .denied:
            showAngryAlert()
            break
        default:
            break;
        }
    }
    
    @IBOutlet weak var city: UITextView!
    @IBOutlet weak var temp: UITextView!
    
    @IBOutlet weak var weatherImage: UIImageView!
    
}

