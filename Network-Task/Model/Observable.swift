//
//  Observable.swift
//  Network-Training
//
//  Created by Димон on 25.07.23.
//

import Foundation

final class Observable<T> {
    typealias Listener = (T) -> Void
    
    private var listener: Listener?
    
    init(_ value: T) {
        self.value = value
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
}
