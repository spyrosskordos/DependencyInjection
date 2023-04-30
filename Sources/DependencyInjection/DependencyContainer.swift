//
//  File.swift
//  
//
//  Created by Spyros Skordos Sko on 29/4/23.
//


import Foundation

final class DependencyContainer {
    
    private static var cache: [String: Any] = [:]
    private static var generators: [String: () -> Any] = [:]
    
    static func register<Dependency>(type: Dependency.Type, as instantionType: InstantiationType = .automatic, _ factory: @autoclosure @escaping () -> Dependency) {
        generators[String(describing: type.self)] = factory
        
        if instantionType == .singleton {
            cache[String(describing: type.self)] = factory()
        }
    }
    
    static func resolve<Dependency>(dependencyType: InstantiationType = .automatic, _ type: Dependency.Type) -> Dependency? {
        let key = String(describing: type.self)
        switch dependencyType {
        case .singleton:
            if let cachedDependency = cache[key] as? Dependency {
                return cachedDependency
            } else {
                fatalError("\(String(describing: type.self)) is not registeres as singleton")
            }
            
        case .automatic:
            if let cachedDependency = cache[key] as? Dependency {
                return cachedDependency
            }
            fallthrough
            
        case .newInstance:
            if let depenendency = generators[key]?() as? Dependency {
                cache[String(describing: type.self)] = depenendency
                return depenendency
            } else {
                return nil
            }
        }
    }
}
