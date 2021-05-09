//
//  Reader.swift
//  Readers and Writers
//
//  Created by Alex on 5/9/21.
//

import Foundation

class OperationPerformer {
    weak var storage: Storage?
    let id: Int
    private var operation: ((Storage, Int) -> Void)?
    private let iq = OperationQueue()
    
    init(id: Int, storage: Storage ) {
        self.id = id
        self.storage = storage
        iq.maxConcurrentOperationCount = 1
    }
    
    func perform(_ operation: @escaping ((Storage, Int) -> Void)) {
        self.operation = operation
        performOperation()
    }
    
    private func performOperation() {
        iq.addOperation {[weak self] in
            guard let s = self, let storage = s.storage else {
                return
            }
                        
            s.operation?(storage, s.id)
            s.performOperation()
        }
    }
}

