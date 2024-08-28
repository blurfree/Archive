//
//  Love.swift
//  Archive
//
//  Created by blurfree on 8/28/24.
//

import Foundation
import SwiftUI

enum Love: String, CaseIterable {
    
    case UprisingHeart
    
    func destination() -> AnyView {
        
        switch self {
            
        case .UprisingHeart:
            return AnyView(UprisingHeartView())
            
        }
    }
}
