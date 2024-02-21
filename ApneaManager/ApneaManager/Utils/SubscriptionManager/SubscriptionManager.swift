//
//  SubscriptionManager.swift
//  ApneaManager
//
//  Created by andrew austin on 2/17/24.
//

import Foundation
import Combine
import RevenueCat

// Make SubscriptionManager inherit from NSObject to conform to PurchasesDelegate
class SubscriptionManager: NSObject, ObservableObject {
    @Published var isProUser: Bool = false

    static let shared = SubscriptionManager()

    override private init() {
        super.init() // Call to NSObject's initializer
        setupRevenueCatListener()
        checkProStatus()
    }

    func setupRevenueCatListener() {
        // Ensure this instance is set as the delegate for Purchases.shared
        Purchases.shared.delegate = self
    }

    func checkProStatus() {
        Purchases.shared.getCustomerInfo { [weak self] (info, error) in
            self?.updateProStatusBasedOn(info: info)
        }
    }

    private func updateProStatusBasedOn(info: CustomerInfo?) {
        DispatchQueue.main.async {
            if let entitlements = info?.entitlements, entitlements.all["Pro"]?.isActive == true {
                self.isProUser = true
            } else {
                self.isProUser = false
            }
        }
    }
}

// Conform to PurchasesDelegate to receive updates.
extension SubscriptionManager: PurchasesDelegate {
    func purchases(_ purchases: Purchases, receivedUpdated customerInfo: CustomerInfo) {
        // Called whenever the Purchases SDK updates the customer info.
        updateProStatusBasedOn(info: customerInfo)
    }
}
