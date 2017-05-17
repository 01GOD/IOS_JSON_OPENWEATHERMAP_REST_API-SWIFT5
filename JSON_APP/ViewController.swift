//
//  ViewController.swift
//  JSON_APP
//
//  Created by GOD on 3/31/17.
//  Copyright © 2017 ALL ONE SUN. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{
    // MARK: Variables and constants
    // -----------------------------------
    //City name to search for
    var cityToSearch=""
    //Display units
    var unitsDisplay="°C"
    //Make an instance of REMOTE_JSON_GETTER class
    let JSON_BOT=REMOTE_JSON_GETTER()
    
    // MARK: Following function called by NSNotification broadcast message from REMOTE_JSON_GETTER class
    // -----------------------------------
    //Function to update labels when the NSNotification is sent from the REMOTE_JSON_GETTER class
    func updateLabels(){
        //This DispatchQueue method is to overcome one of the (sadly many) annoying problems involved in writing IOS apps that is seemingly caused by very lazy or simply underskilled apple "engineers"!!!!!!! This DispatchQueue BS is seemingly to overcome a bug in IOS where the UI was running on a background thread or something...and was updating slowly...apple is WAY overrated. UNITY IS AWESOME!!!!!!
        DispatchQueue.main.async(execute: {
            // UI Updates
            //Reformat the Double in the REMOTE_JSON_GETTER to a string with single decimal place format
            let tempString=String(format: "%.0f",self.JSON_BOT.tempDouble!)
            //print the val
            print(tempString)
            //Update the temp label
            self.temperature.text=tempString+self.unitsDisplay
            //Update the temp meter
            self.DataMeter.progress=(0.01*Float(tempString)!)
        })
        
    }
    
    // MARK: Buttons
    // -----------------------------------
    //Button to make Celsius display
    @IBAction func B1(_ sender: UIButton) {JSON_BOT.units="metric"
        unitsDisplay="°C"
        if(cityToSearch != ""){JSON_BOT.getWeather(city:self.cityToSearch)}
        
    }

    @IBOutlet var B1STYLING: UIButton!
    //Button to make imperial display
    @IBAction func B2(_ sender: UIButton) {
        JSON_BOT.units="imperial"
        unitsDisplay="°F"
        if(cityToSearch != ""){JSON_BOT.getWeather(city:self.cityToSearch)}
    }
    
    @IBOutlet var B2STYLING: UIButton!
    // MARK: Labels and text fields
    // -----------------------------------
    //Location label
    @IBOutlet var location: UILabel!
    //Temp label
    @IBOutlet var temperature: UILabel!
    //Text field to enter city name
    @IBAction func TextField(_ sender: Any) {
    }
    //Text field to enter city name
    @IBOutlet var TextFieldOutlet: UITextField!
    //Button to load data from JSON server into app
    
    // MARK: Button to update
    // -----------------------------------
    @IBAction func UPDATE(_ sender: UIButton) {
        //Get city to search from text field
        cityToSearch=TextFieldOutlet.text!
        
        //Set location label
        location.text=cityToSearch.uppercased()
        
        //Run the JSON_BOT getWeather function to get JSON data
        if(cityToSearch != ""){JSON_BOT.getWeather(city:self.cityToSearch)}
        
        //        Moved this section to updateLabels method instead
        //        Convert the double temp from json getter to string
        //        var tempString=String(format: "%.0f",self.JSON_BOT.tempDouble!)
        //
        //        //Print in console to make sure
        //        print(tempString)
        //
        //        //Set temp label text
        //        temperature.text=tempString+unitsDisplay
        //
        //        //Set progress bar data display
        //        DataMeter.progress=(0.01*Float(tempString)!)
        //
        //        //Verify again
        //        print(tempString)
    }
    
    // MARK: Meter to show a graphical view
    // -----------------------------------
    @IBOutlet var UPDATE_STYLING: UIButton!
    //Data meter
    @IBOutlet var DataMeter: UIProgressView!{
        didSet{
            //Rotate and scale the progress bar
            DataMeter.transform = CGAffineTransform(scaleX: 20, y: 2).rotated(by: CGFloat(-M_PI_2))
            
            
        }
    }
    
    // MARK: Various IOS functions
    // -----------------------------------
    //Called when text field return button is touched
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //Resign first responder to make keyboard slide out of view
        textField.resignFirstResponder()
        
        //Refer to update button comments for info on these
        cityToSearch=TextFieldOutlet.text!
        
        location.text=cityToSearch.uppercased()
        //Uncomment later
        
        if(cityToSearch != ""){JSON_BOT.getWeather(city:self.cityToSearch)}
        
        //    var tempString=String(format: "%.0f",self.JSON_BOT.tempDouble!)
        //
        //    print(tempString)
        //
        //    temperature.text=tempString+unitsDisplay
        //
        //    DataMeter.progress=(0.01*Float(tempString)!)
        //
        //    print(tempString)
        
        return true
    }
    override func viewDidLoad() {
        //location.layer.backgroundColor=UIColor.purple.cgColor
        B1STYLING.layer.cornerRadius=7;
        B2STYLING.layer.cornerRadius=7;
        UPDATE_STYLING.layer.cornerRadius=7;
        DataMeter.layer.cornerRadius=100
        //location.layer.cornerRadius=10
        //NSNotificationCenter is added here to observe (it's a "listener"...LISTENER...sigh...apple...anyway) messages broadcast and respond to any "update" message sent to it by calling the updateLabels method in this file
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabels), name: NSNotification.Name(rawValue: "update"), object: nil)
        //This is still here, simply in case necessary later
        //Call the json getter
        //JSON_BOT.getWeather(city:self.cityToSearch)
        super.viewDidLoad()
        //Make this file the delegate of the UITextField
        self.TextFieldOutlet.delegate = self;
        // Do any additional setup after loading the view, typically from a nib.
    }
}

