import Foundation
import Alamofire
import SwiftyJSON

class WeatherDataService {
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "e72ca729af228beabd5d20e3b7749713"
 
    func fetchWeatherData(parameters: [String: String], completion: @escaping (_ weatherData: WeatherData) -> Void) {
        var params = parameters
        params["appid"] = APP_ID
        
        Alamofire.request(self.WEATHER_URL, method: .get, parameters: params).responseJSON {
            response in
            
            if response.result.isSuccess {
                if let responseJson = response.result.value {
                    let json: JSON = JSON(responseJson)
                    
                    let weatherData = WeatherData()
                    
                    if let city = json["name"].string {
                        weatherData.city = city
                    }
                    
                    if let temp = json["main"]["temp"].double {
                        weatherData.temperature = Int(temp - 273.15)
                    }
                    
                    if let condition = json["weather"][0]["id"].int {
                        weatherData.condition = condition
                    }
                    
                    completion(weatherData)
                }
            }
        }
    }
}
