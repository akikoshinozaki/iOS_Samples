//
//  SelfInBlock.swift
//  1_2_SelfInBlock
//
//  Created by 新居雅行 on 2014/07/11.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import UIKit

class SelfInBlock: NSObject {
    
    private var str: String = ""
    
    lazy
    private var block: () -> Void = {
        [unowned self]
        () -> Void in
        self.doSomething()
        self.str = "Test"
        let x = self.str
    }
    
    private var block2: () -> Void = {}
    
    func configureBlock() {
        self.block2 = {
            [unowned self]
            () -> Void in
            self.doSomething()
            self.str = "Test"
            let x = self.str
        }
        block()
        block2()
    }
    
    func doSomething()
    {
        NSLog("Did something");
    }
    
    func trial()   {
        var c1 : (Int, Int, String) -> String
        c1 = {
            (Int x, Int y, String z) -> String in
            return("\(x)-\(y) \(z)")
        }
        println("result = " + c1(1, 2, "Integer"))
        
        var c2 : (Int, Int, String) -> String
        c2 = {
            (x, y, z) -> String in
            return("\(x)-\(y) \(z)")
        }
        println("result = " + c1(3, 4, "Integer"))
        
        c2 = {
            x, y, z in
            return("\(x)-\(y) \(z)")
        }
        println("result = " + c1(5, 6, "Integer"))
        
        //        c2 = {    // Error
        //            return("\(x)-\(y) \(z)")
        //        }
        //        println("result = " + c1(3, 4, "Integer"))
        
        var c3 : (Void) -> Void
        c3 = {
            (Void) -> Void in
            println("test3")
        }
        c3()
        
        var c4 : (Void) -> Void
        c4 = {
            () -> Void in
            println("test4-1")
        }
        c4()
        
        c4 = {
            println("test4-2")
        }
        c4()
        
        var c5 : () -> String
        c5 = {
            () -> String in
            return("test5-1")
        }
        println(c5())
        
        c5 = {
            return("test5-2")
        }
        println(c5())
        
        var c6 : (Int) -> String
        c6 = {
            (n) -> String in
            return("test6-1=\(n)")
        }
        println(c6(34))
        c6 = {
            n in
            return("test6-1=\(n)")
        }
        println(c6(11))
        
        //        c6 = {
        //            return("test6-1=\(n)")
        //        }
        //        println(c6(67))
        var b2: UIView? = UIView()
        println(b2?.tag)
        
        if b2 != nil {
            println(b2!.tag)
        }
        //println(b2!.tag)
        if let theView = b2 {
            println(theView.tag)
        }
        func test2(a: String) -> String   {
            println("this is \(a)")
            return a
        }
        
        var d1: String = "bbb"
        var d2: String? = "ccc"
        var d3: String! = "bbb"
        var d4: String! = nil
        
        test2(d1)
        test2(d2!)
        test2(d3)
        test2(d4)

    }
}
