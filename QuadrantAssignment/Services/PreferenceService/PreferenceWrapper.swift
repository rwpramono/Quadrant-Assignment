//
//  PreferenceWrapper.swift
//  Quadrant-Assignment
//
//  Created by Rachmat Wahyu Pramono on 18/09/22.
//

import Foundation

@propertyWrapper
struct PreferenceWrapper<Value> {
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
            return instance.container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            let propertyWrapper = instance[keyPath: storageKeyPath]
            let key = propertyWrapper.key
            instance.container.set(newValue, forKey: key)
        }
    }
}
