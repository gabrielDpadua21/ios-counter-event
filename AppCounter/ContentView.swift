//
//  ContentView.swift
//  AppCounter
//
//  Created by Gabriel D. Padua on 10/04/22.
//

import SwiftUI

class Counter: ObservableObject {
    
   @Published var days = 0
   @Published var hours = 0
   @Published var minutes = 0
   @Published var seconds = 0
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            time in
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
            let currentDate = calendar.date(from: components)
            var eventDateComponent = DateComponents()
            eventDateComponent.year = 2022
            eventDateComponent.month = 4
            eventDateComponent.day = 11
            eventDateComponent.hour = 8
            eventDateComponent.minute = 0
            eventDateComponent.second = 0
            
            let eventDate = calendar.date(from: eventDateComponent)
            
            let timeLeft = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate!, to: eventDate!)
            
            
            self.days = timeLeft.day!
            self.hours = timeLeft.hour!
            self.minutes = timeLeft.minute!
            self.seconds = timeLeft.second!
        }
    }
}

struct ContentView: View {
    
   @StateObject var counter = Counter()
    
    var body: some View {
        VStack {
    
            HStack{
                Text("Faltam somente...")
                    .padding()
            }
            
            HStack{
                Text("\(counter.days) dias")
                Text("\(counter.hours) horas")
                Text("\(counter.minutes) minutos")
                Text("\(counter.seconds) segundos")
            }
            
            HStack{
                Text("Para planejamento estratégico...")
                    .padding()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
