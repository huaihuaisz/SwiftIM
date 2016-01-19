//
//  Inputs.swift
//  CloodIMTest
//
//  Created by mac on 16/1/11.
//  Copyright © 2016年 hxrh. All rights reserved.
//

import Foundation

extension Inputs: BooleanType {
    var boolValue: Bool {
        return self.rawValue == 0b111
    }
}

struct Inputs: OptionSetType {
    let rawValue: Int
    
    static let user = Inputs(rawValue: 1) // 1
    static let pass = Inputs(rawValue: 1 << 1) // 10
    static let mail = Inputs(rawValue: 1 << 2) // 100
}

//判断是否全部输入
extension Inputs {
    func isAllOK() -> Bool {
//        return self == [.user, .pass, .mail]
//        return self.rawValue == 0b111
        //选项的数目
        let count = 3
        //找到几项
        var found = 0
        
        for time in 0..<count {
            if self.contains(Inputs(rawValue:1 << time)) {
                found++
            }
        }
        return found == count
    }
}

let possibleInputs : Inputs = [.user, .pass]




