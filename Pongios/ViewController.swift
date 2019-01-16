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
                            // print(myDictionary);
                            if let temp = myDictionary["main"]?["temp"] as? Double {
                                let tempC = temp - 273.15
                                self.temp.text = "\(Int(tempC))°C"
                            }
                            if let myCity = myDictionary["name"] as? String {
                                self.city.text = "\(myCity)"
                            }
                            if let weather = myDictionary["weather"] as? [[String: Any]] {
                                if let weather_item = weather[0]["description"] as? String {
                                    //print(weather_item)
                                    //self.etatClimat.text = "->\(weather_item)"
                                    switch weather_item {
                                    case "clear sky":
                                        let imageName = "summer.png"
                                        self.image = UIImage(named: imageName)
                                        self.weatherImage.image = self.image
                                        break
                                    case "few clouds":
                                        let imageName = "cloud.png"
                                        self.image = UIImage(named: imageName)
                                        self.weatherImage.image = self.image
                                        break
                                    case "scattered clouds":
                                        let imageName = "cloud.png"
                                        self.image = UIImage(named: imageName)
                                        self.weatherImage.image = self.image
                                        break
                                    case "broken clouds":
                                        let imageName = "cloudy-night.png"
                                        self.image = UIImage(named: imageName)
                                        self.weatherImage.image = self.image
                                        break
                                    case "shower rain":
                                        let imageName = "rainy.png"
                                        self.image = UIImage(named: imageName)
                                        self.weatherImage.image = self.image
                                        break
                                    case "rain":
                                        let imageName = "rainy.png"
                                        self.image = UIImage(named: imageName)
                                        self.weatherImage.image = self.image
                                        break
                                    case "thunderstorm":
                                        let imageName = "lightning.png"
                                        self.image = UIImage(named: imageName)
                                        self.weatherImage.image = self.image
                                        break
                                    case "snow":
                                        let imageName = "snow.png"
                                        self.image = UIImage(named: imageName)
                                        self.weatherImage.image = self.image
                                        break
                                    case "mist":
                                        let imageName = "misty.png"
                                        self.image = UIImage(named: imageName)
                                        self.weatherImage.image = self.image
                                        break
                                    default:
                                        let imageName = "summer.png"
                                        self.image = UIImage(named: imageName)
                                        self.weatherImage.image = self.image
                                        break;
                                    }
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

