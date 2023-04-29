//
//  File.swift
//
//
//  Created by Spyros Skordos Sko on 29/4/23.
//

import Foundation

@propertyWrapper
public struct Dependency<Dependency> {

    var dependency: Dependency

    public init(_ instantiationType: InstantiationType = .newInstance) {
        guard let dependency = DependencyContainer.resolve(dependencyType: instantiationType, Dependency.self)
        else {
            fatalError("No dependency of type \(String(describing: Dependency.self)) registered!")
        }
        self.dependency = dependency
    }

   public var wrappedValue: Dependency {
        get { self.dependency }
        mutating set { dependency = newValue }
    }
}
