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

    // MARK: - Actions

    private func executeTask(isAsync: Bool) {
        let threadId = Thread.current.hash
        let isMainThread = Thread.isMainThread
        let prefix =
            isAsync ? "Executing task ⦷ asynchronously!" : "Executing task ⌽ synchronously!"
        print("\(prefix) Thread ID: \(threadId), Is Main Thread: \(isMainThread)")
    }

    func executeAsynchronously() {
        queue.async {
            executeTask(isAsync: true)
        }
    }

    func executeSynchronously() {
        queue.sync {
            executeTask(isAsync: false)
        }
    }
}

#Preview {
    ContentView()
}
