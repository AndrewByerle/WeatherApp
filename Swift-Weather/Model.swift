//
//  Model.swift
//  Swift-Weather
//
//  Created by Andrew Byerle on 12/22/22.
//

import SwiftUI
import Foundation

struct WeekHighTemperatures: Codable{
    var temperature_2m_max: [Double]?
}

struct TaskEntry: Codable  {
    var daily: WeekHighTemperatures?
}

