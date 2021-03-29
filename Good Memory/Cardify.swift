//
//  Cardify.swift
//  Good Memory
//
//  Created by Gustavo Belo on 20/03/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool{
        rotation < 90
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View{
        ZStack{
            Group{
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }
                .opacity(isFaceUp ? 1 : 0)
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(
            Angle.degrees(rotation),
            axis: (0,1,0)
        )

    }
    private let edgeLineWidth:CGFloat = 3.0
}

struct MenuCardify: ViewModifier {
    func body(content: Content) -> some View{
        ZStack{
            Group{
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.pink)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }.frame(width: frameWidth, height: frameHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
    private let frameWidth: CGFloat = 300
    private let frameHeight: CGFloat = 180
}

fileprivate let cornerRadius:CGFloat = 10.0
fileprivate let edgeLineWidth:CGFloat = 3.0

extension View{
    func cardify(isFaceUp: Bool) -> some View{
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
    
    func menuCardify() -> some View {
        self.modifier(MenuCardify())
    }
}
