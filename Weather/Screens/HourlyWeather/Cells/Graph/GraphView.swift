//
//  GraphView.swift
//  Weather
//
//  Created by Руслан Гайфуллин on 21.01.2024.
//

import SwiftUI
import Charts


struct GraphView: View {
    var data: [WeatherHour]
   
    var body: some View {
        Chart {
            ForEach(data, id: \.hour) { elem in
                LineMark(
                    x: .value("hour", elem.hour),
                    y: .value(Text(verbatim: "Temp"), elem.temp))
            }
        }
    }
}
