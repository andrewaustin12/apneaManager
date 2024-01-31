//
//  ThanksView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/17/24.
//

import SwiftUI

struct ThanksView: View {
    
    var didTapClose: () -> ()
    
    var body: some View {
        VStack(spacing: 8) {
            
            Text("Thank You 💕")
                .font(.system(.title2, design: .rounded).bold())
                .multilineTextAlignment(.center)
            
            Text("Thank you for your kind support! Your contribution helps us improve the app and provide a better experience. We truly appreciate it!")
                .font(.system(.body, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
            
            Button(action: didTapClose) {
                Text("Close")
                    .font(.system(.title3, design: .rounded).bold())
                    .tint(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue, in: RoundedRectangle(cornerRadius: 10,
                                                            style: .continuous))
            }
        }
        .padding(16)
        .background(Color("card-background"), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal, 8)
    }
}

#Preview {
        ThanksView {}
}
