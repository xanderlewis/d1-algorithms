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

/**
 Sorts an array using the bubble sort algorithm.
 
 - Parameter array:  The array to be sorted.
 
 - Returns: The array sorted in ascending order.
*/
public func bubbleSort<T: Comparable>(_ array: [T]) -> [T] {
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

/**
 Sorts an array using the quicksort algorithm.
 
 - Parameter array: The array to be sorted.
 
 - Returns: The array sorted in ascending order.
*/
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

/**
 Sorts an array using a functional implementation of the quicksort algorithm.
 
 - Parameter xs: The array to be sorted.
 
 - Returns: The array `xs` sorted in ascending order.
 */
public func functionalQuickSort<T: Comparable>(_ xs: [T]) -> [T] {
    guard xs.count > 1 else { return xs }
    
    let pivot = xs[xs.count/2]
    let left = xs.filter { $0 < pivot }
    let right = xs.filter { $0 >= pivot }
    
    return functionalQuickSort(left) + functionalQuickSort(right)
}

// MARK: - Searching algorithms

/**
 Searches for an item in an array.
 
 - Parameter toFind: The item to be searched for.
 
 - Returns: An integer value representing the index of the item in the array, or nil if it was not found.
 */
public func binarySearch<T: Comparable>(toFind item: T, in array: [T], withStartIndex index: Int = 0) -> Int? {
    var startIndex = index
    let pivot = array[array.count/2]
    
    guard pivot != item else { return startIndex + array.count/2 }
    
    guard array.count > 1 else { return nil }
    
    var temp = array
    if item < pivot {
        temp.removeLast(array.count/2)
    } else {
        temp.removeFirst(array.count/2 + 1)
        startIndex += array.count/2 + 1
    }
    
    return binarySearch(toFind: item, in: temp, withStartIndex: startIndex)
}

// MARK: - Bin packing algorithms

public typealias Height = Double
public typealias Bin = [Height]

public enum BinPackingAlgorithm {
    case firstFit, firstFitDecreasing, fullBin
}

fileprivate func sum(heights: [Height]) -> Height {
    return heights.reduce(0,+)
}

public func lowerBound(forItemHeights itemHeights: [Height], intoBinsOfHeight binHeight: Height) -> Int {
    let mean = Double(itemHeights.reduce(0, +)) / binHeight
    return Int(ceil(mean))
}

/**
 Packs an array of items into one or more fixed-height bins.
 
 - Parameter itemHeights: An array of the heights of the items.
 - Parameter intoBinsOfHeight: The height of the bins.
 - Parameter usingAlgorithm: The algorithms to be used to pack the items.
 
 - Returns: A tuple containing an array of bins packed with items, and a boolean value repesenting whether the solution found is optimal or not.
 */
public func pack(itemHeights: [Height], intoBinsOfHeight binHeight: Height, usingAlgorithm algorithm: BinPackingAlgorithm) -> ([Bin], Bool) {
    var bins: [Bin] = [[]]
    var items: [Height]
    
    switch algorithm {
    case .firstFit:
        items = itemHeights
    case .firstFitDecreasing:
        items = itemHeights.sorted(by: >)
    case .fullBin:
        fatalError("Not yet implemented.")
    }
    
    var didFit: Bool
    for item in items {
        didFit = false
        for i in 0..<bins.count {
            if item <= binHeight - sum(heights: bins[i]) {
                bins[i].append(item)
                didFit = true
            }
        }
        if !didFit {
            bins.append([item])
        }
    }
    
    let optimal = bins.count == lowerBound(forItemHeights: items, intoBinsOfHeight: binHeight)
    
    return (bins, optimal)
}
