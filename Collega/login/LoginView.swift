//
//  ContentView.swift
//  Collega
//
//  Created by David on 9/9/23.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 284, height: 167)
              .background(
                Image("CAMPLE LOGO 1 2")
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 284, height: 167)
                  .clipped()
              )
            
        }
        .padding(.leading, 55)
        .padding(.trailing, 54)
        .padding(.top, 259)
        .padding(.bottom, 426)
        .frame(width: 393, height: 852, alignment: .top)
        .background(.white)
        .overlay(
          Rectangle()
            .inset(by: 0.5)
            .stroke(.black.opacity(0.03), lineWidth: 1)
        )
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


