import Foundation

///При получении ошибки из `gnoringErrors` повторение отправки до `numberOfAttempts` раз
class IgnoringErrorsRepeatClosure {
    private(set) var numberOfAttempts: Int
    private var ignoringErrors: Set<BaseErrorResponseBody>
    
    init(ignoringErrors: Set<BaseErrorResponseBody> = [], numberOfAttempts: Int) {
        self.ignoringErrors = ignoringErrors
        self.numberOfAttempts = numberOfAttempts
    }
        
    func performIfNeeded(with error: BaseErrorResponseBody,
                  repeatClosure: VoidClosure,
                  errorCompletion: ParameterClosure<BaseErrorResponseBody>?) {
        if ignoringErrors.contains(error) && numberOfAttempts > 0 {
            numberOfAttempts -= 1
            repeatClosure()
        } else {
            errorCompletion?(error)
        }
    }
}
