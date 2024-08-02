//
//  RepeatButtonView.swift
//  MusicPlayerOverlay
//
//  Created by Artyom Petrichenko on 02.08.2024.
//

import SwiftUI

struct RepeatButtonView: View {
    
    @State private var rotationAngle: Double = 0.0
    
    private let actionPlaceholder = {
        print("Button Repeat")
    }
    
    var body: some View {
        Button(action: action,
               label: buttonView)
        .buttonStyle(MusicButtonStyle())
    }
}

private extension RepeatButtonView {
    @ViewBuilder
    func buttonView() -> some View {
        Image(systemName: "repeat")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .transition(.asymmetric(insertion: insertTransition,
                                    removal: removeTransition))
            .frame(width: 25)
            .rotationEffect(.degrees(rotationAngle))
            .animation(.easeOut(duration: 0.5), value: rotationAngle)
    }
}

private extension RepeatButtonView {
    func action(){
        defer { actionPlaceholder() }
        
        withAnimation {
            rotationAngle += 180
        }
    }
}

private extension RepeatButtonView {
    
    private var insertTransition: AnyTransition {
        AnyTransition
            .scale(scale: 0.5).animation(.easeIn(duration: 0.2))
            .combined(with: .opacity.animation(.easeIn(duration: 0.2)))
            .combined(with: .move(edge: .top).animation(.easeInOut(duration: 0.3)))
            .combined(with: .offset(y: -15))
            .combined(with: .slide.animation(.easeInOut(duration: 0.1)))
    }
    
    private var removeTransition: AnyTransition {
        AnyTransition
            .scale(scale: 1.5).animation(.easeOut(duration: 0.2))
            .combined(with: .scale.animation(.bouncy))
            .combined(with: .move(edge: .bottom).animation(.easeInOut(duration: 0.3)))
            .combined(with: .offset(y: 15))
            .combined(with: .opacity.animation(.easeOut(duration: 0.2)))
    }
}

#Preview {
    RepeatButtonView()
}
