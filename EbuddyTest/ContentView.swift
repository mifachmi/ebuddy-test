//
//  ContentView.swift
//  EbuddyTest
//
//  Created by Fachmi Dimas Ardhana on 27/11/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appConfig: AppConfiguration
    @State private var data = [String]()
    
    var body: some View {
        VStack {
            EnvironmentSwitcher()
            Text("Current Environment: \(appConfig.environment)")
            List(data, id: \.self) { item in
                Text(item)
            }
        }
        .onAppear {
            let dataService: DataService = {
                switch appConfig.environment {
                case .development: return MockDataService()
                case .staging: return MockDataService() // Use another mock if needed
                case .production: return APIDataService()
                }
            }()
            data = dataService.fetchData()
        }
    }
}

extension ContentView {
    struct EnvironmentSwitcher: View {
        @EnvironmentObject var appConfig: AppConfiguration
        
        var body: some View {
            Picker("Environment", selection: $appConfig.environment) {
                Text("Development").tag(AppEnvironment.development)
                Text("Staging").tag(AppEnvironment.staging)
                Text("Production").tag(AppEnvironment.production)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
    }
    
}

#Preview {
    ContentView()
        .environmentObject(AppConfiguration(environment: .development))
}
