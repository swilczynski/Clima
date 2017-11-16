import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    let weatherDataService: WeatherDataService = WeatherDataService()
    
    let locationManager = CLLocationManager()
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.startUpdating()
        
        self.refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        
        self.scrollView.addSubview(refreshControl)
    }
    
    @objc func pullToRefresh(_ refreshControl: UIRefreshControl) {
        self.startUpdating()
    }
    
    func startUpdating() {
        self.cityLabel.text = "Loading..."
        self.temperatureLabel.text = ""
        
        self.locationManager.startUpdatingLocation()
    }
    
    func updateView(weatherData: WeatherData) {
        self.weatherIcon.image = UIImage(named: weatherData.weatherIconName)
        self.cityLabel.text = weatherData.city
        self.temperatureLabel.text = "\(weatherData.temperature) °"
        
        self.refreshControl.endRefreshing()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        
        if location.horizontalAccuracy > 0 {
            self.locationManager.stopUpdatingLocation()
            
            let parameters: [String: String] = [
                "lat": String(location.coordinate.latitude),
                "lon": String(location.coordinate.longitude)
            ]
            
            self.weatherDataService.fetchWeatherData(parameters: parameters, completion: {
                weatherData in
                self.updateView(weatherData: weatherData)
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.cityLabel.text = "Location unavailable"
    }
    
    func userChangedCity(city: String) {
        let parameters: [String: String] = [
            "q": city
        ]
        
        self.weatherDataService.fetchWeatherData(parameters: parameters, completion: {
            weatherData in
            self.updateView(weatherData: weatherData)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            let destination = segue.destination as! ChangeCityViewController
            destination.delegate = self
        }
    }
    
}
