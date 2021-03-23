//
//  plannerView.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 19/03/2021.
//

import SwiftUI


struct plannerView: View {
    @AppStorage("theme") var currentTheme: colorTheme = .green
    @Environment(\.managedObjectContext) private var viewContext
    @State var addMealPopup = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    
    @FetchRequest(entity: Meal.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Meal.mealName, ascending: true)],
                  animation: .default)
    private var listmeal: FetchedResults<Meal>

    
    @Binding var selectedDate: Date
    @State var time = Date().midnight
    @Binding var calendarShow: Bool
    
    
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
                        .backgroundGradient()
                    })
                    }
                }.padding(20)
                
                
                ForEach(listmeal){ mealItem in
                    
                    if(mealItem.dateArray.contains(where: {$0.date == selectedDate})){
                        
                        mealCardView(mealItem: mealItem,selectedDate: $selectedDate)
                            
                            
                            .buttonStyle(popButtonStyle())
                        
                    }
                }
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
        .sheet(isPresented: $calendarShow, content: {
            calendarViewTwo(selectedDate: $selectedDate)
        })

        
        
        .background(radialBackgroundView())
        
        
        
        
        
        
        .fullScreenCover(isPresented: $addMealPopup) {
            menuPopupView().edgesIgnoringSafeArea(.all).environment(\.managedObjectContext, self.viewContext)
            
        }
        .edgesIgnoringSafeArea(.vertical)
    }
    
    
    
}


struct plannerView_Previews: PreviewProvider {
    @State static var calendarShow = false
    @State static var selectedDate = Date().midnight
    static var previews: some View {
        plannerView(selectedDate: $selectedDate, calendarShow: $calendarShow)
    }
}
