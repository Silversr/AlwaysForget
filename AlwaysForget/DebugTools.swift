//
//  DebugTool.swift
//  AlwaysForget
//
//  Created by User on 6/07/2015.
//  Copyright (c) 2015 Silversr. All rights reserved.
//

import Foundation
func SZLOG<T>(info:T,fileName:String = __FILE__,funcName:String = __FUNCTION__){
    var fileNm = fileName.lastPathComponent
    for i in 0...5 {
        fileNm = fileNm.substringToIndex(fileNm.endIndex.predecessor())
    }
    println("\(fileNm) \(funcName): \(info)")
}