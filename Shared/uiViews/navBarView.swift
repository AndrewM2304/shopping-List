//
//  navBarView.swift
//  shopping List
//
//  Created by Andrew Miller on 03/01/2021.
//

import SwiftUI


let circleGrad1 = LinearGradient(gradient: Gradient(colors: [(Color.white).opacity(1), (Color.black).opacity(0.11)]), startPoint: .topLeading, endPoint: .bottomTrailing)

struct navBarView: View {
  
    @AppStorage("theme") var currentTheme: colorTheme = .green
 var curved = true
    @State var text = ""
    var body: some View {
        
        if(curved == true){
        VStack {
           TextEditor(text: .constant("Placeholder"))
            .foregroundColor(.secondary)
            .background(Color.red)
            .mask(Color.red)
            navShape()
                .fill(currentTheme.colors.gradient)
                .overlay(
                    Image("circles")
                        
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0.6)
                        .offset(y: -30)
                )
                .clipShape(navShape())
                .shadow(color: Color("shadow").opacity(0.1), radius: 16, x: 0.0, y: 0)
                
        }
        .frame(height: 180)
        } else {
            VStack{
            navShapeSquare()
                .fill(currentTheme.colors.gradient)
                .overlay(
                    Image("circles")
                        
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .opacity(0.6)
                        .offset(y:15)
                        .padding(20)
                        
                )
                .clipShape(navShapeSquare())
                
                
        }
        .frame(height: 90)
        }

    }
}

struct navBarView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group{
        navBarView()
        navBarView(curved: false)
        }
    }
}


struct navShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 150))
        path.addQuadCurve(to: CGPoint(x: UIScreen.main.bounds.width, y: 150),
                          control: CGPoint(x: UIScreen.main.bounds.width / 2, y: 180))
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
        path.closeSubpath()
        return path
    }
    
}


struct navShapeSquare: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 100))
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 100))
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
        path.closeSubpath()
        return path
    }
    
}
