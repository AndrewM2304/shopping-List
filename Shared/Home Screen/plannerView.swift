//
//  plannerView.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 19/03/2021.
//

import SwiftUI


struct plannerView: View {
    @AppStorage("theme", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var currentTheme: colorTheme = .green
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.horizontalSizeClass) var sizeClass
    @ObservedObject var plannerVm : plannerVM
    @State var filter = NSPredicate()

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
 
    
    @Binding var selectedDate: Date
    @Binding var calendarShow: Bool
    @Binding var addMealPopup: Bool
    @State var showingAlert = false
    @State var deletedMeal : Meal?
    
    var body: some View {
        ScrollView (showsIndicators: false){
            VStack (alignment:.leading){
                VStack (alignment:.leading){
                    Text("Meals")
                        .interTextStyle(text: "Inter-ExtraBold", size: 28, color: Color.white)
                    
                    if sizeClass == .compact {
                    Button(action: {
                        withAnimation(.spring()){
                            self.calendarShow.toggle()
                        }
                        
                    }, label: {
                        HStack {
                            Text("\(dateFormatter.string(from: selectedDate))".uppercased())
                                .interTextStyle(text: "Inter-Medium", size: 15, color: currentTheme.colors.mainColor)
                            
                            Image(systemName: "chevron.down").foregroundColor(currentTheme.colors.mainColor)
                        }
                        .padding(8)
                        .backgroundGradient(isTapped: false, gradient: currentTheme.colors.gradient, color: currentTheme.colors.accentColor.opacity(0.1))
                    })
                    }
                }.padding(20)
                
                filteredMealsView(selectedDate: selectedDate, addMealPopup: $addMealPopup, planVM: plannerVm, deletedMeal: deletedMeal, showingAlert: $showingAlert)
                
                
                Spacer()
                
                
                Button(action: { self.addMealPopup.toggle()}, label: {
                    Text("Add Meal")
                        .interTextStyle(text: "Inter-ExtraBold", size: 17, color: Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(15)
                })                
                
                .buttonStyle(primaryButtonStyle(gradient: currentTheme.colors.gradient))
                
                .padding(.bottom, 20)
                .padding(20)  
            }
            .padding(.top, UIDevice.current.hasNotch ? 40 : 20)
        }
        .background(radialBackgroundView())
        .edgesIgnoringSafeArea(.top)
        .onAppear{
            plannerVm.selectedMeal = nil
        }
    }
    
}


struct plannerView_Previews: PreviewProvider {
    @State static var calendarShow = false
    @State static var mealPopup = false
    @State static var selectedDate = Date().midnight
    
  
    static var previews: some View {
        plannerView(plannerVm: plannerVM(), selectedDate: $selectedDate, calendarShow: $calendarShow,  addMealPopup: $mealPopup).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
