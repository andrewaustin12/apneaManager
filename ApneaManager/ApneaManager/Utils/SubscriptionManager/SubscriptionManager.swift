//
//  SubscriptionManager.swift
//  ApneaManager
//
//  Created by andrew austin on 2/17/24.
//

import Foundation
import Combine
import RevenueCat

class SubscriptionManager: ObservableObject {
    @Published var isProUser: Bool = false

    static let shared = SubscriptionManager()

    private init() {
        checkProStatus()
    }

    func checkProStatus() {
        Purchases.shared.getCustomerInfo { [weak self] (info, error) in
            if let entitlements = info?.entitlements, entitlements.all["Pro"]?.isActive == true {
                DispatchQueue.main.async {
                    self?.isProUser = true
                }
            } else {
                DispatchQueue.main.async {
                    self?.isProUser = false
                }
            }
        }
    }
}
