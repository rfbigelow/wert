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

func refract(_ v: vec3, _ n: vec3, _ ni_over_nt: Float, _ refracted: inout vec3) -> Bool {
    let uv = unit_vector(v: v)
    let dt = dot(uv, n)
    let discriminant = 1.0 - ni_over_nt*(1.0-dt*dt)
    if discriminant > 0.0 {
        refracted = ni_over_nt*(uv - n*dt) - n*discriminant.squareRoot()
        return true
    }
    return false
}

func schlick(_ cosine: Float, _ ref_idx: Float) -> Float {
    var r0 = (1.0-ref_idx) / (1+ref_idx)
    r0 = r0*r0
    return r0 + (1-r0)*pow(1.0 - cosine, 5.0)
}

func color(_ r: ray, _ world: hitable, _ depth: Int) -> vec3 {
    var rec = hit_record()
    if world.hit(r, min: 0.001, max: Float.greatestFiniteMagnitude, &rec) {
        if let mat = rec.mat {
            var scattered: ray = ray()
            var attenuation: vec3 = vec3()
            if depth < 50 && mat.scatter(r, rec, attenuation: &attenuation, scattered: &scattered) {
                return attenuation*color(scattered, world, depth+1)
            }
            else {
                return vec3()
            }
        }
        else {
            return vec3()
        }
    }
    else {
        let unit_direction = unit_vector(v: r.direction)
        let t = 0.5*(unit_direction.y + 1.0)
        return (1.0-t)*vec3(1.0, 1.0, 1.0) + t*vec3(0.5, 0.7, 1.0)
    }
}

func random_scene() -> [sphere] {
    var scene = [sphere]()
    scene.append(sphere(vec3(0, -1000, 0), 1000, lambertian(vec3(0.5, 0.5, 0.5))))
    for a in -11..<11 {
        for b in -11..<11 {
            let choose_mat = Float(drand48())
            let center = vec3(Float(a)+0.9*Float(drand48()), 0.2, Float(b)+0.9*Float(drand48()))
            if (center - vec3(4, 0.2, 0)).length > 0.9 {
                if choose_mat < 0.8 {
                    scene.append(sphere(center, 0.2, lambertian(vec3(Float(drand48()*drand48()),Float(drand48()*drand48()),Float(drand48()*drand48())))))
                }
                else if choose_mat < 0.95 {
                    scene.append(sphere(center, 0.2, metal(vec3(Float(0.5*(1 + drand48())), Float(0.5*(1 + drand48())), Float(0.5*(1 + drand48()))), Float(0.5*drand48()))))
                }
                else {
                    scene.append(sphere(center, 0.2, dielectric(1.5)))
                }
            }
        }
    }
    scene.append(sphere(vec3(0, 1, 0), 1.0, dielectric(1.5)))
    scene.append(sphere(vec3(-4, 1, 0), 1.0, lambertian(vec3(0.4, 0.2, 0.1))))
    scene.append(sphere(vec3(4, 1, 0), 1.0, metal(vec3(0.7, 0.6, 0.5))))
    return scene
}

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

