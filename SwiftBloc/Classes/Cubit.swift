import Combine

struct CubitUnhandledError: Error {
    let error: Any
    
    var localizedDescription: String {
        return "Unhandled error occurred: \(error)"
    }
    
    init(error: Any) {
        self.error = error
    }
}

open class Cubit<State> where State: Equatable {
    private var _state: State

    private let subject = PassthroughSubject<State, Never>()

    var subscriber: AnyCancellable?
    var emitted = false
    
    public var state: State {
        return _state
    }
    
    public var observer: BlocObserver?
    
    public init(state: State) {
        self._state = state
        observer?.onCreate(cubit: self)
    }
    
    public func emit(state: State) {
        if state == _state && emitted {
            return
        }
        onChange(change: Change(currentState: self.state, nextState: state))
        _state = state
        subject.send(_state)
        emitted = true
    }
    
    public func listen(
        onCompletion: @escaping (Subscribers.Completion<Never>) -> Void,
        onValue: @escaping (State) -> Void
    ) {
        subscriber = subject.sink(
            receiveCompletion: onCompletion,
            receiveValue: onValue
        )
    }

    open func onError(error: Error) {
        observer?.onError(cubit: self, error: error)
    }
    
    open func onChange(change: Change<State>) {
        observer?.onChange(cubit: self, change: change)
    }
    
    public func close() {
        observer?.onClose(cubit: self)
        subscriber?.cancel()
    }
}
