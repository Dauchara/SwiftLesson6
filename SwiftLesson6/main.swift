//
//  main.swift
//  SwiftLesson6
//
//  Created by Ниязов Ринат Раимжанович on 1/1/21.
//

import Foundation

class InfoModel {
    var id: Int
    var info: String
    
    init(id: Int, info: String) {
        self.id = id
        self.info = info
    }
}

extension InfoModel: CustomStringConvertible {
    var description: String {
        return "ID:\(id), Info:\(info)"
    }
}

struct Queue<T> {
    private var elements: [T] = []
    
    mutating func enqueue(_ element: T) {
        elements.append(element)
    }
    
    mutating func dequeue() -> T? {
        guard !elements.isEmpty else { return .none }
        
        let outputElement = elements[0]
        elements.remove(at: 0)
        
        return outputElement
    }
    
    subscript(index: Int) -> T? {
        if elements.count >= index && index >= 0 {
            print(elements[index])
            return elements[index]
        } else {
            print("There is no element")
            return .none
        }
    }
}

extension Queue: CustomStringConvertible {
    var description: String {
        guard !elements.isEmpty else { return "Queue is empty" }
 
        return "There are \(elements.count) elements in the queue"
    }
    
    func sortElements(functionSort: ([T]) -> [T]) -> [T] {
        return functionSort(elements)
    }
    
    
    func filterElements(functinoFilter: (T) -> Bool) -> [T] {
        var resultElements: [T] = []
        
        for element in elements {
            if functinoFilter(element) {
                resultElements.append(element)
            }
        }
        
        return resultElements
    }
}


var que = Queue<Int>()

que.enqueue(1)
que.enqueue(2)
que.enqueue(5)
que.enqueue(3)

print(que)

var peekValue = que[3]
peekValue = que[6]

let dequeueValue = que.dequeue()
print(que)

let filteredElements = que.filterElements(functinoFilter: {
    return $0 != 2
})
print(filteredElements)


var infoBoard = Queue<InfoModel>()
infoBoard.enqueue(InfoModel(id: 0, info: "Info 1"))
infoBoard.enqueue(InfoModel(id: 1, info: "Info 2"))
infoBoard.enqueue(InfoModel(id: 2, info: "Info 3"))
infoBoard.enqueue(InfoModel(id: 3, info: "Info 4"))
print(infoBoard)

var sortedInfo = infoBoard.sortElements{ //bubble sort
    var sortedResult = $0
    for i in 0..<sortedResult.count {
        for j in 1..<sortedResult.count - i {
            if sortedResult[j].id < sortedResult[j-1].id {
                let tmp = sortedResult[j-1]
                sortedResult[j-1] = sortedResult[j]
                sortedResult[j] = tmp
            }
        }
    }
    return sortedResult
}
print(sortedInfo)

sortedInfo = infoBoard.sortElements(functionSort: { //optional sort
    return $0.sorted { $0.id > $1.id }
})
print(sortedInfo)

var filteredInfo = infoBoard.filterElements(functinoFilter: {
    $0.id != 3 && $0.info != "Info 3"
})
print(filteredInfo)



