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
    
   var selectedDate = Date()
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            time in
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
            let currentDate = calendar.date(from: components)
            
            let selectedComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.selectedDate)
            
            var eventDateComponent = DateComponents()
            eventDateComponent.year = selectedComponents.year
            eventDateComponent.month = selectedComponents.month
            eventDateComponent.day = selectedComponents.day
            eventDateComponent.hour = selectedComponents.hour
            eventDateComponent.minute = selectedComponents.minute
            eventDateComponent.second = selectedComponents.second
            
            let eventDate = calendar.date(from: eventDateComponent)
            
            let timeLeft = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate!, to: eventDate!)
            
            if(timeLeft.second! >= 0){
                self.days = timeLeft.day!
                self.hours = timeLeft.hour!
                self.minutes = timeLeft.minute!
                self.seconds = timeLeft.second!
            }
        }
    }
}

struct ContentView: View {
    
   @StateObject var counter = Counter()
    
    var body: some View {
        VStack {
            
            HStack {
                Text("APP - Quanto falta?")
                    .padding()
                    .font(.system(size: 30))
            }
            
            DatePicker(selection: $counter.selectedDate, in: Date()..., displayedComponents: [.hourAndMinute, .date]){
                Text("Selecione a data do evento: ")
                    .padding()
            }
    
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
                Text("Para o evento...")
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
