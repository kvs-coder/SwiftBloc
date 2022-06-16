# SwiftBloc

[![Version](https://img.shields.io/cocoapods/v/SwiftBloc.svg?style=flat)](https://cocoapods.org/pods/SwiftBloc)
[![Platform](https://img.shields.io/cocoapods/p/SwiftBloc.svg?style=flat)](https://cocoapods.org/pods/SwiftBloc)

## About

Inspired from a really great Flutter package [flutter_bloc](https://pub.dev/packages/flutter_bloc) this SwiftUI library brings the state management with a BloC (Buisiness logic component) approach
to separate views and buisiness logic. With the help of Apple Library "Combine" the state management is handled with the reactive approach.

Requires iOS 13.0+ and MacOS 10.15+

## Start

At first you need to decide what approach is more suitable for your app. 

If you prefer to make something simple and make changes without depending on what event is currently hapening you could use a **Cubit** class to create your child cubit and handle state there.

If you would need more complex implementation to track events and map them into states then **Bloc** class is the choice.

In both scenarios you may also need to create inside your custom **View** structure a **BlocView** instance which will accept your newly created cubit/bloc in the initializer and also will require a **@ViewBuilder** builder function to be provided as well. The idea of the **BlocView** is to handle rebuilding your views inside the **builder** callback based on the current state. Whenever the state is changed your view gets rebuild. 

You can manipaulate with state as you want. In addition you can also provide to the  **BlocView** constructor a custom **action** callback which will let you to add some side logic or view behavior without returning any **View** conforming object.

By default all changes are tracked by a shared instance of **BlocObserver** and currently only make console printing. You can always set a custom observer for the shared instance and override open methods as you wish.

For convinience you can use a ruby script *bloc_template.rb*. You need to provide additional parameters for executing the script.
- path
- class_name
- type

Example:

```ruby
# creates a cubit
ruby bloc_template /MY_PROJECT/MY_CUBIT_FOLDER Counter cubit
```

```ruby
# creates a bloc
ruby bloc_template /MY_PROJECT/MY_BLOC_FOLDER Counter bloc
```

### Cubit

If you go with **Cubit** first you need to create a child class. The generic type **State** can be any type which conforms **Equitable** protocol.

With the super constructor you can provide the initial state. 

In order to emit a new state you need to use **emit(state:)** method

As a simple example the **CounterCubit** (the beloved one standar app from Flutter new project)

```swift 
import SwiftBloc

class CounterCubit: Cubit<Int> {
    init() {
        super.init(state: 0)
    }

    func increment() {
        emit(state: state + 1)
    }
    func decrement() {
         emit(state: state - 1)
    }
}
```

Next you need to use it in your views.

Since our **State**generic state is **Int** we can directly access to an integer getter **state** and display in in the text.

Next, inside your **body** property create a **BlocView** with some content:

```swift
var body: some View {
    BlocView(builder: { (cubit)  in
        VStack {
            Button(action: {
                cubit.increment()
            }, label: {
                Text("Increment")
            })
            Button(action: {
                cubit.decrement()
            }, label: {
                Text("Decrement")
            })
            Text("Count: \(cubit.state)")
        }
    }, cubit: CounterCubit())
}
```

In this case you may use **cubit** directly from a **builder**. Moreover this approach will let to use your **cubit** instance as an **@EnvironmentObject** so every child **view** inside your **builder** function will get the instance of **cubit** without a need "to drill" through the whole view tree.

### Bloc

If you go with **Bloc** first you need also to create a child class. The generic types **Event** and **State** can be any types which conforms **Equitable** protocol.

With the super constructor you can provide the initial state. 

The difference between **Cubit** and **Bloc** although the **Bloc** is a child class of the **Cubit** ist the the **Bloc** uses events to map them into states.

As a simple example the **CounterBloc**

```swift
import SwiftBloc

enum CounterEvent {
    case increment
    case decrement
}

struct CounterState: Equatable {
    let count: Int

    func copyWith(count: Int?) -> CounterState {
        CounterState(count: count ?? self.count)
    }
}

class CounterBloc: Bloc<CounterEvent, CounterState> {
    init() {
        super.init(initialState: CounterState(count: 0))
    }

    override func mapEventToState(event: CounterEvent) -> CounterState {
        switch event {
        case .increment:
            return state.copyWith(count: state.count + 1)
        case .decrement:
            return state.copyWith(count: state.count - 1)
        }
    }
}
```

The idea is, that everything what is happening in the app are events. Based on that you can call your event as you want, in the example the Enum is used (but you can also use Classes as well, but keep in mind to conform **Equatable** protocol).

If there are event, then there should be something what will tell about the current app state after the appropriate event.

You need to specify your state model for this. You can also use Classes with inheritance especially if you have some complicated states (and remebemer **Equatable**)

Now it is time to implement the child **Bloc** class.

You need to have a constructor where you specify the initial **State** value.

THE MOST IMPORTANT PART HERE - is to override the **mapEventToState(event:)** method. Without it nothing will work...

The goal of this method is to **transform events to states**.

So based on incoming events, the states are generated. You may create new objects of state using **CounterState** or your can create a method to copy the current state and provide changes to it.

Then the new state will be delivered to your **BlocView** and your view will be rebuilt automatically!

Now let's see what is the view looks like:

```swift
import SwiftBloc

struct BlocContentView: View {
    var body: some View {
        NavigationView {
            BlocView(builder: { (bloc) in
                let isPresented = Binding.constant(bloc.state.count < -6)
                CounterView()
                    .alert(isPresented: isPresented) {
                        Alert(
                            title: Text("Hi"),
                            message: Text("Message"),
                            dismissButton: .cancel {
                                for _ in 0..<6 {
                                    bloc.add(event: .increment)
                                }
                            }
                        )
                    }
            }, action: { (bloc) in
                print(bloc.state.count)
            }, base: CounterBloc())
            .navigationBarTitle(Text("Bloc"), displayMode: .inline)
        }
    }
}

struct CounterView: View {
    @EnvironmentObject var bloc: CounterBloc

    var body: some View {
        if bloc.state.count > 5 {
            LimitView()
        } else {
            OperationView()
        }
    }
}

struct LimitView: View {
    @EnvironmentObject var bloc: CounterBloc

    var body: some View {
        VStack {
            Text("Hooora")
            Button(action: {
                for _ in 0..<6 {
                    bloc.add(event: .decrement)
                }
            }, label: {
                Text("Reset")
            })
        }
    }
}

struct OperationView: View {
    @EnvironmentObject var bloc: CounterBloc

    var body: some View {
        VStack {
            Button(action: {
                bloc.add(event: .increment)
            }, label: {
                Text("Send Increment event")
            })
            Button(action: {
                bloc.add(event: .decrement)
            }, label: {
                Text("Send Decrement event")
            })
            Text("Count: \(bloc.state.count)")
        }
    }
}
```

The **Bloc** class is monitoring the changes of the **event** property via **@PublishedSubject** property wrapper. This **bloc** instance is set by default as **@EnvironmentObject** and will be available for all child views if needed.

### BlocTest

You may want to test your Blocs to be sure that the awaited states are actually happening if appropriate events passed in.

**BlocTest.execute** will expect to have four callbacks:

- **build** (create a Bloc instance inside the closure)
- **act** (provide a sequence of events)
- **expect** (set awaited states)
- **verify** (handle information about equality of expected and real states)

```swift
final class SwiftBlocTests: XCTestCase {
    func testCounterBlocInitial() {
        BlocTest.execute(build: {
            MockCounterBloc()
        }, act: { (_) in
            // DO NOTHING
        }, expect: {
            [
                MockCounterState(count: 0)
            ]
        }, verify: { areEqual, message in
            XCTAssert(areEqual, message)
        })
    }
    func testCounterBlocIncrement() {
        BlocTest.execute(build: {
            MockCounterBloc()
        }, act: { (bloc) in
            bloc.add(event: .increment)
            bloc.add(event: .increment)
        }, expect: {
            [
                MockCounterState(count: 0),
                MockCounterState(count: 1),
                MockCounterState(count: 2)
            ]
        }, verify: { areEqual, message in
            XCTAssert(areEqual, message)
        })
    }
    func testCounterBlocDecrement() {
        BlocTest.execute(build: {
            MockCounterBloc()
        }, act: { (bloc) in
            bloc.add(event: .decrement)
            bloc.add(event: .decrement)
        }, wait: 3.0, expect: {
            [
                MockCounterState(count: 0),
                MockCounterState(count: -1),
                MockCounterState(count: -2)
            ]
        }, verify: { areEqual, message in
            XCTAssert(areEqual, message)
        })
    }
}    
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

The library supports iOS 13 & above. 

## Installation

### Cocoapods

SwiftBloc is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftBloc'
```

or 

```ruby
pod 'SwiftBloc', '~> 1.0.3'
```

### Swift Package Manager

To install it, simply add the following lines to your Package.swift file
(or just use the Package Manager from within XCode and reference this repo):

```swift
dependencies: [
    .package(url: "https://github.com/VictorKachalov/SwiftBloc.git", from: "1.0.3")
]
```

### Carthage

Add the line in your cartfile 

```ruby
github "VictorKachalov/SwiftBloc" "1.0.3"
```

## Author

Victor Kachalov, victorkachalov@gmail.com

## License

SwiftBloc is available under the MIT license. See the LICENSE file for more info.

## Sponsorhip
If you think that my repo helped you to solve the issues you struggle with, please don't be shy and sponsor :-)
