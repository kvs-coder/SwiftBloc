# SwiftBloc

[![Version](https://img.shields.io/cocoapods/v/SwiftBloc.svg?style=flat)](https://cocoapods.org/pods/SwiftBloc)
[![Platform](https://img.shields.io/cocoapods/p/SwiftBloc.svg?style=flat)](https://cocoapods.org/pods/SwiftBloc)

## About

Inspired from a really great Flutter package [flutter_bloc](https://pub.dev/packages/flutter_bloc) this SwiftUI library brings the state management with a BloC (Buisiness logic component) approach
to separate views and buisiness logic. With the help of Apple Library "Combine" the state management is handled with the reactive approach.

## Start

At first you need to decide what approach is more suitable for your app. 

If you prefer to make something simple and make changes without depending on what event is currently hapening you could use a **Cubit** class to create your child cubit and handle state there.

If you would need more complex implementation to track events and map them into states then **Bloc** class is the choice.

In both scenarios you may also need to create inside your custom **View** structure a **BlocView** instance which will accept your newly created cubit/bloc in the initializer and also will require a **@ViewBuilder** builder function to be provided as well. The idea of the **BlocView** is to handle rebuilding your views inside the **builder** callback based on the current state. Whenever the state is changed your view gets rebuild. 

You can manipaulate with state as you want. In addition you can also provide to the  **BlocView** constructor a custom **action** callback which will let you to add some side logic or view behavior without returning any **View** conforming object.

By default all changes are tracked by a shared instance of **BlocObserver** and currently only make console printing. You can always set a custom observer for the shared instance and override open methods as you wish.

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

Take a look on the next example without wrapping in a **BlocView**.

```swift 
struct CubitContentView: View {
    @ObservedObject var cubit = CounterCubit()

    var body: some View {
        VStack {
            Button(action: {
                self.cubit.increment()
            }, label: {
                Text("Increment")
            })
            Button(action: {
                self.cubit.decrement()
            }, label: {
                Text("Decrement")
            })
            Text("Count: \(cubit.state)")
        }
    }
}

struct CubitContentView_Previews: PreviewProvider {
    static var previews: some View {
        CubitContentView()
    }
}
```

It is important the the **cubit** instance is wrapped inside **@ObservedObject** property wrapper because the **Cubit** class is monitoring the changes of the **state** property via **@PublishedSubject** property wrapper.

Since our **State**generic state is **Int** we can directly access to an integer getter **state** and display in in the text.

If you want to wrap your **view** in your **body** in a **BlocView** it is done like this:

```swift
var body: some View {
    BlocView(builder: { (state)  in
        VStack {
            Button(action: {
                self.cubit.increment()
            }, label: {
                Text("Increment")
            })
            Button(action: {
                self.cubit.decrement()
            }, label: {
                Text("Decrement")
            })
            Text("Count: \(state)")
        }
    }, cubit: cubit)
}
```

In this case you may use **state** directly from a **builder** in order to redruce a getter call from **cubit**. Moreover the benefit of this approach will let to use your **cubit** instance as an **@EnvironmentObject** so every child **view** inside your **builder** function will get the instance of **cubit** without a need "to drill" through the whole view tree.

### Bloc

If you go with **Bloc** first you need also to create a child class. The generic types **Event** and **State** can be any types which conforms **Equitable** protocol.

With the super constructor you can provide the initial state. 

The difference between **Cubit** and **Bloc** although the **Bloc** is a child class of the **Cubit** ist the the **Bloc** uses events to map them into states.

As a simple example the **CounterBloc**

```swift
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
        super.init(intialState: CounterState(count: 0))
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
    @ObservedObject var bloc = CounterBloc()

    @State var isAlertCalled = false

    var body: some View {
        BlocView(builder: { (state) in
            VStack {
                if state.count > 5 {
                    LimitView()
                } else {
                    OperationView()
                }
            }
            .alert(isPresented: self.$isAlertCalled) {
                Alert(title: Text("Hi"), message: Text("Message"), dismissButton: .cancel({
                    self.bloc.add(event: .increment)
                    self.bloc.add(event: .increment)
                }))
            }
        }, action: { (state) in
            print(state.count)
            if state.count < -1 {
                DispatchQueue.main.async {
                    self.isAlertCalled = true
                }
            }
        }, cubit: bloc)
    }
}

struct LimitView: View {
    @EnvironmentObject var bloc: CounterBloc

    var body: some View {
        VStack {
            Text("Hooora")
            Button(action: {
                self.bloc.add(event: .decrement)
                self.bloc.add(event: .decrement)
                self.bloc.add(event: .decrement)
                self.bloc.add(event: .decrement)
                self.bloc.add(event: .decrement)
                self.bloc.add(event: .decrement)
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
                self.bloc.add(event: .increment)
            }, label: {
                Text("Send Increment event")
            })
            Button(action: {
                self.bloc.add(event: .decrement)
            }, label: {
                Text("Send Decrement event")
            })
            Text("Count: \(bloc.state.count)")
        }
    }
}

struct BlocContentView_Previews: PreviewProvider {
    static var previews: some View {
        BlocContentView()
    }
}
```

Again it is important the the **bloc** instance is wrapped inside **@ObservedObject** property wrapper because the **Bloc** class is monitoring the changes of the **event** property via **@PublishedSubject** property wrapper. This **bloc** instance is set by default as **@EnvironmentObject** and will be available for all child views if needed.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

The library supports iOS 13 & above. 

## Installation

### Cocoapods

HealthKitReporter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftBloc'
```

or 

```ruby
pod 'SwiftBloc', '~> 1.0.0'
```

### Swift Package Manager

To install it, simply add the following lines to your Package.swift file
(or just use the Package Manager from within XCode and reference this repo):

```swift
dependencies: [
    .package(url: "https://github.com/VictorKachalov/SwiftBloc.git", from: "1.0.0")
]
```

### Carthage

Add the line in your cartfile 

```ruby
github "VictorKachalov/SwiftBloc" "1.0.0"
```

## Author

Victor Kachalov, victorkachalov@gmail.com

## License

SwiftBloc is available under the MIT license. See the LICENSE file for more info.

## Donation
If you think that my repo helped you to solve the issues you struggle with, please don't be shy and donate :-)

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/paypalme/VictorKachalov/5EUR)
