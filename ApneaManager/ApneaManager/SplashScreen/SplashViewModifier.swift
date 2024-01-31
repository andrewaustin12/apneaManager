//
//  SplashViewModifier.swift
//  theSidewinderChecklist
//
//  Created by andrew austin on 11/29/23.
//

import SwiftUI


private let defaultTimeout: TimeInterval = 2.5

struct SplashViewModifier<SplashContent: View>: ViewModifier {
  private let timeout: TimeInterval
  private let splashContent: () -> SplashContent

  @State private var isActive = true

  init(timeout: TimeInterval = defaultTimeout,
       @ViewBuilder splashContent: @escaping () -> SplashContent) {
    self.timeout = timeout
    self.splashContent = splashContent
  }

  func body(content: Content) -> some View {
    if isActive {
       splashContent()
        .onAppear {
           DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
             withAnimation {
               self.isActive = false
             }
           }
         }
    } else {
      content
    }
  }
}

extension View {
  func splashViewModifier<SplashContent: View>(
    timeout: TimeInterval = defaultTimeout,
    @ViewBuilder splashContent: @escaping () -> SplashContent
  ) -> some View {
    self.modifier(SplashViewModifier(timeout: timeout, splashContent: splashContent))
  }
}

