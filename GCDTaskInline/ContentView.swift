//
//  ContentView.swift
//  GCDTaskInline
//
//  Created by Egor Merkushev on 04.05.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var status: String = "Ready"
    
    let queue = DispatchQueue.global()
    
    var body: some View {
        VStack {
            Text(status)
                .padding(.bottom)
            
            Button("Execute Asynchronously") {
                Task {
                    await executeAsynchronously()
                }
            }
            Button("Execute Synchronously") {
                executeSynchronously()
            }
            Button("Execute with async/await") {
                Task {
                    await executeWithAsyncAwait()
                }
            }
            Button("Execute Complex") {
                executeComplex()
            }
        }
        .padding()
    }
    
    // MARK: - Actions
    
    /// Demonstrates executing a task asynchronously on a background queue.
    /// Updates status before and after the async task.
    private func executeAsynchronously() async {
        await updateStatus("Started async task…")
        queue.async {
            executeTask(isAsync: true, sleepTime: 1.0)
            DispatchQueue.main.async {
                Task {
                    await updateStatus("Async task completed.")
                }
            }
        }
    }
    
    /// Demonstrates executing a task synchronously on a background queue.
    /// WARNING: Calling queue.sync on the main thread can block the UI.
    /// Updates status before and after the sync task.
    func executeSynchronously() {
        Task {
            await updateStatus("Started sync task (may block UI)…")
        }
        // Caution: If this is called on the main thread, this sync call will block the UI until complete.
        queue.sync {
            executeTask(isAsync: false, sleepTime: 1.0)
            DispatchQueue.main.async {
                Task {
                    await updateStatus("Sync task completed.")
                }
            }
        }
    }
    
    /// Demonstrates a complex scenario with multiple async tasks and one sync barrier task.
    /// Uses a DispatchGroup to notify when all tasks are finished.
    /// Updates status before starting and after all tasks complete.
    func executeComplex() {
        Task {
            await updateStatus("Started complex task…")
        }
        
        let group = DispatchGroup()
        
        // Start 3 asynchronous tasks
        for i in 0..<3 {
            queue.async(group: group) {
                executeTask(isAsync: true, sleepTime: Double(0.5 + Double(i) * 0.2))
            }
        }
        
        DispatchQueue.main.async {
            group.enter()
            // Caution: Using queue.sync(flags: .barrier) here can block the main thread.
            queue.sync(flags: .barrier) {
                executeTask(isAsync: false, sleepTime: 2.0)
                group.leave()
            }
        }
        
        group.notify(qos: .background, queue: .main) {
            Task {
                await updateStatus("All complex tasks completed.")
            }
        }
    }
    
    /// Demonstrates using async/await for asynchronous delay and status updates.
    private func executeWithAsyncAwait() async {
        await updateStatus("Executing with async/await…")
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        await updateStatus("Async/await task completed.")
    }
    
    /// Executes the simulated work with info about sync or async and sleeps to simulate work.
    private func executeTask(isAsync: Bool, sleepTime: Double) {
        let threadId = Thread.current.hash
        let isMainThread = Thread.isMainThread
        let prefix =
        isAsync ? "Executing task ⦷ asynchronously!" : "Executing task ⌽ synchronously!"
        print("\(prefix) Thread ID: \(threadId), Is Main Thread: \(isMainThread)")
        Thread.sleep(forTimeInterval: sleepTime)
    }
    
    /// Updates the status string on the main actor (UI thread).
    @MainActor
    private func updateStatus(_ msg: String) async {
        status = msg
    }
}

#Preview {
    ContentView()
}
