//
//  ContentView.swift
//  AppEnv
//
//  Created by Paul Colton on 4/28/21.
//

import Combine
import SwiftUI

struct ContentView: View {
  @EnvironmentObject var appEnvironment: AppEnvironment

  @State var text: String = "Enter some text"
  @State var cancellables = Set<AnyCancellable>()

  var textFileUrl: URL {
    appEnvironment.fileClient.documentDirectory()
      .appendingPathComponent("text.txt")
  }

  var body: some View {
    VStack {
      Button("Save", action: saveText)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding()

      TextEditor(text: $text)
        .padding()
    }
    .background(Color.init(white: 0.9))
    .cornerRadius(20)
    .onAppear(perform: loadText)
  }

  func saveText() {
    appEnvironment.fileClient.saveFile(textFileUrl, text.data(using: .utf8)!)
      .sink { completion in
        switch completion {
          case .finished:
            print("Successfully saved.")
          case .failure(let error):
            print("Error saving: \(error)")
        }
      } receiveValue: { _ in }
      .store(in: &cancellables)
  }

  func loadText() {
    appEnvironment.fileClient.loadFile(textFileUrl)
      .replaceError(with: "Error loading the file.".data(using: .utf8)!)
      .sink(receiveValue: { text = String(decoding: $0, as: UTF8.self) })
      .store(in: &cancellables)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(AppEnvironment(fileClient: .preview))
  }
}
