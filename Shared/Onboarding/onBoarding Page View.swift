//
//  onBoarding Page View.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 20/04/2021.
//

import SwiftUI

struct onBoardingPageView: View {
    var body: some View {
        TabView() {
            onboardingView(image: "Green Home", pageTitle: "Welcome to Get Prepped", subheading: "Meal planning made simple")
            onboardingView(image: "Add Meal", pageTitle: "Plan Meals", subheading: "Take the hassle out of finding recipes - save links, recipe notes and ingredients for quick access in the future")
            onboardingView(image: "Shopping List", pageTitle: "Shop Smart", subheading: "Get Prepped saves ingredients from your planned meals to your shopping list")
            onboardingView(image: "watch", pageTitle: "All Devices", subheading: "Get Prepped syncs across your iPhone, iPad and Apple Watch.")
            onboardingView(image: "Green Home", pageTitle: "Customise", subheading: "Choose a theme! (Dont worry you can always change this in settings later)", themeprovider: true)
        }.tabViewStyle(PageTabViewStyle())
        .edgesIgnoringSafeArea(.all)
    }
}

struct onBoardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        onBoardingPageView()
    }
}
