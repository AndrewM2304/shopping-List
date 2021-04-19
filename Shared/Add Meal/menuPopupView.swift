//
//  menuPopupView.swift
//  shopping List
//
//  Created by Andrew Miller on 02/01/2021.
//

import SwiftUI



struct menuPopupView: View {
    
    @State var newMeal = 0
    
    
    
    @Environment(\.presentationMode) var presentationMode
     @AppStorage("theme", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var currentTheme: colorTheme = .green
    @ObservedObject var plannerVm : plannerVM
    
    
    
    var body: some View {
        GeometryReader{ geo in
            
            
        
        ScrollView{
            
            VStack (alignment: .center, spacing: 0){
            VStack (alignment: .leading, spacing: 0){
                HStack (alignment: .center){
                    Text("Add Meal")
                        .interTextStyle(text: "Inter-ExtraBold", size: 28, color: Color.white)
                    Spacer()
                    Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        plannerVm.selectedMeal = nil
                    }, label: {
                                Text("Cancel")
                                    .font(.subheadline)
                                    .foregroundColor(Color.white)
                                    .padding(.leading)
                                    .padding(.vertical)
                            })
                }
                .padding()
                .padding(.top, 40)
                HStack{
                    Button(action: {newMeal = 0}, label: {
                        Text("New Meal")
                            .padding()
                            .frame(width: (geo.size.width / 2) - 5)
                    })
                   
                    .opacity((newMeal == 0) ? 1 : 0.6)
                    
                    Button(action: {newMeal = 1}, label: {
                        Text("Saved Meals")
                            .padding()
                            .frame(width: (geo.size.width / 2) - 5)
                    })
                    .opacity((newMeal == 0) ? 0.6 : 1)
                   
                }
                .font(.custom("Inter-Medium", size: 17))
                .foregroundColor(.white)
                
                Rectangle()
                    .fill(currentTheme.colors.gradient)
                    .frame(width: (geo.size.width / 2) - 5 ,height: 5)
                    .offset(x:(newMeal == 1) ? (geo.size.width / 2) - 5 : 0)
                    .animation(.spring())
            }
           
            .background(Color(#colorLiteral(red: 0.1215686275, green: 0.1490196078, blue: 0.168627451, alpha: 1)))
                VStack{
            if(newMeal == 0){
               
                addMealView(mealObject: plannerVm.selectedMeal)
                    .padding(.top, 10)
                    
                    
                
            } else {
                mealListView()
                    .padding(.top, 10)
            }
                }.frame(maxWidth: .infinity)
               
            
            
            
        }
        } .background(radialBackgroundView())
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
    
    
    
    
}


struct menuPopupView_Previews: PreviewProvider {
    static var previews: some View {
        menuPopupView(plannerVm: plannerVM()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}





