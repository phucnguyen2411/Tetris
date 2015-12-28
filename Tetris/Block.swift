//
//  Block.swift
//  Tetris
//
//  Created by Phuc .Ng on 12/1/15.
//  Copyright © 2015 Phuc .Ng. All rights reserved.
//

import SpriteKit


let NumberOfColors: UInt32 = 6

// #2: Set co dinh kieu BlockColor
enum BlockColor: Int, CustomStringConvertible {
    
    // #3: Set color
    case Blue = 0, Orange, Purple, Red, Teal, Yellow
    
    // #4: Set value enum
    var spriteName: String {
        switch self {
        case .Blue:
            return "blue"
        case .Orange:
            return "orange"
        case .Purple:
            return "purple"
        case .Red:
            return "red"
        case .Teal:
            return "teal"
        case .Yellow:
            return "yellow"
        }
    }
    
    // #5: return value color
    var description: String {
        return self.spriteName
    }
    
    // #6: random start block color
    static func random() -> BlockColor {
        return BlockColor(rawValue:Int(arc4random_uniform(NumberOfColors)))!
    }
    
}

//Set color cho 1 khoi block khi xuat hien trung mau nhau

class Block: Hashable, CustomStringConvertible {
    // #8
    // Constants
    let color: BlockColor
    
    // #9
    // Properties
    var column: Int
    var row: Int
    var sprite: SKSpriteNode?
    
    // #10: tra ve gia tri mau ma khoi shape do duoc set
    var spriteName: String {
        return color.spriteName
    }
    
    
    var hashValue: Int {
        return self.column ^ self.row
    }
    
    //Tra ve Mau Block, Loai hinh tu, va hang gi
    var description: String {
        return "\(color): [\(column), \(row)]"
    }
    //Contructor
    init(column:Int, row:Int, color:BlockColor) {
        self.column = column
        self.row = row
        self.color = color
    }
}

//Set value block contractor
func ==(lhs: Block, rhs: Block) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row && lhs.color.rawValue == rhs.color.rawValue
}