//
//  TimerRunMode.swift
//  
//
//  Created by Vlad Suhomlinov on 15.08.2021.
//

public enum TimerRunMode {
    
    // Время таймера изменяется только при активной работе приложения
    case onlyActive
    
    // Время таймера изменяется и при активном и свернутом состоянии приложения
    case activeAndBackground
}
