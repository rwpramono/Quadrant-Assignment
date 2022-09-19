//
//  PreferenceWrapper.swift
//  Quadrant-Assignment
//
//  Created by Rachmat Wahyu Pramono on 18/09/22.
//

import Foundation

@propertyWrapper
struct PreferenceWrapper<Value: Codable> {
    let key: String
    let defaultValue: Value
    
    @available(*, unavailable)
    var wrappedValue: Value {
        get { fatalError("This wrapper only works on instance properties of classes") }
        set { fatalError("This wrapper only works on instance properties of classes") }
    }
    
    static subscript(_enclosingInstance instance: PreferenceService,
                     wrapped wrappedKeyPath: ReferenceWritableKeyPath<PreferenceService, Value>,
                     storage storageKeyPath: ReferenceWritableKeyPath<PreferenceService, Self>) -> Value {
        get {
            let propertyWrapper = instance[keyPath: storageKeyPath]
            let key = propertyWrapper.key
            let defaultValue = propertyWrapper.defaultValue
            
            guard let data = instance.container.object(forKey: key) as? Data,
                  let value = try? JSONDecoder().decode(Value.self, from: data) else {
                return defaultValue
            }

            return value
        }
        
        set {
            let propertyWrapper = instance[keyPath: storageKeyPath]
            let key = propertyWrapper.key
            
            let data = try? JSONEncoder().encode(newValue)
            instance.container.set(data, forKey: key)
        }
    }
}
