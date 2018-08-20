//
//  main.swift
//  RayTracer
//
//  Created by Robert Bigelow on 5/5/18.
//  Copyright © 2018 Robert Bigelow. All rights reserved.
//

import Foundation

let nx = 1000
let ny = 500
let ns = 100

print("P3\n\(nx) \(ny)\n255");

srand48(Date().hashValue)

let R = Float(cos(Double.pi/4))
let world = random_scene()
let lookfrom = vec3(9, 2, 2)
let lookat = vec3(4, 1, 0)
let dist_to_focus = (lookfrom - lookat).length
let aperture = Float(0.1)
let cam = camera(lookfrom, lookat, vec3(0, 1, 0), 30, aspect: Float(nx)/Float(ny), aperture: aperture, focus_dist: dist_to_focus)

for j in stride(from: ny-1, through: 0, by: -1) {
    for i in 0..<nx {
        var col = vec3(0.0, 0.0, 0.0)
        for _ in 0..<ns {
            let u = (Float(i) + Float(drand48())) / Float(nx)
            let v = (Float(j) + Float(drand48())) / Float(ny)
            let r = cam.get_ray(s: u, t: v)
            col += color(r, world, 0)
        }
        col /= Float(ns)
        col = vec3(col[0].squareRoot(), col[1].squareRoot(), col[2].squareRoot())
        let ir = Int(255.99*col[0])
        let ig = Int(255.99*col[1])
        let ib = Int(255.99*col[2])
        
        print("\(ir) \(ig) \(ib)");
    }
}
