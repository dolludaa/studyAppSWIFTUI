//
//  UpdateStore.swift
//  designcode
//
//  Created by Людмила Долонтаева on 13.08.2022.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject{
    @Published var updates: [Update] = updateData
    
}
