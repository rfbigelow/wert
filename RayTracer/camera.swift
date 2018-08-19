//
//  camera.swift
//  RayTracer
//
//  Created by Robert Bigelow on 8/7/18.
//  Copyright © 2018 Robert Bigelow. All rights reserved.
//

import Foundation

struct camera {
    init(_ lookfrom: vec3, _ lookat: vec3, _ vup: vec3, _ vfov: Float, _ aspect: Float) {
        let theta = vfov*Float.pi/180.0
        let half_height = tan(theta/2)
        let half_width = aspect * half_height       
        origin = lookfrom
        let w = unit_vector(v: lookfrom - lookat)
        let u = unit_vector(v: cross(vup, w))
        let v = cross(w, u)
        lower_left_corner = origin -  half_width*u - half_height*v - w
        horizontal = 2*half_width*u
        vertical = 2*half_height*v
    }
    func get_ray(u: Float, v: Float) -> ray {
        return ray(origin, lower_left_corner + u*horizontal + v*vertical - origin)
    }
    
    let lower_left_corner: vec3
    let horizontal: vec3
    let vertical: vec3
    let origin: vec3
}
