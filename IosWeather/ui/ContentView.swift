//
//  ContentView.swift
//  IosWeather
//
//  Created by Daniel Marceta on 15.04.21.
//

import SwiftUI
import CoreData
import CoreLocation

struct ContentView: View {
    var locationManager = CLLocationManager()
    @Environment(\.managedObjectContext) var managedObjectContext
    @StateObject var api = OpenWeatherApi()
    @StateObject private var imageLoader = ImageLoader()
    @FetchRequest(fetchRequest: Item.getAllItems()) var items: FetchedResults<Item>

    
    var body: some View {
        NavigationView{
            ZStack{
                List {
                    ForEach(items){ item in
                        NavigationLink(destination: Detail(item: item)){
                        HStack{
                            Image(uiImage: (self.imageLoader.image ?? UIImage(systemName: "photo"))!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70, alignment: .leading)
                                .onAppear(){
                                    self.imageLoader.loadImage(url: item.icon ?? "")
                                }
                        }
                        VStack(alignment: .leading){
                            Text(item.dt.formatDate()).font(.system(size: 12, weight: .heavy))
                            Text(item.temp.formatDouble(f: ".2") + "°C").font(.system(size: 12))
                        }.padding()
                    }
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Weather")
        }
    }
}
    func loadData(lat: Double, lon: Double) {
        for entry in items {
            managedObjectContext.delete(entry)
        }
        try? managedObjectContext.save()
        api.downloadItems(lat: lat, lon: lon,callback: { (data:[WeatherItem]) in
            data.forEach{ (item: WeatherItem) in
                let newItem = Item(context: self.managedObjectContext)
                    newItem.dt = item.dt
                    newItem.content = item.weather[0].description
                    newItem.humidity = item.main.humidity
                    newItem.pressure = item.main.pressure
                    newItem.temp = item.main.temp
                    newItem.icon = item.weather[0].icon
                    newItem.main = item.weather[0].main
                    do{
                        try self.managedObjectContext.save()
                    }catch{
                        print(error.localizedDescription)
                        self.managedObjectContext.rollback()
                    }
            }
            
        })
    }
    init() {
        locationManager.requestWhenInUseAuthorization()
        var currentLoc: CLLocation!
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
            currentLoc = locationManager.location
            print(currentLoc.coordinate.latitude)
            print(currentLoc.coordinate.longitude)
            loadData(lat: currentLoc.coordinate.latitude, lon: currentLoc.coordinate.longitude)
        }
    }
}
