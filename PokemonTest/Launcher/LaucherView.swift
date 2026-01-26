//
//  LaucherView.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 26-01-26.
//
import SwiftUI

struct LaucherView: View {
    @State private var waveScale: CGFloat = 0.3
    @State private var iconScale: CGFloat = 0.8
    @State private var iconRotation: Double = 0
    @State private var opacity: Double = 0
    @State private var isActive = false

    var body: some View {
        ZStack {
            if isActive {
                HomeView()
            } else {
                ZStack {

                    Circle()
                        .stroke(Color.yellow.opacity(0.4), lineWidth: 6)
                        .frame(width: 220, height: 220)
                        .scaleEffect(waveScale)
                        .opacity(1 - Double(waveScale - 0.3))
                        .animation(.easeOut(duration: 1.8).repeatForever(autoreverses: false), value: waveScale)

                    VStack(spacing: 15) {
                       
                        Image(systemName: "bolt.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.yellow)
                            .scaleEffect(iconScale)
                            .rotationEffect(.degrees(iconRotation))

                            .shadow(color: .yellow.opacity(0.7), radius: 15)

                        Text("Pokemon Test")
                            .font(.largeTitle.bold())
                            .opacity(opacity)
                            .foregroundColor(.primary)
                    }
                }
                .onAppear {
                  
                    withAnimation {
                        waveScale = 2.0
                    }

                    withAnimation(.easeInOut(duration: 0.1).repeatCount(6, autoreverses: true)) {
                        iconRotation = 10
                    }

                    withAnimation(.easeIn(duration: 1.2)) {
                        opacity = 1
                        iconScale = 1.1
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LaucherView()
}
