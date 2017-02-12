//
//  main.swift
//  D1 Algorithms
//
//  Created by Xander Lewis on 12/02/2017.
//  Copyright © 2017 Xander Lewis. All rights reserved.
//
// Algorithms are implemented exactly as they are defined in the Edexcel D1 specification (even if this is not the most efficient solution)

import Foundation

// MARK: - Sorting Algorithms

public func bubbleSort(array: [Int]) -> [Int] {
    var sorted = array
    var swapsWereNeeded: Bool
    
    repeat {
        swapsWereNeeded = false
        for i in 0..<sorted.count - 1 {
            if sorted[i] > sorted[i+1] {
                swap(&sorted[i], &sorted[i+1])
                swapsWereNeeded = true
            }
        }
    } while swapsWereNeeded
    
    return sorted
}

public func quickSort<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else { return array }
    
    let pivot = array[array.count/2]
    
    var left: [T] = []
    var right: [T] = []
    
    for elem in array {
        if elem < pivot {
            left.append(elem)
        } else {
            right.append(elem)
        }
    }
    
    return quickSort(left) + quickSort(right)
}

public func functionalQuickSort<T: Comparable>(_ xs: [T]) -> [T] {
    guard xs.count > 1 else { return xs }
    
    let pivot = xs[xs.count/2]
    let left = xs.filter { $0 < pivot }
    let right = xs.filter { $0 >= pivot }
    
    return functionalQuickSort(left) + functionalQuickSort(right)
}

// MARK: - Searching algorithms

public func binarySearch<T: Comparable>(toFind item: T, in array: [T], withStartIndex index: Int = 0) -> Int {
    var startIndex = index
    let pivot = array[array.count/2]
    
    guard pivot != item else { return startIndex + array.count/2 }
    
    var temp = array
    if item < pivot {
        temp.removeLast(array.count/2)
    } else {
        temp.removeFirst(array.count/2 + 1)
        startIndex += array.count/2 + 1
    }
    
    return binarySearch(toFind: item, in: temp, withStartIndex: startIndex)
}
