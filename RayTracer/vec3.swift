//
//  vec3.swift
//  RayTracer
//
//  Created by Robert Bigelow on 8/5/18.
//  Copyright © 2018 Robert Bigelow. All rights reserved.
//

import Foundation

struct vec3 {
    init(_ e0: Float, _ e1:Float, _ e2:Float){
        e[0] = e0
        e[1] = e1
        e[2] = e2
    }
    var x: Float {
        return e[0]
    }
    var y: Float {
        return e[1]
    }
    var z: Float {
        return e[2]
    }
    var r: Float {
        return e[0]
    }
    var g: Float {
        return e[1]
    }
    var b: Float {
        return e[2]
    }
    static prefix func + (vector: vec3) -> vec3 { return vector }
    static prefix func - (vector: vec3) -> vec3 {
        return vec3(-vector.e[0], -vector.e[1], -vector.e[2])
    }

    subscript(index: Int) -> Float { return e[index] }

    static func += (left: inout vec3, right: vec3) {
        left = left + right
    }
    static func -= (left: inout vec3, right: vec3) {
        left = left - right
    }
    static func *= (left: inout vec3, right: vec3) {
        left = left * right
    }
    static func /= (left: inout vec3, right: vec3) {
        left = left / right
    }

    static func *= (left: inout vec3, c: Float) {
        left.e[0] *= c; left.e[1] *= c; left.e[2] *= 3
    }
    static func /= (left: inout vec3, c: Float) {
        left.e[0] /= c; left.e[1] /= c; left.e[2] /= 3
    }
    
    static func + (left: vec3, right: vec3) -> vec3 {
        return vec3(left.e[0] + right.e[0], left.e[1] + right.e[1], left.e[2] + right.e[2])
    }
    static func - (left: vec3, right: vec3) -> vec3 {
        return vec3(left.e[0] - right.e[0], left.e[1] - right.e[1], left.e[2] - right.e[2])
    }
    static func * (left: vec3, right: vec3) -> vec3 {
        return vec3(left.e[0] * right.e[0], left.e[1] * right.e[1], left.e[2] * right.e[2])
    }
    static func / (left: vec3, right: vec3) -> vec3 {
        return vec3(left.e[0] / right.e[0], left.e[1] / right.e[1], left.e[2] / right.e[2])
    }
    
    static func * (left: vec3, c: Float) -> vec3 {
        return vec3(left.e[0] * c, left.e[1] * c, left.e[2] * c)
    }
    static func / (left: vec3, c: Float) -> vec3 {
        return vec3(left.e[0] / c, left.e[1] / c, left.e[2] / c)
    }
    
    var length : Float { return sqrt(e[0] * e[0] + e[1] * e[1] + e[2] * e[2]) }
    var squared_length : Float { return e[0] * e[0] + e[1] * e[1] + e[2] * e[2] }
    mutating func make_unit_vector () {
        let k = 1.0 / length
        self *= k
    }
    
    var e: [Float] = [0.0, 0.0, 0.0]
}

func unit_vector(v: vec3) -> vec3 {
    return v / v.length
}
