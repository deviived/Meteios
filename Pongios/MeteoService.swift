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
    
    var myDictionary: [String:AnyObject]?
    
    init() {
        <#statements#>
    }
    
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
    
    func getForecast(long: Double,lat: Double) -> Dictionary<String,AnyObject>? {
        Alamofire.request("https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(long)&APPID=16d6b1edb4636445686eb747a444bb7e")
            .responseJSON { response in
                if let data = response.data, let _ = String(data: data, encoding: .utf8) {
                    
                    do {
                        let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                        if let myDictionary = dict
                        {
                            
                        }
                        
                    } catch {
                        print("error alamofire request")
                    }
                    
                }
        }
        return myDictionary
    }
}
