//
//  EnumFish.swift
//  BubblyBass
//
//  Created by Роман Главацкий on 14.10.2025.
//

import Foundation

enum Fish: CaseIterable {
    case fish1
    case fish2
    case fish3
    case fish4
    case fish5
    case fish6
    case fish7
    case fish8
    case fish9
    
    var name: String {
        switch self {
            
        case .fish1:
            return "Salmon"
        case .fish2:
            return "Tuna"
        case .fish3:
            return "Shark"
        case .fish4:
            return "Trout"
        case .fish5:
            return "Carp"
        case .fish6:
            return "Cod"
        case .fish7:
            return "Herring"
        case .fish8:
            return "Pike"
        case .fish9:
            return "Catfish"
        }
    }
    
    var imageFish: ImageResource {
        switch self {
            
        case .fish1:
            return .fish1
        case .fish2:
            return .fish2
        case .fish3:
            return .fish3
        case .fish4:
            return .fish4
        case .fish5:
            return .fish5
        case .fish6:
            return .fish6
        case .fish7:
            return .fish7
        case .fish8:
            return .fish8
        case .fish9:
            return .fish9
        }
    }
    
    var chanceToCatch: Int {
        switch self {
            
        case .fish1:
            return 90
        case .fish2:
            return 80
        case .fish3:
            return 70
        case .fish4:
            return 60
        case .fish5:
            return 50
        case .fish6:
            return 40
        case .fish7:
            return 30
        case .fish8:
            return 20
        case .fish9:
            return 10
        }
    }
}
