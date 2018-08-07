//
//  camera.swift
//  RayTracer
//
//  Created by Robert Bigelow on 8/7/18.
//  Copyright © 2018 Robert Bigelow. All rights reserved.
//

struct camera {
    init() {
        lower_left_corner = vec3(-2.0, -1.0, -1.0)
        horizontal = vec3(4.0, 0.0, 0.0)
        vertical = vec3(0.0, 2.0, 0.0)
        origin = vec3(0.0, 0.0, 0.0)
    }
    func get_ray(u: Float, v: Float) -> ray {
        return ray(origin, lower_left_corner + u*horizontal + v*vertical - origin)
    }
    
    let lower_left_corner: vec3
    let horizontal: vec3
    let vertical: vec3
    let origin: vec3
}
