//
//  AppConfiguration.swift
//  EbuddyTest
//
//  Created by Fachmi Dimas Ardhana on 29/11/24.
//

import Foundation

class AppConfiguration: ObservableObject {
    @Published var environment: AppEnvironment

    init(environment: AppEnvironment) {
        self.environment = environment
    }
}
