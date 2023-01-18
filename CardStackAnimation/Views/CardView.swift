//
//  CardView.swift
//  CardStackAnimation
//
//  Created by Madalin Zaharia on 18.01.2023.
//

import SwiftUI

struct CardView: View {
    let model: Card
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [model.color.opacity(0.6), model.color.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing)
                )
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Some Bank")
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                    
                    Spacer(minLength: 0)
                    
                    HStack {
                        Text("5412 7512 3412 3456")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        
                        Spacer()
                        
                        Text("12/24")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                    }
                                            
                    Text("LeeCardholder")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                }
                
                Spacer(minLength: 0)
                
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60, alignment: .center)
                    .clipShape(Circle())
            }
            .redacted(reason: .placeholder)
            .padding()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(model: .init(color: .mint))
            .frame(width: 350, height: 250, alignment: .center)
    }
}
