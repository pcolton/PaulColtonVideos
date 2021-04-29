//
//  AppEnvApp.swift
//  AppEnv
//
//  Created by Paul Colton on 4/28/21.
//

import SwiftUI

@main
struct AppEnvApp: App {
  @StateObject var appEvironment = AppEnvironment(fileClient: .live)

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(appEvironment)
    }
  }
}
