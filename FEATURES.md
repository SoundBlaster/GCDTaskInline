# Features

1.  **Asynchronous Execution Demo:** A button to execute a task asynchronously on a background queue using `DispatchQueue.global().async`. It updates the UI status before starting and upon completion.
2.  **Synchronous Execution Demo:** A button to execute a task synchronously on a background queue using `DispatchQueue.global().sync`. Includes a warning that doing this on the main thread will block the UI.
3.  **Async/Await Execution Demo:** A button to demonstrate using Swift's `async/await` syntax for asynchronous operations, including `Task.sleep`.
4.  **Complex Execution Demo:** A button that triggers a more complex scenario involving multiple asynchronous tasks and one synchronous barrier task (`sync(flags: .barrier)`), coordinated using a `DispatchGroup`. It also shows how to use `group.notify` for a completion callback on the main queue.
5.  **Status Updates:** The UI displays the current status of operations, updated from background tasks.
6.  **Thread Information Logging:** The core `executeTask` function prints information about whether it's running synchronously or asynchronously, its thread ID, and whether it's on the main thread.