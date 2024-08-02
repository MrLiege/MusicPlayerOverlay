//
//  BackwardButtonView.swift
//  MusicPlayerOverlay
//
//  Created by Artyom Petrichenko on 02.08.2024.
//

import SwiftUI

struct BackwardButtonView: View {
    
    @State private var items = [0, 1]
    
    private let actionPlaceholder = {
        print("Button Backward")
    }
    
    var body: some View {
        Button(action: action,
               label: buttonRewindView)
        .buttonStyle(MusicButtonStyle())
    }
}


private extension BackwardButtonView {
    
    private func action() {
        defer { actionPlaceholder() }
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.65)) {
            items.removeLast()
            items.append(UUID().hashValue)
        }
    }
}
    
private extension BackwardButtonView {
    @ViewBuilder
    private func buttonRewindView() -> some View {
        HStack(spacing: 0) {
            ForEach(items, id: \.hashValue) { _ in
                Image(systemName: "play.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .rotationEffect(.degrees(180))
                    .transition(.asymmetric(insertion: insertTransition,
                                            removal: removeTransition))
            }
        }
        .frame(width: 35)
    }
}

private extension BackwardButtonView {
    private var insertTransition: AnyTransition {
        AnyTransition
            .scale(scale: 0).animation(.easeIn(duration: 0.1))
            .combined(with: .opacity.animation(.easeIn(duration: 0.2)))
            .combined(with: .move(edge: .trailing).animation(.easeIn(duration: 0.2)))
            .combined(with: .scale(scale: 1).animation(.easeIn(duration: 0.5)))
    }
    
    private var removeTransition: AnyTransition {
        AnyTransition
            .scale(scale: 0).animation(.easeIn(duration: 0.1))
            .combined(with: .offset(x: -15))
            .combined(with: .opacity.animation(.easeIn(duration: 0.25)))
    }
}

#Preview {
    BackwardButtonView()
}
