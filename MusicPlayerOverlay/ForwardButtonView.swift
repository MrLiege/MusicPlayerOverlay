//
//  ForwardButtonView.swift
//  MusicPlayerOverlay
//
//  Created by Artyom Petrichenko on 02.08.2024.
//

import SwiftUI

struct ForwardButtonView: View {
    @State private var items = [0, 1]
    var isForward: Bool
    
    init(isForward: Bool) {
        self.isForward = isForward
    }
    
    private var actionPlaceholder = {
        print("Button Forward")
    }
    
    var body: some View {
        Button (action: action,
                label: buttonRewindForwardView)
        .buttonStyle(MusicButtonStyle())
    }
}


private extension ForwardButtonView {
    @ViewBuilder
    func buttonRewindForwardView() -> some View {
        HStack (spacing: 0){
            ForEach(items, id: \.hashValue) { _ in
                Image(systemName: "play.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .rotationEffect(.degrees(isForward ? 0 : 180))
                    .transition(.asymmetric(insertion: insertTransition,
                                            removal: removeTransition))
            }
        }
        .frame(width: 35)
    }
}

private extension ForwardButtonView {
    func action() {
        defer { actionPlaceholder() }
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.65)) {
            if isForward {
                items.removeLast()
                items.insert(UUID().hashValue, at: 0)
            } else {
                items.removeFirst()
                items.append(UUID().hashValue)
            }
        }
    }
}

private extension ForwardButtonView {
    private var insertTransition: AnyTransition {
        AnyTransition
            .scale(scale: 0).animation(.easeIn(duration: 0.2))
            .combined(with: .opacity.animation(.easeIn(duration: 0.25)))
            .combined(with: .move(edge: isForward ? .leading : .trailing).animation(.easeIn(duration: 0.2)))
            .combined(with: .scale(scale: 1.2).animation(.easeIn(duration: 0.5)))
    }
    
    private var removeTransition: AnyTransition {
        AnyTransition
            .scale(scale: 0).animation(.easeInOut(duration: 0.2))
            .combined(with: .offset(x: isForward ? 15 : -15))
            .combined(with: .opacity.animation(.easeIn(duration: 0.4)))
    }
}

#Preview {
    HStack {
        ForwardButtonView(isForward: false)
        ForwardButtonView(isForward: true)
    }
}
