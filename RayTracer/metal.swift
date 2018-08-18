//
//  metal.swift
//  RayTracer
//
//  Created by Robert Bigelow on 8/18/18.
//  Copyright © 2018 Robert Bigelow. All rights reserved.
//

func reflect(_ v: vec3, _ n: vec3) -> vec3 {
    return v - 2*dot(v,n)*n
}

class metal : material {
    init(_ a: vec3, _ f: Float) {
        albedo = a
        fuzz = f
    }
    func scatter(_ r_in: ray, _ rec: hit_record, attenuation: inout vec3, scattered: inout ray) -> Bool {
        let reflected = reflect(unit_vector(v: r_in.direction), rec.normal)
        scattered = ray(rec.p, reflected + fuzz*random_in_unit_sphere())
        attenuation = albedo
        return dot(scattered.direction, rec.normal) > 0
    }
    let albedo: vec3
    let fuzz: Float
}
