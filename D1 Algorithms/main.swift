//
//  main.swift
//  D1 Algorithms
//
//  Created by Xander Lewis on 12/02/2017.
//  Copyright © 2017 Xander Lewis. All rights reserved.
//
// Algorithms are implemented as they are defined in the Edexcel D1 specification

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
