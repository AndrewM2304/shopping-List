import WidgetKit
import SwiftUI
import CoreData

// MARK: For Widget

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        return completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        let currentDate = Date()
        let entryDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
        let entry = SimpleEntry(date: entryDate)
        entries.append(entry)
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct widgetShoppingListEntryView : View {
    let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        return formatter
    }()
    
    @AppStorage("theme", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var currentTheme: colorTheme = .green
    var entry: Provider.Entry
      let persistenceController : PersistenceController
    @FetchRequest(entity: Meal.entity(),
                  sortDescriptors: [],
                  predicate: NSPredicate(format: "ANY meal.date ==%@", Date().midnight as CVarArg)
    )
    var listmeal: FetchedResults<Meal>
    
    var body: some View {
        return (
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1215686275, green: 0.1490196078, blue: 0.168627451, alpha: 1)), Color(#colorLiteral(red: 0.07058823529, green: 0.1137254902, blue: 0.137254902, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                ContainerRelativeShape().stroke(lineWidth: 5).fill(currentTheme.colors.gradient)
                HStack{
                    VStack (alignment: .leading, spacing: 4){
                        Text("Today's")
                        Text("Meals")
                            
                        Spacer()
                        
                    }.font(Font.headline.weight(.heavy))
                    .foregroundColor(.white)
                    
                    
                    Rectangle().frame(width:1).foregroundColor(Color.white.opacity(0.6))
                        .padding(.horizontal, 10)
                    Spacer().frame(maxHeight:.infinity)
                        .overlay(
                    VStack (alignment: .leading, spacing: 6){
                        if(listmeal.count == 0){
                            Text("No meals added for today")
                                .font(Font.subheadline.weight(.bold))
                                .foregroundColor(Color.white.opacity(0.6))
                        } else {
                          
                            ForEach(sortmyArray(meal: listmeal)){ mealItem in
                                
                            
                                VStack(alignment:.leading, spacing: 0){
                                    Text(mealItem.wrappedMealName)
                                        .font(Font.subheadline.weight(.bold))
                                        .foregroundColor(.white)
                                    ForEach(mealItem.dateArray){ date in
                                        
                                        if(itemFormatter.string(from: Date().midnight) == itemFormatter.string(from: date.date!)){
                                            VStack {
                                                Text(date.mealType!.uppercased())
                                                    .font(Font.caption2.weight(.bold))
                                                    .foregroundColor(currentTheme.colors.accentColor)
                                                
                                            }
                                        }
                                    }
                                
                                    
                                }
                                
                            }
                        }
                        
                    }
                            ,alignment: .topLeading)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    Spacer()
                }.padding()
                
            }
            .onReceive(NotificationCenter.default.publisher(for: .NSPersistentStoreRemoteChange)) { _ in
                // make sure you don't call this too often
                WidgetCenter.shared.reloadAllTimelines()
            }
        )
        
    }
    func sortmyArray(meal:FetchedResults<Meal> ) -> [Meal]{
        let myMeal = meal.sorted(by: {$0.dateArray[0].sortedOrder < $1.dateArray[0].sortedOrder})
        return myMeal
    }
}

struct widgetShoppingList: Widget {
    let kind: String = "widgetShoppingList"
    let persistenceController = PersistenceController.shared
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            widgetShoppingListEntryView(entry: entry, persistenceController: persistenceController)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .supportedFamilies([.systemMedium, .systemLarge])
        .configurationDisplayName("Today's Meals")
        .description("View of what meals are saved for today")
    }
}





struct widgetShoppingList_Previews: PreviewProvider {
    
    static var previews: some View {
        widgetShoppingListEntryView(entry: SimpleEntry(date: Date()), persistenceController: PersistenceController.preview)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
