//
//  OpenWeatherApi.swift
//  IosWeather
//
//  Created by Daniel Marceta on 15.04.21.
//

import Foundation

class OpenWeatherApi: ObservableObject {
    private var items = [WeatherItem]()


   // func downloadItems() -> [WeatherItem] {
    func downloadItems(lat: Double, lon: Double,callback: @escaping ([WeatherItem]) -> Void) {
        print("DOWNLOADING...")
        //guard let baseUrl = URL(string: //"https://api.openweathermap.org/data/2.5/forecast?q=Hollabrunn&appid=943324b67600e3a04cbc0376e6fabc20&units=metric")
        print("https://api.openweathermap.org/data/2.5/forecast?&appid=943324b67600e3a04cbc0376e6fabc20&units=metric&lat=\(lat)&lon=\(lon)")
        guard let baseUrl = URL(string: "https://api.openweathermap.org/data/2.5/forecast?&appid=943324b67600e3a04cbc0376e6fabc20&units=metric&lat=\(lat)&lon=\(lon)")
                else{
                    print("Cannot convert String to URL")
                    return
                }
                let task = URLSession.shared.dataTask(with: baseUrl){
                    data,response,error in
                    guard error == nil else{
                        print("Cannot open URL")
                        return
                    }
                    guard let responseData = data else {
                        print("No Data received")
                        return
                    }
                    print(responseData)
                    self.parse(json: responseData)
                    callback(self.items.self)
                }
        task.resume()
    }
    
    func parse(json: Data) {
        print("PARSING...")
        let decoder = JSONDecoder()
        if let jsonWeather = try? decoder.decode(WeatherResponse.self, from: json){
            print("SUCESS")
            items = jsonWeather.list
             }else{
            print("Failed Parsing")
        }
        // do {
            // result = try decoder.decode(WeatherResponse.self, from: json)
            
            //if let result = result {
                //print(result)
                //}
            //else{
                //print("Parsing failed")
                //}
            //return
            //} catch {
            //            print("Error: \(error)")
//        }
    }
}
