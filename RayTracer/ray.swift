//
//  ray.swift
//  RayTracer
//
//  Created by Robert Bigelow on 8/6/18.
//  Copyright © 2018 Robert Bigelow. All rights reserved.
//

struct ray {
    init() {
        self.init(vec3(), vec3())
    }
    init(_ a: vec3, _ b: vec3) {
        A = a
        B = b
    }
    var origin: vec3 { return A }
    var direction: vec3 { return B }
    func pointAtParameter(_ t:Float) -> vec3 { return A + t*B }
    var A: vec3
    var B: vec3
}
