//
//  MusicButtonStyle.swift
//  MusicPlayerOverlay
//
//  Created by Artyom Petrichenko on 01.08.2024.
//

import Foundation
import SwiftUI

struct MusicButtonStyle: ButtonStyle {
    
    @State private var isBackgroundVisible = false
    private let animationDuration = 0.22
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .tint(Color.black)
            .padding(15)
            .background {
                if isBackgroundVisible || configuration.isPressed {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                }
            }
            .scaleEffect(isBackgroundVisible ? 0.85 : 1)
            .animation(.spring(response: 0.5, dampingFraction: 0.65),
                       value: isBackgroundVisible)
            .onChange(of: configuration.isPressed,
                      perform: setVisibleBackground)
    }
    
    private func setVisibleBackground(_ isPressed: Bool) {
        if isPressed {
            isBackgroundVisible = true
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            isBackgroundVisible = false
        }
    }
}
