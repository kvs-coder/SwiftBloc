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
    private var emitted = false
    private let subject = PassthroughSubject<State, Never>()
    private var subscriber: AnyCancellable?
    
    public var state: State {
        return _state
    }
    
    private var observer: BlocObserver {
        return Bloc.observer
    }
    
    public init(state: State, onCompletion: @escaping (Subscribers.Completion<Never>) -> Void, onValue: @escaping (State) -> Void) {
        self._state = state
        observer.onCreate(cubit: self)
        subscriber = subject.sink(
            receiveCompletion: onCompletion,
            receiveValue: onValue
        )
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
    
    func addError(error: Any) {
        onError(error: error)
    }
    
    func onError(error: Any) {
        observer.onError(cubit: self, error: error)
    }
    
    func onChange(change: Change<State>) {
        observer.onChange(cubit: self, change: change)
    }
    
    public func close() {
        observer.onClose(cubit: self)
        subscriber?.cancel()
    }
}
