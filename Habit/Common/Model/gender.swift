//
//  gender.swift
//  Habit
//
//  Created by Eduardo Finotti on 09/01/22.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable {
    case male = "Masculino"
    case female = "Femenino"
    
    var id: String {
        self.rawValue
    }
    
    var index: Self.AllCases.Index {
        return Self.allCases.firstIndex { self == $0 } ?? 0
    }
    
}
