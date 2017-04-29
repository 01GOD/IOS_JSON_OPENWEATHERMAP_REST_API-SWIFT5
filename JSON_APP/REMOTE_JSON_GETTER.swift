//
//  REMOTE_JSON_GETTER.swift
//  JSON_APP
//
//  Created by GOD on 3/31/17.
//  Copyright © 2017 ALL ONE SUN. All rights reserved.
//

import Foundation

class REMOTE_JSON_GETTER {
    // MARK: Constants and variables
    // -----------------------------------
    //Temp value stored from getWeather
    var tempDouble:Double?=nil
    //URL
    let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    //API Key
    let openWeatherMapAPIKey = "06663241e2affc7c1eaa4d87168f4b3c"
    //Temp units
    var units="metric"
    //enum units: String {
    //        case c = "metric"
    //        case f = "imperial"}
    
    // MARK: Main JSON retreiver and parser
    // -----------------------------------
    func getWeather(city: String) {
        
        //URL string parsed from the input...includes the "space" to %20 workaround "addingPercentEncoding" for city names with a space
        let urlString = "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&units=\(units)&q=\(city.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)"
        print(urlString)
        //Make an NSURL object from the string
        let url = URL(string: urlString)!
        //print(url)
        //let url = URL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&units=\(units)&q=\(city)")!
        //print(url)
        
        //Make a URL session to open http communication with a server
        URLSession.shared.dataTask(with:url){ (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    //Make a temp var to hold the JSON temp data
                    var temp:Double=0.0
                    //Parse the
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    //Convert to dictionary
                    let main = parsedData["main"] as? NSDictionary
                    //Convert dictionary
                    temp = (main?["temp"] as? Double)!
                    //Some print statements for to verify data looks proper
                    print(type(of:temp))
                    print(temp)
                    
                    //Assign temp to the class tempDouble var outside the function
                    self.tempDouble = temp
                    //Broadcast a message for the other class to hear to update the labels
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update"), object: nil)
                }
                catch let error as NSError{
                    print(error)
                }
            }
            
            }.resume()
        //print(self.tempDouble)
    }
}

