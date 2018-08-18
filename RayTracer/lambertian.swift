//
//  lambertian.swift
//  RayTracer
//
//  Created by Robert Bigelow on 8/18/18.
//  Copyright © 2018 Robert Bigelow. All rights reserved.
//

class lambertian : material {
    init(_ a: vec3) {
        albedo = a
    }
    func scatter(_ r_in: ray, _ rec: hit_record, attenuation: inout vec3, scattered: inout ray) -> Bool {
        let target = rec.p + rec.normal + random_in_unit_sphere()
        scattered = ray(rec.p, target - rec.p)
        attenuation = albedo
        return true
    }
    
    let albedo: vec3
}
