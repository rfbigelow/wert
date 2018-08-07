//
//  hitable.swift
//  RayTracer
//
//  Created by Robert Bigelow on 8/6/18.
//  Copyright © 2018 Robert Bigelow. All rights reserved.
//

struct hit_record {
    init() {
        t = 0.0
        p = vec3()
        normal = vec3()
    }
    var t: Float
    var p: vec3
    var normal: vec3
}

protocol hitable {
    func hit(_ r: ray, min: Float, max: Float, _ rec: inout hit_record) -> Bool
}
