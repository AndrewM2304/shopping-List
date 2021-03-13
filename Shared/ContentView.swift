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
    @Environment(\.managedObjectContext) private var viewContext

    
    
    var body: some View {
        
        VStack {
            
            if(planShow == true){
                plannerView()
                    
            } else if (listShow == true){
                shoppingListView()
                Spacer()
            } else if (accountShow == true){
                
                accountScreenView()
                Spacer()
            }
            tabBarView(plannerActive: $planShow, listActive: $listShow, accountActive: $accountShow)
                
                .frame(width: UIScreen.main.bounds.width)
               
        }
        
        .edgesIgnoringSafeArea(.all)
        
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


// Planner view here **************************************************************************

struct plannerView: View {
    @AppStorage("theme") var currentTheme: colorTheme = .green
    @Environment(\.managedObjectContext) private var viewContext
    @State var addMealPopup = false
    @State var myOffset = CGSize.zero
    @State var offset = 0
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }


    
    
    @FetchRequest(entity: Meal.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Meal.mealName, ascending: true)],
                  animation: .default)
    private var listmeal: FetchedResults<Meal>
    
    
    @State var selectedDate = Date().midnight
    @State var time = Date().midnight

    
    var body: some View {
        NavigationView {
            
            VStack{
                navBarView()
                    .zIndex(1)
                    .overlay(
                        dateSelectorView(selectedDate: $selectedDate)
                            .padding(15)
                            .offset(y: 30)
                    )
                
                
                ScrollView {
                    VStack(alignment: .leading, spacing:(10)){
                        
                        ForEach(listmeal){ mealItem in
                            
                            if(mealItem.dateArray.contains(where: {$0.date == selectedDate})){
                                NavigationLink(destination: existingMealsView(meal: mealItem, selectedDate: $selectedDate)) {
                                        mealCardView(mealItem: mealItem,selectedDate: $selectedDate)

                                }
                                .buttonStyle(popButtonStyle())
                            }
                        }
                    }
                    .padding(.top, 50)
                    
                    Spacer(minLength: 100)
                    
                }
               
                
                .frame(maxWidth: .infinity)
                .padding(.top, 10)
                .offset(y: -50)

                .overlay(
                    VStack{
                        Spacer()
                        Button(action: { self.addMealPopup.toggle()}, label: {
                            HStack{
                                Image(systemName: "plus.circle")
                            Text("Add Meal")
                            }
                        })
                        .buttonStyle(primaryButtonStyle())
                        .padding(10)
                        .padding(.bottom, 20)
                    }
                    
                )
                
            }
           
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.top)
            
            
        }.offset(y: 10)
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $addMealPopup) {
            menuPopupView().edgesIgnoringSafeArea(.all).environment(\.managedObjectContext, self.viewContext)

        }
        
    }
    
    func swipeGesture() {
        
        if (myOffset.width < -20) {
            withAnimation{
                if(dateFormatter.string(from: selectedDate) != "Sunday"){
                self.selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: self.selectedDate)!
            }
            }
        }
        if (myOffset.width > -20) {
            withAnimation{
                if(dateFormatter.string(from: selectedDate) != "Monday"){
            self.selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: self.selectedDate)!
                }
                }
            
        }
    }
    
}
