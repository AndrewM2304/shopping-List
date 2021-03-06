//
//  ContentView.swift
//  Shared
//
//  Created by Andrew Miller on 30/12/2020.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @AppStorage("theme", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var currentTheme: colorTheme = .green

    
    
    @State private var planShow = true
    @State private var listShow = false
    @State private var accountShow = false
    @State var calendarShow = false
    @State var selectedDate = Date().midnight
    @State var addMealPopup = false
   
    @Environment(\.horizontalSizeClass) var sizeClass

    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var plannerVm = plannerVM()
    @AppStorage("onboarding", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var onboarding = true
    
    var body: some View {
        
        GeometryReader{ geo in
            
            
        
        VStack (spacing: 0){
                if(planShow == true){
                    HStack (spacing: 0){
                    if sizeClass == .regular {
                        
                        calendarViewTwo(selectedDate: $selectedDate)
                            
                                
                        plannerView(plannerVm: plannerVm, selectedDate: $selectedDate, calendarShow: $calendarShow, addMealPopup: $addMealPopup)
                            .frame(minWidth: 400, idealWidth: geo.size.width * 0.4, maxWidth: 1200)
                            
                            
                    } else{
                        plannerView(plannerVm: plannerVm, selectedDate: $selectedDate, calendarShow: $calendarShow, addMealPopup: $addMealPopup)
                        
                    }
                    }
                       
                } else if (listShow == true){
                    shoppingListView()
                        .environment(\.managedObjectContext, self.viewContext)
                       
                } else if (accountShow == true){
                    
                    accountScreenView(onboarding: $onboarding)
                          
                }
            tabBarView(plannerActive: $planShow, listActive: $listShow, accountActive: $accountShow, selectedDate: $selectedDate, geo: geo.size.width)
            
               
        }
        .fullScreenCover(isPresented: $addMealPopup) {
            menuPopupView(plannerVm:plannerVm).edgesIgnoringSafeArea(.all).environment(\.managedObjectContext, self.viewContext)

        }
        .background(EmptyView().sheet(isPresented: $calendarShow, content: {
                        calendarViewTwo(selectedDate: $selectedDate).environment(\.managedObjectContext, self.viewContext)
                    }))
        .background(EmptyView().sheet(isPresented: $onboarding, content: {
            onBoardingPageView()
                    }))
            
       
       

        }.ignoresSafeArea()
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

