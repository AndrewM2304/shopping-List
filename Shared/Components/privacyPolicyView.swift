//
//  privacyPolicyView.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 19/04/2021.
//

import SwiftUI
import CoreData

struct privacyPolicyView: View {
    
    @FetchRequest(
        entity: Ingredients.entity(),
        sortDescriptors: [])
    private var listingredients: FetchedResults<Ingredients>
    
    @FetchRequest(
        entity: Meal.entity(),
        sortDescriptors: [])
    private var listMeals: FetchedResults<Meal>
    
    @Environment(\.managedObjectContext) private var viewContext

    
    var color: Color
    var gradient: LinearGradient
    @State var deleteMealAlertShow = false
    @State var deleteIngredientAlertShow = false
    var body: some View {

            VStack (alignment:.leading){
                HStack (alignment: .top, spacing: 10){
                    Circle().frame(width:7, height: 20).foregroundColor(color)
                    Text("We do not collect, analyse or process any personal information about you or your device.").interTextStyle(text: "Inter-Medium", size: 15, color: Color.white.opacity(0.8))
                }
                HStack (alignment: .top, spacing: 10){
                    Circle().frame(width:7, height: 20).foregroundColor(color)
                    Text("Information you enter into the app is stored locally in your device, and in your private iCloud Drive should you enable iCloud syncing.").interTextStyle(text: "Inter-Medium", size: 15, color: Color.white.opacity(0.8))
                }
                HStack (alignment: .top, spacing: 10){
                    Circle().frame(width:7, height: 20).foregroundColor(color)
                    Text("All information in your iCloud Drive is private and cannot be accessed by the developers or users of Get Prepped.").interTextStyle(text: "Inter-Medium", size: 15, color: Color.white.opacity(0.8))
                   
                }
                Button(action: {self.deleteMealAlertShow.toggle()}, label: {
                    Text("Delete all data")
                        .interTextStyle(text: "Inter-ExtraBold", size: 17, color: Color.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                }).buttonStyle(primaryButtonStyle(gradient: gradient))
                .padding(.vertical)
                

                .alert(isPresented:$deleteMealAlertShow) {
                           Alert(
                               title: Text("Are you sure you want to delete all data?"),
                               message: Text("There is no undo"),
                               primaryButton: .destructive(Text("Delete")) {
                                   deleteMeal()
                               },
                               secondaryButton: .cancel()
                           )
                       }
            }.padding(15)
           
        }
    func deleteMeal() {
        for meal in listMeals{
            viewContext.delete(meal)
        }
        
        for ingredient in listingredients{
            viewContext.delete(ingredient)
        }
        
    }
    }


struct privacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        privacyPolicyView(color: Color.red, gradient: LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)).background(Color.black)
    }
}
