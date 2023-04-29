//
//  File.swift
//  
//
//  Created by Spyros Skordos Sko on 29/4/23.
//

import Foundation

@propertyWrapper
struct Dependency<Dependency> {
    
    var dependency: Dependency
    
    init(_ instantiationType: InstantiationType = .newInstance) {
        //TODO 
        self.dependency = dependency
    }
    
    var wrappedValue: Dependency {
        get { self.dependency }
        mutating set { dependency = newValue }
    }
}
