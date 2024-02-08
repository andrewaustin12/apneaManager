import HealthKit

class HealthKitManager: ObservableObject {
    let healthStore = HKHealthStore()
    let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
    let spo2Type = HKQuantityType.quantityType(forIdentifier: .oxygenSaturation)!
    
    var heartRateAnchor: HKQueryAnchor? {
        get {
            // Retrieve the anchor data from user defaults
            guard let data = UserDefaults.standard.data(forKey: "HeartRateAnchor") else {
                return nil
            }
            // Decode the anchor from the data
            return try? NSKeyedUnarchiver.unarchivedObject(ofClass: HKQueryAnchor.self, from: data)
        }
        set {
            // Encode the anchor to data
            guard let data = try? NSKeyedArchiver.archivedData(withRootObject: newValue as Any, requiringSecureCoding: true) else {
                return
            }
            // Save the data to user defaults
            UserDefaults.standard.set(data, forKey: "HeartRateAnchor")
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, NSError(domain: "com.andy.ApneaManager", code: 2, userInfo: [NSLocalizedDescriptionKey: "Health data is not available on this device."]))
            return
        }
        
        healthStore.requestAuthorization(toShare: [], read: [heartRateType, spo2Type]) { success, error in
            completion(success, error)
            // Start the heart rate query if the authorization was successful
            if success {
                self.startHeartRateQuery()
            }
        }
    }
    
    func startHeartRateQuery() {
        // Create the query with the heart rate type, no predicate, the anchor property, and a limit of 10 samples per update
        let query = HKAnchoredObjectQuery(type: heartRateType, predicate: nil, anchor: heartRateAnchor, limit: 10) { query, samples, deletedObjects, newAnchor, error in
            // Handle errors
            guard error == nil else {
                print(error!)
                return
            }
            
            // Update the anchor property with the new anchor
            self.heartRateAnchor = newAnchor
            
            // Process the new samples
            if let samples = samples as? [HKQuantitySample] {
                for sample in samples {
                    let heartRate = sample.quantity.doubleValue(for: HKUnit(from: "count/min"))
                    print("Heart rate: \(heartRate)")
                }
            }
        }
        
        // Set the update handler to receive continuous updates
        query.updateHandler = { query, samples, deletedObjects, newAnchor, error in
            // Handle errors
            guard error == nil else {
                print(error!)
                return
            }
            
            // Update the anchor property with the new anchor
            self.heartRateAnchor = newAnchor
            
            // Process the new samples
            if let samples = samples as? [HKQuantitySample] {
                for sample in samples {
                    let heartRate = sample.quantity.doubleValue(for: HKUnit(from: "count/min"))
                    print("Heart rate: \(heartRate)")
                }
            }
        }
        
        // Execute the query
        healthStore.execute(query)
    }
    
    func fetchLatestHeartRate(completion: @escaping (Double?, Error?) -> Void) {
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: heartRateType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { _, results, error in
            guard let sample = results?.first as? HKQuantitySample else {
                completion(nil, error)
                return
            }
            
            let heartRate = sample.quantity.doubleValue(for: HKUnit(from: "count/min"))
            DispatchQueue.main.async {
                completion(heartRate, nil)
            }
        }
        
        healthStore.execute(query)
    }
    
    func fetchLatestSpO2(completion: @escaping (Double?, Error?) -> Void) {
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: spo2Type, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { _, results, error in
            guard let sample = results?.first as? HKQuantitySample else {
                completion(nil, error)
                return
            }
            
            // SpO2 is represented as a percentage, so multiply by 100 to convert to a percentage value
            let spo2Value = sample.quantity.doubleValue(for: HKUnit.percent()) * 100
            DispatchQueue.main.async {
                completion(spo2Value, nil)
            }
        }
        
        healthStore.execute(query)
    }
    
}
