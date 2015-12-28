//
//  KhoiVuong.swift
//  Tetris
//
//  Created by Phuc .Ng on 12/15/15.
//  Copyright © 2015 Phuc .Ng. All rights reserved.
//


//impement shape
class KhoiVuong:Shape {
    /*
    | 0•| 1 |
    | 2 | 3 |
    
    • danh dau hinh thu de su dung ben shape
    
    */
    
    // Vi khoi vuong khong the xoay duoc nen gan gia tri chet
    
    
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero: [(0, 0), (1, 0), (0, 1), (1, 1)],
            Orientation.OneEighty: [(0, 0), (1, 0), (0, 1), (1, 1)],
            Orientation.Ninety: [(0, 0), (1, 0), (0, 1), (1, 1)],
            Orientation.TwoSeventy: [(0, 0), (1, 0), (0, 1), (1, 1)]
        ]
    }
    
    
    override var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [
            Orientation.Zero:       [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.OneEighty:  [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety:     [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.TwoSeventy: [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]]
        ]
    }
}
