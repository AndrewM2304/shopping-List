//
//  IngredientListWidget.swift
//  shopping List
//
//  Created by Andrew Miller on 13/04/2021.
//

import WidgetKit
import SwiftUI
import CoreData

// MARK: For Widget

struct IngredientProvider: TimelineProvider {
    
    func placeholder(in context: Context) -> IngredientEntry {
        return IngredientEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (IngredientEntry) -> ()) {
        let entry = IngredientEntry(date: Date())
        return completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [IngredientEntry] = []
        
        let currentDate = Date()
        let entryDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
        let entry = IngredientEntry(date: entryDate)
        entries.append(entry)
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct IngredientEntry: TimelineEntry {
    let date: Date
}

struct widgetIngredientListEntryView : View {

    
    @AppStorage("theme", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var currentTheme: colorTheme = .green
    var entry: IngredientProvider.Entry
      let persistenceController : PersistenceController
    @FetchRequest(entity: Ingredients.entity(),
                  sortDescriptors: [], predicate: NSPredicate(format: "isSelected == YES"))
    var ingredientList: FetchedResults<Ingredients>
    
    var body: some View {
        return (
            ZStack (alignment: .topLeading){
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1215686275, green: 0.1490196078, blue: 0.168627451, alpha: 1)), Color(#colorLiteral(red: 0.07058823529, green: 0.1137254902, blue: 0.137254902, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                ContainerRelativeShape().stroke(lineWidth: 5).fill(currentTheme.colors.gradient)
                HStack (alignment: .top){
                VStack(alignment: .leading){
                    HStack {
                        Text("My Shopping List")
                            .font(Font.headline.weight(.heavy))
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "plus.circle.fill").foregroundColor(currentTheme.colors.accentColor)
                    }
                    Rectangle().frame(height:1).foregroundColor(Color.white.opacity(0.6))
                        .padding(.vertical, 5)
                    VStack{}.frame(maxWidth: .infinity)
                        .overlay(
                            VStack (alignment: .leading, spacing: 4){
                            if(ingredientList.count == 0){
                                Text("Shopping list is empty")
                                    .font(Font.subheadline.weight(.bold))
                                    .foregroundColor(Color.white.opacity(0.6))
                            } else {
                            
                            ForEach(ingredientList){ ingredient in
                                
                                if(ingredient.isChecked == false){
                                HStack {
                                    Image(systemName: "square").foregroundColor(.white)
                                    Text(ingredient.wrappedIngredientName).foregroundColor(.white)
                                }
                            }
                            }
                            }
                            }
                            , alignment: .topLeading)
               
                }
                
                    Spacer()
                }
                .padding()
            }
            .onReceive(NotificationCenter.default.publisher(for: .NSPersistentStoreRemoteChange)) { _ in
                // make sure you don't call this too often
                WidgetCenter.shared.reloadAllTimelines()
            }
        )
        
    }
}

struct widgetIngredientList: Widget {
    let kind: String = "IngredientShoppingList"
    let persistenceController = PersistenceController.shared
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: IngredientProvider()) { entry in
            widgetIngredientListEntryView(entry: entry, persistenceController: persistenceController)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .supportedFamilies([.systemMedium, .systemLarge])
        .configurationDisplayName("My Shopping List")
        .description("All unselected shopping list items")
    }
}





struct IngredientEntry_Previews: PreviewProvider {
    
    static var previews: some View {
        widgetIngredientListEntryView(entry: IngredientEntry(date: Date()), persistenceController: PersistenceController.preview)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