// MARK: Previous construction materials and notes here:
// -----------------------------------
//self.location.text=place;
//print(getWeather(city: place))
//        temperature.text=currentTemp
//        JSON_BOT.getWeather(city: "Munich")
//        main=JSON_BOT.current
//        temp=JSON_BOT.currentTemp
//        temperature.text=temp
//        print(temp)
//        locationManager.startUpdatingLocation()
//        extractData(weatherData: data!)
//    }
////
//    let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
//    let openWeatherMapAPIKey = "06663241e2affc7c1eaa4d87168f4b3c"
//
//
//    func getWeather(city: String) {
//
//       // var main:[String:String]=[:]
//
//        let url = URL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)")!
//
//
//            URLSession.shared.dataTask(with:url) { (data, response, error) in
//            if error != nil {
//                print(error!)
//            } else {
//                do {var temp:Double=0.0
//
//                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
//                    var main = parsedData["main"] as! [String:Any]
//
//                    //print(current)
//
//                   temp = main["temp"] as! Double
//                    print(type(of:temp))
//                    print(temp)
//
//                    //self.temperature.text=String(self.currentTemp)
//                    //print(temp)
//                    self.tempDouble = temp
//                } catch let error as NSError {
//                    print(error)
//                }
//            }
//
//            }.resume()
//
//    }




//  @IBOutlet weak var location: UILabel!
//  @IBOutlet weak var temperature: UILabel!

//    var locationManager: CLLocationManager = CLLocationManager()
//    var startLocation: CLLocation!
//
//    func extractData(weatherData: NSData) {
//        let json = try? JSONSerialization.jsonObject(with: weatherData as Data, options: []) as! NSDictionary
//
//        if json != nil {
//            if let name = json!["name"] as? String {
//                location.text = name
//            }
//
//            if let main = json!["main"] as? NSDictionary {
//                if let temp = main["temp"] as? Double {
//                    temperature.text = String(format: "%.0f", temp)
//                print(main["temp"])}
//            }
//        }
//    }
//
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let latestLocation: AnyObject = locations[locations.count - 1]
//
//        let lat = latestLocation.coordinate.latitude
//        let lon = latestLocation.coordinate.longitude
//
//        // Put together a URL With lat and lon
//        let path = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&06663241e2affc7c1eaa4d87168f4b3c"
//        print("WOW")
//        print(path)
//
//        let url = NSURL(string: path)
//
//        let task = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
//            DispatchQueue.main.async(execute: {
//                self.extractData(weatherData: data! as NSData)
//            })
//        }
//
//        task.resume()
//    }
//
//    func locationManager(manager: CLLocationManager,
//                         didFailWithError error: NSError) {
//
//    }
//
//    override func viewDidLoad() {
//
//        super.viewDidLoad()
//
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//        startLocation = nil
//    }

