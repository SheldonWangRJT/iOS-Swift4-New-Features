//
//  ViewController.swift
//  NewFeaturesInSwift4
//
//  Created by Xiaodan Wang on 10/1/17.
//  Copyright © 2017 Xiaodan Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let newStrClass = NewStringFeatures(defaultString: "Some Test String")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - 1.String related
        // 1.1 string multiline literal
        var testStr = """
        Hey, I am the line No.1!
        Hey, I am the line No.2!
            Hey, I am the line No.3 with extra spaces.
        """
        newStrClass.testMultilineLiterals(testStr)
        // 1.2 string literal with new line breaker
        testStr = """
        Hey, \
        I look like a multi-line literal, \
        But I am a single line.
        """
        newStrClass.testMultilineLiterals(testStr)
        
        // 1.3 test new string.count with unicode scalar
        newStrClass.testBuiltInUnicodeScalar()
        
        // 1.4 test Substring with open range
        newStrClass.testSubstring("Hello, iOS developers", separator: ",")
        newStrClass.testSubstring(separator: ",")
        
        // 1.5 test prefix of a string
        newStrClass.testStringPrefix("Hi, yoyoyo", prefix: "Hi")
        newStrClass.testStringPrefix("Hi, yoyoyo", prefix: "H")
        newStrClass.testStringPrefix("Hi, yoyoyo", prefix: "i")
        newStrClass.testStringPrefix(prefix: "Hi")
        
        
        // MARK: - 2.Collection related
        // 2.1 merge dictionaries
        NewArrayAndDictionaryFeatures().testMergeDicts()
        
        // 2.2 default value for dictionary
        NewArrayAndDictionaryFeatures().testDictWithDefaultValue()
        
        // 2.3 dictionary capacity and reserve capacity
        NewArrayAndDictionaryFeatures().testDictCapacity()
        
        // 2.4 ❤️❤️❤️ array to dictionary ❤️❤️❤️ too ez!
        NewArrayAndDictionaryFeatures().testGroupingArrayIntoDict()
    }

}

// MARK: - STRING
class NewStringFeatures {
    var defaultString: String
    init(defaultString: String) {
        self.defaultString = defaultString
    }
    // 1.1 & 1.2 multi-line literal & multi-line single-line literal
    func testMultilineLiterals(_ inputString: String? = nil) {
        print( inputString ?? defaultString )
        print("====================")
    }
    
    // 1.3 string.count
    func testBuiltInUnicodeScalar() {
        //decimal: 9829 || hex: 2665 || visual: ♥
        //1. unicode by calculation
        let unicodeScalar = UnicodeScalar(9829)
        //next line we have to add "!" because in iOS using values greater than Int8 (-128~127) to generate UnicodeScalar will be optional
        var outPut: String = String(unicodeScalar!)
        print("unicode scalar by calculation: ", outPut)
        //2. unicode literal
        outPut = "\u{2665}"
        print("unicode literal: ", outPut)
        outPut = "♥"
        //3. string literal
        print("string literal: ", outPut)
        print("character count is: ", outPut.characters.count)
        print("string count is: ", outPut.count)
        print("====================")
    }
    
    // 1.4 open range substring
    func testSubstring(_ inputString: String? = nil, separator: Character) {
        let index = (inputString ?? defaultString).index(of: separator) ?? (inputString ?? defaultString).endIndex
        print((inputString ?? defaultString)[..<index])
        print("====================")
    }
    
    // 1.5 string.hasPrefix
    func testStringPrefix(_ inputString: String? = nil, prefix: String) {
        print((inputString ?? defaultString), " has ", prefix, " as its prefix?" )
        print((inputString ?? defaultString).hasPrefix(prefix))
        print("====================")
    }
}

// MARK: - COLLECTION
class NewArrayAndDictionaryFeatures {
    let defaultArray = ["a","b","c","d","e"]
    func testSliceArray(from: Int, to: Int, of array: [String]) -> [String] {
        guard
            from <= to,
            from >= 0,
            to <= array.count
            else { return array }
        let range = from...to
        let outPut = Array(array[range])
        return outPut
    }
    
    var dict: [String : String] = [
        "key1" : "value1",
        "key2" : "value2",
        "key3" : "value3"
    ]
    let dict2 = [
        "key3" : "value333",
        "key4" : "value4"
    ]
    
    func testIndexForKeysValues() {
        if let ind = dict.keys.index(of: "key2") {
           dict.values[ind] += " sheldon"
        }
        print(dict)
        print("====================")
        //let x: String = dict["key2"] ?? "default string"
    }
    
    func testMergeDicts() {
        //compile error: let mergedDict = dict + dict2
        dict.merge(dict2) { (str1, str2) -> String in
            str1 // use dict value if key duplicate, vise versa
        }
        print(dict)
        print("====================")
    }
    
    func testDictWithDefaultValue() {
        print(dict["key5", default: "default value"])
        print("====================")
    }
    
    func testDictCapacity() {
        print(dict.capacity)
        dict.reserveCapacity(10)
        print(dict.capacity)
        print("====================")
    }
    
    let nameArray = ["Andri", "Andi", "Amber", "Ben", "Candy"]
    // Algorithm killer
    func testGroupingArrayIntoDict() {
        print("original array: ", nameArray)
        print("group by first char:")
        let dict = Dictionary(grouping: nameArray) { string in
            return string.characters.first!
        }
        print(dict)
        print("group by string count:")
        let dict2 = Dictionary(grouping: nameArray) { string in
            return string.count
        }
        print(dict2)
        print("====================")
    }
}
