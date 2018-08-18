//
//  main.swift
//  RayTracer
//
//  Created by Robert Bigelow on 5/5/18.
//  Copyright © 2018 Robert Bigelow. All rights reserved.
//

import Foundation

func random_in_unit_sphere() -> vec3 {
    var p: vec3
    repeat {
        p = 2.0*vec3(Float(drand48()), Float(drand48()), Float(drand48())) - vec3(1, 1, 1)
    } while p.squared_length >= 1.0
    return p
}

func color(_ r: ray, _ world: hitable) -> vec3 {
    var rec = hit_record()
    if world.hit(r, min: 0.0, max: Float.greatestFiniteMagnitude, &rec) {
        let target = rec.p + rec.normal + random_in_unit_sphere()
        return 0.5*color(ray(rec.p, target-rec.p), world)
    }
    else {
        let unit_direction = unit_vector(v: r.direction)
        let t = 0.5*(unit_direction.y + 1.0)
        return (1.0-t)*vec3(1.0, 1.0, 1.0) + t*vec3(0.5, 0.7, 1.0)
    }
}

let nx = 200
let ny = 100
let ns = 100

print("P3\n\(nx) \(ny)\n255");

srand48(Date().hashValue)

let world = [sphere(vec3(0.0, 0.0, -1.0), 0.5), sphere(vec3(0.0, -100.5, -1.0), 100)]
let cam = camera()

for j in stride(from: ny-1, through: 0, by: -1) {
    for i in 0..<nx {
        var col = vec3(0.0, 0.0, 0.0)
        for _ in 0..<ns {
            let u = (Float(i) + Float(drand48())) / Float(nx)
            let v = (Float(j) + Float(drand48())) / Float(ny)
            let r = cam.get_ray(u: u, v: v)
            col += color(r, world)
        }
        col /= Float(ns)
        
        let ir = Int(255.99*col[0])
        let ig = Int(255.99*col[1])
        let ib = Int(255.99*col[2])
        
        print("\(ir) \(ig) \(ib)");
    }
}

