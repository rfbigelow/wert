//
//  hitablelist.swift
//  RayTracer
//
//  Created by Robert Bigelow on 8/6/18.
//  Copyright © 2018 Robert Bigelow. All rights reserved.
//

extension Array: hitable where Element: hitable {
    func hit(_ r: ray, min: Float, max: Float, _ rec: inout hit_record) -> Bool {
        var temp_record = hit_record()
        var hit_anything = false
        var closest_so_far = max
        for elem in self {
            if elem.hit(r, min: min, max: closest_so_far, &temp_record) {
                hit_anything = true
                closest_so_far = temp_record.t
                rec = temp_record
            }
        }
        return hit_anything
    }
}
