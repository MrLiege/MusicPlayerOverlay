//
//  VolumeControllerView.swift
//  MusicPlayerOverlay
//
//  Created by Artyom Petrichenko on 02.08.2024.
//

import SwiftUI

struct VolumeControllerView: View {
    
    @State private var speed = 9.0
    @State private var isEditing = false
    @State private var showMinVolume = false
    @State private var showMaxVolume = false
    
    var body: some View {
        HStack(spacing: 20) {
            minVolume()
            sliderController()
            maxVolume()
        }
        .padding(30)
        .onChange(of: speed) { item in
            if item == 0 {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showMinVolume = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showMinVolume = false
                    }
                }
            } else if item == 10 {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showMaxVolume = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showMaxVolume = false
                    }
                }
            }
        }
    }
}

private extension VolumeControllerView {
    @ViewBuilder
    func sliderController() -> some View {
        Slider(
            value: $speed,
            in: 0...10
        )
        .accentColor(.black)
    }
    
    func minVolume() -> some View {
        Image(systemName: "speaker.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 25)
            .scaleEffect(showMinVolume ? 1.7 : 1.0)
    }
    
    func maxVolume() -> some View {
        Image(systemName: "speaker.wave.2.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 25)
            .scaleEffect(showMaxVolume ? 1.5 : 1.0)
    }
}

#Preview {
    VolumeControllerView()
}
