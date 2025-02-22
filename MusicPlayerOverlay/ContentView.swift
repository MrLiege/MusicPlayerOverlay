//
//  ContentView.swift
//  MusicPlayerOverlay
//
//  Created by Artyom Petrichenko on 31.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                RepeatButtonView()
                ForwardButtonView(isForward: false)
                PlayButtonView()
                ForwardButtonView(isForward: true)
                ShuffleButtonView()
            }
            VolumeControllerView()
        }
    }
}

#Preview {
    ContentView()
}
