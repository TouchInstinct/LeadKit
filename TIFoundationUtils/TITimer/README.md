# TITimer
## Pretty timer ⏰

Эта библиотека позволяет создавать таймер, который работает как с [RunLoop'ом](#Runloop) , так и с [GCD](#GCD).

### Особенности

- Учитывает время проведенное приложением в background состоянии. Детали - [TimerRunMode](Sources/TITimer/Enums/TimerRunMode.swift)
- Можно создавать таймер на собственной очереди или на необходимом режиме Runloop'а. Детали - [TimerType](Sources/TITimer/Enums/TimerType.swift)

### Runloop.main vs GCD

#### Особенности работы таймера с Runloop.main

- Runloop есть у каждого потока, но сразу запущенный только у главного - Runloop.main
- Устанавливая таймер для конкретного режима Runloop.main, мы получаем события в eventHandler, только когда Runloop находится в данном состоянии
- Runloop.main может работать в трех режимах:    
     - `traking` - когда активно взаимодействуем с приложением, например, скроллим таблицу
     - `default` - все остальные состояния отличные от traking
     - `common` - включает в себя обработку событий и traking, и default

#### Особенности работы таймера с GCD

- Вызов метода eventHandler будет происходить на той же очереди, на которую добавили
- Eсли хотите обновлять UI, то необходимо быть уверенным, что перевели выполнение на главную очередь!

#### Что выбрать

- Используйте Runloop.main, когда необходимо обрабатывать события таймера на главном потоке, например, обновлять UI
- Используйте GCD, если обработка событий таймера не требует работы с UI или она слишком ресурсоёмкая и не хотите нагружать главный поток
- Вы также можете создать свой поток и Runloop, но эта ситуация слишком редкая в повседневной разработке, что рассматривать её не будем

В 90% случаев достаточно использовать упрощенный инициализатор, который использует Runloop.main с режимом common - `TITimer(mode: TimerRunMode)`.

### Примеры

#### Упрощенная инициализация

```swift
timer = TITimer(mode: .onlyActive)
timer = TITimer(mode: .activeAndBackground)
```

#### Runloop.main

```swift
timer = TITimer(type: .runloopTimer(runloop: .main, mode: .common), mode: .onlyActive)
```
#### GCD

```swift
timer = TITimer(type: .dispatchSourceTimer(queue: .main), mode: .activeAndBackground)
```

#### Возможные активности

```swift        
timer.eventHandler = {
   // Получаем события
}
        
timer.start() // Запустить таймер
timer.pause() // Останавливаем таймер
timer.resume() // Возобновляем его работу
timer.invalidate() // Уничтожаем таймер
```
