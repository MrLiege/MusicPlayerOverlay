//
//  ShuffleButtonView.swift
//  MusicPlayerOverlay
//
//  Created by Artyom Petrichenko on 02.08.2024.
//

import SwiftUI

struct ShuffleButtonView: View {
    
    @State private var isRemoved = false
    
    private var actionPlaceholder = {
        print("Button Shuffle")
    }
    
    var body: some View {
        Button(action: action,
               label: buttonView
        )
        .buttonStyle(MusicButtonStyle())
    }
}

private extension ShuffleButtonView {
    @ViewBuilder
    func buttonView() -> some View  {
        Image(systemName: "shuffle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .transition(.asymmetric(insertion: insertTransition,
                                    removal: removeTransition))
            .frame(width: 25)
            .rotation3DEffect(
                .degrees(isRemoved ? 180 : 0),
                axis: (x: 1, y: 0, z: 0)
            )
            .animation(.easeOut(duration: 0.3), value: isRemoved)
    }
}

private extension ShuffleButtonView {
    func action() {
        defer { actionPlaceholder() }
        withAnimation {
            isRemoved.toggle()
        }
    }
}

private extension ShuffleButtonView {
    private var insertTransition: AnyTransition {
        AnyTransition
            .scale(scale: 0.5).animation(.easeIn(duration: 0.3))
            .combined(with: .opacity.animation(.easeIn(duration: 0.7)))
    }
    
    private var removeTransition: AnyTransition {
        AnyTransition
            .scale(scale: 1.5).animation(.easeOut(duration: 0.3))
            .combined(with: .opacity.animation(.easeOut(duration: 0.3)))
    }
}

#Preview {
    ShuffleButtonView()
}
