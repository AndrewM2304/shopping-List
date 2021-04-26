//
//  onboardingTemplate.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 26/04/2021.
//

import SwiftUI
import AVKit

struct onboardingTemplate: View {
    @State var sectionTitle: String
    @State var subTitle:String
    @State var bullets: [String]
    @State var videoURL: String
    var body: some View {
        VStack (alignment:.leading, spacing: 15){
            Text(sectionTitle).interTextStyle(text: "Inter-ExtraBold", size: 20, color: .white)
            Divider().background(Color.white.opacity(0.9))
            Text(subTitle).interTextStyle(text: "Inter-SemiBold", size: 15, color: Color.white)
            
            ForEach(bullets, id: \.self){ item in
                HStack (alignment:.top){
                    Image(systemName: "circle.fill")
                        .font(Font.custom("Inter-Medium", size: 8))
                        .frame(width: 10, height:20)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                    Text(item).interTextStyle(text: "Inter-Medium", size: 15, color: Color.white.opacity(0.8))
                }
            }
            
            if (videoURL != ""){
                videoPlayerTemplate(videoUrl: videoURL, player: AVPlayer(url: URL(string: videoURL)!)).padding(.vertical)
            }
        }
        .padding(.vertical, 20)
    }
}

struct onboardingTemplate_Previews: PreviewProvider {
    static var previews: some View {
        onboardingTemplate(sectionTitle: "Hello World", subTitle: "this is a sub description", bullets: [
            "Bullet list one", "bullet list two"
        ], videoURL: "https://andrewmiller.website/videos/movie_test.mp4").background(radialBackgroundView())
    }
}
