//
//  Detail.swift
//  IosWeather
//
//  Created by Daniel Marceta on 22.04.21.
//

import Foundation
import SwiftUI
import CoreData

struct Detail: View {
    var item : Item
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text("Datum").bold()
                Spacer()
                Text(item.dt.formatDate())
            }.padding(.leading, 30)
            .padding(.trailing, 30)
            HStack{
                Text("Feuchtigkeit").bold()
                Spacer()
                Text(item.humidity.formatDouble(f: ".0")+"%")
            }.padding(.leading, 30)
            .padding(.trailing, 30)
            HStack{
                Text("Temperatur").bold()
                Spacer()
                Text(item.temp.formatDouble(f: ".2")+"°C")
            }.padding(.leading, 30)
            .padding(.trailing, 30)
            HStack{
                Text("Druck").bold()
                Spacer()
                Text(item.pressure.formatDouble(f: ".0"))
            }.padding(.leading, 30)
            .padding(.trailing, 30)
            HStack{
                Text("Beschreibung").bold()
                Spacer()
                Text(item.main ?? "")
            }.padding(.leading, 30)
            .padding(.trailing, 30)
            Spacer()
            
            
            

           // Text(item.main ?? "")
            //Text(item.content ?? "")
            
        }

    }
}




