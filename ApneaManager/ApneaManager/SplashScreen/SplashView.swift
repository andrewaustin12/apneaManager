//
//  SplashView.swift
//  theSidewinderChecklist
//
//  Created by andrew austin on 11/29/23.
//

import SwiftUI


struct SplashView: View {
    var body: some View {
        Image("freediver-8")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    SplashView()
}
