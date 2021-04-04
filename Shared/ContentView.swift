//
//  ContentView.swift
//  Shared
//
//  Created by Andrew Miller on 30/12/2020.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @AppStorage("theme") var currentTheme: colorTheme = .green
    
    @State private var planShow = true
    @State private var listShow = false
    @State private var accountShow = false
    @State var calendarShow = false
    @State var selectedDate = Date().midnight
    @State var addMealPopup = false
    @Environment(\.horizontalSizeClass) var sizeClass

    @Environment(\.managedObjectContext) private var viewContext

    
    var body: some View {
        
        GeometryReader{ geo in
            
            
        
        VStack (spacing: 0){
            
           
                
                if(planShow == true){
                    HStack (spacing: 0){
                    if sizeClass == .regular {
                        
                        calendarViewTwo(selectedDate: $selectedDate)
                            
                                
                        plannerView(selectedDate: $selectedDate, calendarShow: $calendarShow, addMealPopup: $addMealPopup)
                            .frame(minWidth: 400)
                            .frame(minWidth: 400, idealWidth: geo.size.width * 0.4)
                    } else{
                        plannerView(selectedDate: $selectedDate, calendarShow: $calendarShow, addMealPopup: $addMealPopup)
                        
                    }
                    }
                       
                } else if (listShow == true){
                    shoppingListView()
                        .environment(\.managedObjectContext, self.viewContext)
                       
                } else if (accountShow == true){
                    
                    accountScreenView()
                          
                }
            tabBarView(plannerActive: $planShow, listActive: $listShow, accountActive: $accountShow, geo: geo.size.width)
                
        }    .fullScreenCover(isPresented: $addMealPopup) {
            menuPopupView().edgesIgnoringSafeArea(.all).environment(\.managedObjectContext, self.viewContext)

        }
        

        }.ignoresSafeArea()
        .sheet(isPresented: $calendarShow, content: {
            calendarViewTwo(selectedDate: $selectedDate)
        })
            
            
            


            
            
       
    }


}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

