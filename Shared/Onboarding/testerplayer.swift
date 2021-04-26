//
//  testerplayer.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 25/04/2021.
//

import SwiftUI
import AVKit

struct videoPlayerTemplate: View {
    var videoUrl: String
    private let player : AVPlayer
    
    var body: some View {
        VideoPlayer(player: player)
            .frame(height:300)
            .cornerRadius(20)
    }
    init(videoUrl: String, player: AVPlayer){
        self.videoUrl = videoUrl
        self.player = AVPlayer(url: URL(string: videoUrl)!)
        
    }
}

struct videoPlayerTemplate_Previews: PreviewProvider {
    @State static var video = "https://andrewmiller.website/videos/movie_test.mp4"
    static var previews: some View {
        videoPlayerTemplate(videoUrl: "https://andrewmiller.website/videos/movie_test.mp4", player: AVPlayer(url: URL(string: video)!))
    }
}

