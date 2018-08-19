//
//  camera.swift
//  RayTracer
//
//  Created by Robert Bigelow on 8/7/18.
//  Copyright © 2018 Robert Bigelow. All rights reserved.
//

import Foundation

func random_in_unit_disk() -> vec3 {
    var p: vec3
    repeat {
        p = 2.0*vec3(Float(drand48()), Float(drand48()), 0) - vec3(1, 1, 0)
    } while dot(p, p) >= 1.0
    return p
}

struct camera {
    init(_ lookfrom: vec3, _ lookat: vec3, _ vup: vec3, _ vfov: Float, aspect: Float, aperture: Float, focus_dist: Float) {
        lens_radius = aperture / 2
        let theta = vfov*Float.pi/180.0
        let half_height = tan(theta/2)
        let half_width = aspect * half_height       
        origin = lookfrom
        w = unit_vector(v: lookfrom - lookat)
        u = unit_vector(v: cross(vup, w))
        v = cross(w, u)
        lower_left_corner = origin -  half_width*focus_dist*u - half_height*focus_dist*v - focus_dist*w
        horizontal = 2*half_width*focus_dist*u
        vertical = 2*half_height*focus_dist*v
    }
    func get_ray(s: Float, t: Float) -> ray {
        let rd = lens_radius*random_in_unit_disk()
        let offset = u * rd.x + v * rd.y
        return ray(origin + offset, lower_left_corner + s*horizontal + t*vertical - origin - offset)
    }
    
    let lower_left_corner: vec3
    let horizontal: vec3
    let vertical: vec3
    let origin: vec3
    let u, v, w: vec3
    let lens_radius: Float
}
