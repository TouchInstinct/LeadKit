import TIFoundationUtils
import TINetworking

open class CartRequestExecutor<S: Decodable, AE: Decodable, NE>: Cancellable {
    public typealias ExecutionCompletion = (EndpointRecoverableRequestResult<S, AE, NE>) -> Void
    public typealias ExecutionClosure = (ExecutionCompletion) -> Cancellable

    public typealias SuccessCompletion = (S) -> Void

    private let executionClosure: ExecutionClosure
    public var successCompletion: SuccessCompletion

    private var executingRequest: Cancellable?

    public init(executionClosure: @escaping ExecutionClosure, successCompletion: @escaping SuccessCompletion) {
        self.executionClosure = executionClosure
        self.successCompletion = successCompletion
    }

    open func execute() {
        executingRequest?.cancel()

        _ = executionClosure { [weak self] in
            switch $0 {
            case let .success(result):
                self?.handle(successResult: result)
            case let .failure(errorCollection):
                self?.handle(failure: errorCollection)
            }
        }
    }

    open func handle(successResult: S) {
        successCompletion(successResult)
    }

    open func handle(failure: ErrorCollection<EndpointErrorResult<AE, NE>>) {
        if shouldRetry(failure: failure) && 0 < 3 {
            execute()
        }
    }

    open func shouldRetry(failure: ErrorCollection<EndpointErrorResult<AE, NE>>) -> Bool {
        if case .networkError = failure.failures.first {
            return true
        }

        return false
    }

    open func cancel() {
        executingRequest?.cancel()
    }
}
