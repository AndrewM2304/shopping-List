//
//  tutorialView.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 26/04/2021.
//

import SwiftUI

struct tutorialView: View {
    @State var int = 0
    @State var currentColorTheme = "Green Home"
    
    @AppStorage("theme", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var currentTheme: colorTheme = .green
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
           onboardingTemplate(
            sectionTitle: "Viewing Meals",
            subTitle: "The Meals page shows all meals that have been added for the selected today.",
            bullets: [
           "To see additional details about a meal,  tap the card and it will flip over to reveal more information.",
                "You can edit a meal by swiping right on the card, or delete it by swiping left."],
            videoURL: "https://andrewmiller.website/videos/movie_test.mp4")
            
            onboardingTemplate(
             sectionTitle: "Changing Dates",
             subTitle: "The default view is set to show all meals for today.",
             bullets: [
            "To change date press the date button at the top of the Meals Page to bring up a calendar and select the date you wish to see (each date also shows how many meals have been added to it).",
                 "If you are using Get Prepped on an iPad the calendar will show on the left hand side."],
                videoURL: "https://andrewmiller.website/videos/movie_test.mp4")
            
            onboardingTemplate(
             sectionTitle: "Adding Meals",
             subTitle: "Add Meals view is split into two sections - creating a new meal or a list of meals you have already saved.",
             bullets: [
            "Add a meal name, and optionally add links to the recipe and helpful notes about how to make it.",
                 "Dates / meal times can be selected by pressing each button",
             "Add all ingredients to your meal. These will be automatically be added to your shopping list. If you do not need to buy the ingredient simply un-select it and it will still save for future meals.",
             "To change weights / quantities click the downwards facing arrow to expand the ingredient and see more options"],
                videoURL: "https://andrewmiller.website/videos/movie_test.mp4")
            
            
            onboardingTemplate(
             sectionTitle: "Shopping List",
             subTitle: "All ingredients from your saved meals will be added to your shopping list. If you have an Apple Watch this wil automatically sync to it.",
             bullets: [
            "Add any additional shopping list items from the input at the top.",
                 "Click Ingredients to mark them as complete.",
             "Use the 3 dot menu at the top right of the screen to complete all ingredients, or delete completed (don’t worry this won’t delete them from your saved meals)."],
                videoURL: "https://andrewmiller.website/videos/movie_test.mp4")
            
            onboardingTemplate(
             sectionTitle: "Theme",
             subTitle: "Get Prepped has 5 colour themes built in. Choose one below, this can always be changed later in the settings page.",
             bullets: [
            ],
                videoURL: "")
            
            Image(imageShows(colorTheme: currentTheme, textValue: currentColorTheme))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                   .frame(height:250)
        
            Text("\(int)").opacity(0.01)
            themeSelectorView( int: $int)
            
            Button(action: { }, label: {
                Text("Get Started")
                    .interTextStyle(text: "Inter-ExtraBold", size: 17, color: Color.white)
                    .frame(maxWidth: .infinity)
                    .padding(15)
            })
            
            .buttonStyle(primaryButtonStyle(gradient: currentTheme.colors.gradient))
            .padding()
            
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1450980392, green: 0.1882352941, blue: 0.2196078431, alpha: 1)), Color(#colorLiteral(red: 0.07450980392, green: 0.1137254902, blue: 0.137254902, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
    }

    func imageShows(colorTheme: colorTheme, textValue: String) -> String {

        
        var textValue = currentColorTheme
               switch currentTheme{
               case .green : textValue = "Green Home";
                
                
               case .blue: textValue = "Blue Home";
               
               
               case .red: textValue = "Red Home";
               
              
               case .orange: textValue = "Orange Home";
               
               
               case .purple: textValue = "Purple Home";
               
                
               }
           
        return  textValue
        }
}

struct tutorialView_Previews: PreviewProvider {
    static var previews: some View {
        tutorialView()
    }
}
