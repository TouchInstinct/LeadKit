//
//  ITimer.swift
//  
//
//  Created by Vlad Suhomlinov on 15.08.2021.
//

import Foundation

public protocol ITimer: IInvalidatable {
    
    // Прошедшее время
    var elapsedTime: TimeInterval { get }
    
    // Запущен таймер или нет
    var isRunning: Bool { get }
    
    // Подписка на изменение прошедшего времени
    var eventHandler: ((TimeInterval) -> Void)? { get set }
    
    // Запустить работу таймера
    func start(with interval: TimeInterval)
}
