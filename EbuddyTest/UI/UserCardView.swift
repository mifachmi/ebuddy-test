//
//  UserCardView.swift
//  EbuddyTest
//
//  Created by Fachmi Dimas Ardhana on 29/11/24.
//

import SwiftUI

struct UserCardView: View {
    var body: some View {
        ZStack {
            // Background color
            Color.blue
                .ignoresSafeArea()
            
            // Rounded rectangle
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .frame(width: 380, height: 700)
            
            VStack {
                HStack {
                    Text("Zynx")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Image(.circle)
                        .resizable()
                        .frame(width: 16, height: 16)
                        .padding(.leading, 12)
                    
                    Spacer()
                    
                    Image(.verified)
                        .resizable()
                        .frame(width: 36, height: 36)
                        .padding(.trailing, 16)
                    
                    Image(.instagram)
                        .resizable()
                        .frame(width: 36, height: 36)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
                
                ZStack {
                    Image(.human)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350)
                        .clipShape(RoundedRectangle(cornerRadius: 36))
                    
                    HStack {
                        Image(.lightning)
                            .resizable()
                            .frame(width: 36, height: 36)
                        
                        Text("Available today!")
                            .font(.title2)
                            .fontWeight(.regular)
                            .foregroundStyle(Color.white)
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 36)
                    .background(.ultraThinMaterial)
                    .cornerRadius(100)
                    .offset(y: -150)
                }
                
                HStack {
                    Image(.callOfDuty)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.leading, 20)
                    
                    ZStack {
                        Circle()
                            .fill(Color.white)
                        Image(.mobileLegend)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .padding(.all, 4)
                        Circle()
                            .fill(Color.black.opacity(0.4))
                            .padding(.all, 4)
                        Text("+3")
                            .font(.largeTitle)
                            .foregroundStyle(Color.white)
                    }
                    .frame(width: 100, height: 100)
                    .offset(x: -30)
                    
                    Spacer()
                    
                    Image(.voice)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(.trailing, 20)
                }
                .offset(y: -50)
                
                HStack {
                    Image(.star)
                        .resizable()
                        .frame(width: 36, height: 36)
                    
                    Text("4.9")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading, 12)
                    
                    Text("(61)")
                        .font(.largeTitle)
                        .foregroundStyle(Color.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 12)
                .padding(.top, -24)
                
                HStack(alignment: .bottom) {
                    Image(.fire)
                        .resizable()
                        .frame(width: 36, height: 36)
                    HStack(spacing: 0) {
                        Text("110")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text(".00/1Hr")
                            .font(.title)
                            .fontWeight(.medium)
                    }
                    .padding(.leading, 12)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 12)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
        }
        
    }
}

#Preview {
    UserCardView()
}
