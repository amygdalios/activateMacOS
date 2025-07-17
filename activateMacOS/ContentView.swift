//
//  ContentView.swift
//  activateMacOS
//
//  Created by Alex Amygdalios on 17/7/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Activate macOS")
                .font(.system(size: 17, weight: .semibold))
            Text("Go to System Settings to activate macOS.")
                .font(.system(size: 12))
        }
        .foregroundColor(.gray)
        .padding(12)
        .background(Color.clear)
    }
}
