//
//  Event.swift
//  ARtestt
//
//  Created by David Mahbubi on 10/08/23.
//

class Event {
    
    static var listeners: [String: () -> Void] = [:]
    
    static func addEventListener(on eventName: String, action callback: @escaping () -> Void) {
        listeners[eventName] = callback
    }
    
    static func emmit(event eventName: String) {
        guard let listener = listeners[eventName] else { return }
        listener()
    }
}
