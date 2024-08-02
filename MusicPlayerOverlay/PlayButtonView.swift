//
//  PlayButtonView.swift
//  MusicPlayerOverlay
//
//  Created by Artyom Petrichenko on 02.08.2024.
//

import SwiftUI

struct PlayButtonView: View {
    
    @State private var isRemoved: Bool = false
    @State private var isPressed: Bool = false
    
    let buttonPlaceholder = {
        print("Button Play")
    }
    
    var body: some View {
        Button(action: action,
               label: buttonView
        )
        .buttonStyle(MusicButtonStyle())
    }
}

private extension PlayButtonView {
    @ViewBuilder
    func buttonView() -> some View {
        Image(systemName: isRemoved ? "pause.fill" : "play.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25)
            .rotationEffect(.degrees(isRemoved ? 180 : 0))
            .animation(.easeInOut(duration: 0.6), value: isRemoved)
            .transition(.asymmetric(insertion: insertionTransition,
                                    removal: removeTransition))
    }
}

private  extension PlayButtonView {
    
    private func action() {
        defer {
            buttonPlaceholder()
        }
        
        withAnimation {
            isRemoved.toggle()
        }
        
        
    }
}

private extension PlayButtonView {
    
    private var insertionTransition: AnyTransition {
        AnyTransition
            .opacity.animation(.interpolatingSpring(stiffness: 0.4, damping: 0.7))
            .combined(with: .slide.animation(.easeInOut(duration: 0.6)))
            .combined(with: .scale.animation(.bouncy))
    }
    
    private var removeTransition: AnyTransition {
        AnyTransition
            .scale(scale: 0.2).animation(.easeOut(duration: 0.2))
            .combined(with: .opacity.animation(.easeOut(duration: 0.2)))
            
    }
}

#Preview {
    PlayButtonView()
}
