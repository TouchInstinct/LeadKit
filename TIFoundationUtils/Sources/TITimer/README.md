# TITimer
## Pretty timer ⏰

The library allows you to create a timer that works either with [RunLoop](#Runloop) or with [GCD](#GCD).

### Features

- Track the time even while the application is in the background. For more, see - [TimerRunMode](/Sources/TITimer/Enums/TimerRunMode.swift)
- Create a timer on a personal queue or on a special Runloop mode. For more, see - [TimerType](Sources/TITimer/Enums/TimerType.swift)
- The code is covered by tests 🙂

### Examples

#### RunLoop

```swift
timer = TITimer(type: .runloopTimer(runloop: .current, mode: .default), mode: .activeAndBackground)
        
timer.eventHandler = {
   // handle elapsed time
}
        
timer.start()
timer.invalidate()
```
#### GCD

```swift
timer = TITimer(type: .dispatchSourceTimer(queue: .main), mode: .activeAndBackground)
        
timer.eventHandler = {
   // handle elapsed time
}
        
timer.start()
timer.invalidate()
```
