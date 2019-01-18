//
//  MeteoService.swift
//  Pongios
//
//  Created by PACHECO Luc on 17/01/2019.
//  Copyright © 2019 PACHECO Luc. All rights reserved.
//

import Foundation
import Alamofire

class MeteoService{
    
    /*func callApi(long: Double,lat: Double){
        Alamofire.request(
            "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&APPID=16d6b1edb4636445686eb747a444bb7e")
            .responseJSON { response in
                //print(response)
                
                if let data = response.data, let _ = String(data: data, encoding: .utf8) {
                    
                    do {
                        let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                        if myDictionary = dict
                        {
                           
                        }
                        
                    } catch {
                        print("error alamofire request")
                    }
                    
                }
        }
        return myDictionary
        
    }*/
    
    static fileprivate func getBestMeteo(_ data: [String: [String: Int]]) -> [String: String] {
        var meteoPerDay: [String: String] = [String: String]()
        
        for (day, weathers) in data {
            var best_meteo = ("???", 0)
            for (weather, rank) in weathers {
                if rank > best_meteo.1 {
                    best_meteo = (weather, rank)
                }
            }
            meteoPerDay[day] = best_meteo.0
        }
        
        return meteoPerDay
    }
    
    static fileprivate func collectMeteoData(_ data: [[String: Any]]) -> [String: [String: Int]] {
        var daysAndWeathers: [String: [String: Int]] = [String: [String: Int]]()
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "EEEE"
        
        for item in data {
            if let dateEpoch = item["dt"] as? Double {
                let date = Date(timeIntervalSince1970: dateEpoch)
                let day = dateFormatterOutput.string(from: date)
                if let weatherInfoList = item["weather"] as? [[String: Any]] {
                    let weatherInfo = weatherInfoList.last
                    if let weather = weatherInfo?["main"] as? String {
                        guard daysAndWeathers[day] != nil else {
                            daysAndWeathers[day] = [weather: 1]
                            continue
                        }
                        let rank = daysAndWeathers[day]![weather]
                        daysAndWeathers[day]![weather] = (rank ?? 0) + 1
                    }
                }
            }
        }
        return daysAndWeathers
    }
    
    static func getForecast(long: Double,lat: Double) -> [String: String]? {
        var result: [String: String]? = ["Lundi": "Clouds", "Mardi": "Clouds", "Mercredi": "Clear", "Jeudi": "Rain", "Vendredi": "Clouds", "Samedi": "Clear"]
        
        Alamofire.request("https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(long)&APPID=16d6b1edb4636445686eb747a444bb7e")
            .responseJSON { response in
                if let data = response.data, let _ = String(data: data, encoding: .utf8) {
                    
                    do {
                        let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                        if let myDictionary = dict
                        {
                            if let mlist = myDictionary["list"] as? [[String:Any]] {
                                let daysAndWeathers = collectMeteoData(mlist)
                                result = getBestMeteo(daysAndWeathers)
                            }
                        }
                        
                    } catch {
                        print("error alamofire request")
                    }
                    
                }
        }
        return result
    }
    
    
}
