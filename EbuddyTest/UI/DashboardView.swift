//
//  DashboardView.swift
//  EbuddyTest
//
//  Created by Fachmi Dimas Ardhana on 29/11/24.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        VStack {
            if let user = userManager.user {
                Text("Welcome, \(user.email ?? "Guest")!")
            } else {
                Text("Welcome, Guest!")
            }
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(UserManager.shared)
}
