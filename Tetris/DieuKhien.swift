//
//  DieuKhien.swift
//  Tetris
//
//  Created by Phuc .Ng on 12/10/15.
//  Copyright © 2015 Phuc .Ng. All rights reserved.
//

//Set so cot va hang khoi tao giao dien
let NumColumns = 15
let NumRows = 26

//Vi tri khoi shape xuat hien
let StartingColumn = 4
//An vi hang xuat hien shape
let StartingRow = 0

//Vi tri khoi shape xuat hien preview
let PreviewColumn = 20
let PreviewRow = 0

//Set gia tri toc do ban dau cho 1 khoi shape roi xuong
let PointsPerLine = 10
let LevelThreshold = 1000




protocol DieuKhienDelegate {
    // duoc goi khi tro choi khoi chay
    func gameDidEnd(dieukhien: DieuKhien)
    
    // duoc goi sau khi tro choi bat dau
    func gameDidBegin(dieukhien: DieuKhien)
    
    // Goi lan luot cac hinh duoc xuat hien
    func gameShapeDidLand(dieukhien: DieuKhien)
    
    // Ham di chuyen cac khoi
    func gameShapeDidMove(dieukhien: DieuKhien)
    
    // Cac khoi hinh tut xuong dan phia duoi
    func gameShapeDidDrop(dieukhien: DieuKhien)
    
    
}

class DieuKhien {
    var blockArray:KhungGame<Block>
    var nextShape:Shape?
    var fallingShape:Shape?
    var delegate: DieuKhienDelegate?
    
    
    
    init() {
        fallingShape = nil
        nextShape = nil
        blockArray = KhungGame<Block>(columns: NumColumns, rows: NumRows)
    }
    
    func beginGame() {
        if (nextShape == nil) {
            nextShape = Shape.random(PreviewColumn, startingRow: PreviewRow)
        }
        
        delegate?.gameDidBegin(self)
    }
    
        func newShape() -> (fallingShape:Shape?, nextShape:Shape?) {
        fallingShape = nextShape
        nextShape = Shape.random(PreviewColumn, startingRow: PreviewRow)
        fallingShape?.moveTo(StartingColumn, row: StartingRow)
        //detect value khi khoi shape cham row = max -> newShape -> func newDecPle
        guard detectIllegalPlacement() == false else {
            nextShape = fallingShape
            nextShape!.moveTo(PreviewColumn, row: PreviewRow)
            endGame()
            return (nil, nil)
        }
        return (fallingShape, nextShape)
    }
    
    
    
    //Tra ve toa do row + colums cho lop GameviewController xu li
    func detectIllegalPlacement() -> Bool {
        guard let shape = fallingShape else {
            return false
        }
        for block in shape.blocks {
            if block.column < 0 || block.column >= NumColumns
                || block.row < 0 || block.row >= NumRows {
                    return true
            } else if blockArray[block.column, block.row] != nil {
                return true
            }
        }
        return false
}
    
    
    //Not working
    func dropShape() {
        guard let shape = fallingShape else {
            return
        }
        while detectIllegalPlacement() == false {
            shape.lowerShapeByOneRow()
        }
        shape.raiseShapeByOneRow()
        delegate?.gameShapeDidDrop(self)
    }
    
    func letShapeFall() {
        guard let shape = fallingShape else {
            return
        }
        shape.lowerShapeByOneRow()
        if detectIllegalPlacement() {
            shape.raiseShapeByOneRow()
            if detectIllegalPlacement() {
                endGame()
            } else {
                settleShape()
            }
        } else {
            delegate?.gameShapeDidMove(self)
            if detectTouch() {
                settleShape()
            }
        }
    }
    
    
    func rotateShape() {
        guard let shape = fallingShape else {
            return
        }
        shape.rotateClockwise()
        guard detectIllegalPlacement() == false else {
            shape.rotateCounterClockwise()
            return
        }
        delegate?.gameShapeDidMove(self)
    }
    
    
    func moveShapeLeft() {
        guard let shape = fallingShape else {
            return
        }
        shape.shiftLeftByOneColumn()
        guard detectIllegalPlacement() == false else {
            shape.shiftRightByOneColumn()
            return
        }
        delegate?.gameShapeDidMove(self)
    }
    
    func moveShapeRight() {
        guard let shape = fallingShape else {
            return
        }
        shape.shiftRightByOneColumn()
        guard detectIllegalPlacement() == false else {
            shape.shiftLeftByOneColumn()
            return
        }
        delegate?.gameShapeDidMove(self)
    }
    
    
    func settleShape() {
        guard let shape = fallingShape else {
            return
        }
        for block in shape.blocks {
            blockArray[block.column, block.row] = block
        }
        fallingShape = nil
        delegate?.gameShapeDidLand(self)
    }
    
    
    func detectTouch() -> Bool {
        guard let shape = fallingShape else {
            return false
        }
        for bottomBlock in shape.bottomBlocks {
            if bottomBlock.row == NumRows - 1
                || blockArray[bottomBlock.column, bottomBlock.row + 1] != nil {
                    return true
            }
        }
        return false
    }
    
    func nextLevel(){
        
    }
    

    
    func endGame() {
        
        delegate?.gameDidEnd(self)
    }
    
    
    

}