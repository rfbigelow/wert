//
//  dielectric.swift
//  RayTracer
//
//  Created by Robert Bigelow on 8/19/18.
//  Copyright © 2018 Robert Bigelow. All rights reserved.
//

import Foundation

class dielectric : material {
    init(_ ri: Float) {
        ref_idx = ri
    }
    func scatter(_ r_in: ray, _ rec: hit_record, attenuation: inout vec3, scattered: inout ray) -> Bool {
        attenuation = vec3(1.0, 1.0, 1.0)
        
        var outward_normal: vec3
        var ni_over_nt: Float
        var cosine: Float
        if dot(r_in.direction, rec.normal) > 0 {
            outward_normal = -rec.normal
            ni_over_nt = ref_idx
            cosine = ref_idx * dot(r_in.direction, rec.normal) / r_in.direction.length
        }
        else {
            outward_normal = rec.normal
            ni_over_nt = 1.0/ref_idx
            cosine = -dot(r_in.direction, rec.normal) / r_in.direction.length
        }
        
        var reflect_prob: Float
        var refracted = vec3()
        if refract(r_in.direction, outward_normal, ni_over_nt, &refracted) {
            reflect_prob = schlick(cosine, ref_idx)
        }
        else {
            reflect_prob = 1.0
        }
        
        if Float(drand48()) < reflect_prob {
            let reflected = reflect(r_in.direction, rec.normal)
            scattered = ray(rec.p, reflected)
        }
        else {
            scattered = ray(rec.p, refracted)
        }
        return true
    }
    let ref_idx: Float
}
