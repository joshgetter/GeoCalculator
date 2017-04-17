//
//  Weather.swift
//  GeoCalculator
//
//  Created by Josh Getter on 4/17/17.
//  Copyright © 2017 Josh Getter. All rights reserved.
//

import Foundation

struct Weather {
    var iconName : String
    var temperature : Double
    var summary : String
    init(iconName: String, temperature: Double, summary: String) {
        self.iconName = iconName
        self.temperature = temperature
        self.summary = summary
    }
}
protocol WeatherService {
    func getWeatherForDate(date: Date, forLocation location: (Double, Double),
                           completion: @escaping (Weather?) -> Void)
}
let sharedDarkSkyInstance = DarkSkyWeatherService()
class DarkSkyWeatherService: WeatherService {
    
    let API_BASE = "https://api.darksky.net/forecast/"
    let API_KEY = "4793f0a231bb37bcbedb12ca0eacb1cf"
    var urlSession = URLSession.shared
    
    class func getInstance() -> DarkSkyWeatherService {
        return sharedDarkSkyInstance
    }
    
    func getWeatherForDate(date: Date, forLocation location: (Double, Double),
                           completion: @escaping (Weather?) -> Void)
    {
        // TODO: concatentate the complete endpoint URL here.
        let urlStr = API_BASE + API_KEY + "/\(location.0),\(location.1)"
        let url = URL(string: urlStr)
        
        let task = self.urlSession.dataTask(with: url!) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let _ = response {
                let parsedObj : Dictionary<String,AnyObject>!
                do {
                    parsedObj = try JSONSerialization.jsonObject(with: data!,
                                                                 options:
                        .allowFragments) as? Dictionary<String,AnyObject>
                    
                    guard let currently = parsedObj["currently"]
                    // TODO: extract the attributes you need for a Weather instance HERE
                    else {
                        completion(nil)
                        return
                    }
                    let summary = currently["summary"]
                    let iconName = currently["icon"]
                    let temperature = currently["temperature"]
                    let weather = Weather(iconName: iconName as! String, temperature:
                        temperature as! Double,
                                          summary: summary as! String)
                    completion(weather)
                    
                } catch {
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
}
