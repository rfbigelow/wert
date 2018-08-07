//
//  main.swift
//  RayTracer
//
//  Created by Robert Bigelow on 5/5/18.
//  Copyright © 2018 Robert Bigelow. All rights reserved.
//

func hit_sphere(_ center: vec3, _ radius: Float, _ r: ray) -> Bool {
    let oc = r.origin - center
    let a = dot(r.direction, r.direction)
    let b = 2.0 * dot(oc, r.direction)
    let c = dot(oc, oc) - radius*radius
    let discriminant = b*b - 4*a*c
    return discriminant > 0
}

func color(_ r: ray) -> vec3 {
    if hit_sphere(vec3(0.0, 0.0, -1.0), 0.5, r) {
        return vec3(1.0, 0.0, 0.0)
    }
    let unit_direction = unit_vector(v: r.direction)
    let t = 0.5*(unit_direction.y + 1.0)
    return (1.0-t)*vec3(1.0, 1.0, 1.0) + t*vec3(0.5, 0.7, 1.0)
}

let nx = 200;
let ny = 100;

print("P3\n\(nx) \(ny)\n255");
let lower_left_corner = vec3(-2.0, -1.0, -1.0)
let horizontal = vec3(4.0, 0.0, 0.0)
let vertical = vec3(0.0, 2.0, 0.0)
let origin = vec3(0.0, 0.0, 0.0)
for j in stride(from: ny-1, through: 0, by: -1) {
    for i in 0..<nx {
        let u = Float(i) / Float(nx)
        let v = Float(j) / Float(ny)
        let r = ray(origin, lower_left_corner + u*horizontal + v*vertical)
        let col = color(r)
        let ir = Int(255.99*col[0]);
        let ig = Int(255.99*col[1]);
        let ib = Int(255.99*col[2]);
        
        print("\(ir) \(ig) \(ib)");
    }
}

