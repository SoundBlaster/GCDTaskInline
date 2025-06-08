//
//  ContentView.swift
//  GCDTaskInline
//
//  Created by Egor Merkushev on 04.05.2025.
//

import SwiftUI

struct ContentView: View {

    let queue = DispatchQueue.global()

    var body: some View {
        VStack {
            Button("Execute Asynchronously") {
                executeAsynchronously()
            }
            Button("Execute Synchronously") {
                executeSynchronously()
            }
        }
        .padding()
    }

    // MARK: - Actions

    func executeAsynchronously() {
        queue.async {
            let threadId = Thread.current.hash
            let isMainThread = Thread.isMainThread
            print(
                "Executing task ⦷ asynchronously! Thread ID: \(threadId), Is Main Thread: \(isMainThread)"
            )
        }
    }

    func executeSynchronously() {
        queue.sync {
            let threadId = Thread.current.hash
            let isMainThread = Thread.isMainThread
            print(
                "Executing task ⌽ synchronously! Thread ID: \(threadId), Is Main Thread: \(isMainThread)"
            )
        }
    }
}

#Preview {
    ContentView()
}
