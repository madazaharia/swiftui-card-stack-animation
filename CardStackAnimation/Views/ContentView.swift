//
//  ContentView.swift
//  CardStackAnimation
//
//  Created by Madalin Zaharia on 18.01.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var cards: [Card] = [
        Card(color: .blue),
        Card(color: .pink),
        Card(color: .yellow),
        Card(color: .blue),
        Card(color: .cyan),
        Card(color: .purple),
        Card(color: .teal),
        Card(color: .indigo),
        Card(color: .mint),
        Card(color: .orange),
        Card(color: .green)
    ]
    
    @State private var rotationAngle: Double = 0
    @State private var offset = CGRect.zero
    @State private var zIndex: CGFloat = 0
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                ForEach(Array(cards.enumerated()), id: \.offset) { index, card in
                    CardView(model: card)
                        .frame(width: 350, height: 200, alignment: .center)
                        .rotationEffect(.degrees(isFrontCard(index) ? rotationAngle : 0))
                        .offset(y: CGFloat(index * 4))
                        .offset(x: 0, y: index == cards.count - 1 ? -offset.height : 0)
                        .zIndex(index == cards.count - 1 ? zIndex : 0)
                        .animation(.default, value: offset)
                        .gesture(
                            DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                .onChanged { gesture in
                                    guard isFrontCard(index) else { return }
                                    
                                    offset = CGRect(origin: gesture.location, size: gesture.translation)
                                    rotationAngle = getRotationAngle()
                                    
                                    if abs(offset.height) > 300 {
                                        zIndex = -1
                                    } else {
                                        zIndex = 0
                                    }
                                }
                                .onEnded { gesture in
                                    guard isFrontCard(index) else { return }
                                    
                                    if abs(offset.height) > 300 {
                                        let width = UIScreen.main.bounds.size.width/2
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            rotationAngle = 360 * (offset.origin.x < width ? 1 : -1)
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            cards.removeLast()
                                            cards.insert(card, at: 0)
                                            zIndex = 0
                                            rotationAngle = 0
                                        }
                                        
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            offset.size.height -= 100
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            withAnimation(.easeInOut(duration: 0.3)) {
                                                offset = .zero
                                            }
                                        }
                                    } else {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            rotationAngle = 0
                                            offset = .zero
                                        }
                                    }
                                }
                        )
                }
            }
        }
        .padding(.bottom, 60)
    }
    
    private func isFrontCard(_ index: Int) -> Bool {
        index == cards.count - 1
    }
    
    private func getRotationAngle() -> Double {
        let width = UIScreen.main.bounds.size.width/2
        return Double(offset.height / 50) * (offset.origin.x < width ? 1 : -1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
