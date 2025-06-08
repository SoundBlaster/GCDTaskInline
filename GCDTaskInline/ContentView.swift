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
            Button("Execute Complex") {
                executeComplex()
            }
        }
        .padding()
    }

    // MARK: - Actions

    private func executeTask(isAsync: Bool, sleepTime: Double) {
        let threadId = Thread.current.hash
        let isMainThread = Thread.isMainThread
        let prefix =
            isAsync ? "Executing task ⦷ asynchronously!" : "Executing task ⌽ synchronously!"
        print("\(prefix) Thread ID: \(threadId), Is Main Thread: \(isMainThread)")
        Thread.sleep(forTimeInterval: sleepTime)
    }

    func executeAsynchronously() {
        queue.async {
            executeTask(isAsync: true, sleepTime: 1.0)
        }
    }

    func executeSynchronously() {
        queue.sync {
            executeTask(isAsync: false, sleepTime: 5.0)
        }
    }

    func executeComplex() {
        let group = DispatchGroup()

        // Start 3 asynchronous tasks
        for i in 0..<3 {
            queue.async(group: group) {
                executeTask(isAsync: true, sleepTime: Double(0.5 + Double(i) * 0.2))
            }
        }

        // Start 1 synchronous task
        group.enter()
        queue.sync(flags: .barrier) {
            executeTask(isAsync: false, sleepTime: 2.0)
            group.leave()
        }

        group.notify(qos: .background) {
            print("All complex tasks completed.")
        }
    }
}

#Preview {
    ContentView()
}
