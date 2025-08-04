# TODO

- [ ] Review and potentially refactor `executeComplex()` to avoid blocking the main thread when using `queue.sync(flags: .barrier)`.
- [ ] Consider adding explicit error handling for `CancellationError` in `executeWithAsyncAwait()` when calling `Task.sleep`.
- [ ] Verify if the current behavior of `executeSynchronously()` regarding UI blocking is clearly communicated in its documentation or comments, or if it needs adjustment for safer default demonstration.