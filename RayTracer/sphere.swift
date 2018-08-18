//
//  sphere.swift
//  RayTracer
//
//  Created by Robert Bigelow on 8/6/18.
//  Copyright © 2018 Robert Bigelow. All rights reserved.
//

struct sphere : hitable {
    init(_ cen: vec3, _ r: Float, _ m: material) {
        center = cen
        radius = r
        mat = m
    }
    func hit(_ r: ray, min: Float, max: Float, _ rec: inout hit_record) -> Bool {
        let oc = r.origin - center
        let a = dot(r.direction, r.direction)
        let b = dot(oc, r.direction)
        let c = dot(oc, oc) - radius*radius
        let discriminant = b*b - a*c
        if discriminant > 0.0 {
            var temp = (-b - (b*b - a*c).squareRoot())/a
            if temp < max && temp > min {
                rec.t = temp
                rec.p = r.pointAtParameter(rec.t)
                rec.normal = (rec.p - center) / radius
                rec.mat = mat
                return true
            }
            temp = (-b + (b*b - a*c).squareRoot())/a
            if temp < max && temp > min {
                rec.t = temp
                rec.p = r.pointAtParameter(rec.t)
                rec.normal = (rec.p - center) / radius
                rec.mat = mat
                return true
            }
        }
        return false
    }
    
    let center: vec3
    let radius: Float
    let mat: material
}
