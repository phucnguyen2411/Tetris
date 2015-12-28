//
//  KhungGame.swift
//  Tetris
//
//  Created by Phuc .Ng on 12/15/15.
//  Copyright © 2015 Phuc .Ng. All rights reserved.
//

//Khai bao mot mang luu colum + row cho ca cac class khac extend
class KhungGame<T> {
    let columns: Int
    let rows: Int
    var array: Array<T?>
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        array = Array<T?>(count:rows * columns, repeatedValue: nil)
    }
    
    
    subscript(column: Int, row: Int) -> T? {
        get {
            return array[(row * columns) + column]
        }
        set(newValue) {
            array[(row * columns) + column] = newValue
        }
    }
}