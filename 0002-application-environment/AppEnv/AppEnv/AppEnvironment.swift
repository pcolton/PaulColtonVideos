//
//  AppEnvironment.swift
//  AppEnv
//
//  Created by Paul Colton on 4/28/21.
//

import Combine
import Foundation

class AppEnvironment: ObservableObject {
  var fileClient: FileClient

  init(fileClient: FileClient) {
    self.fileClient = fileClient
  }
}
