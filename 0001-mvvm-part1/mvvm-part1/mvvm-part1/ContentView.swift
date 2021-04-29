//
//  ContentView.swift
//  mvvm-part1
//
//  Created by Paul Colton on 3/16/21.
//

import SwiftUI
import Combine

class ViewModel: ObservableObject {

    @Published var myText: String = ""
    @Published var myMessage: String = "empty"

    init() {
        $myText
            .map { $0.isEmpty ? "❌" : "✅" }
            .assign(to: &$myMessage)
    }
}

struct ContentView: View {

    @StateObject var model: ViewModel = ViewModel()

    var body: some View {
        VStack {
            TextField("Enter some text", text: $model.myText)
                .border(Color.gray)

            Text("\(model.myMessage)")
                .padding()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
