//
//  main.swift
//  RayTracer
//
//  Created by Robert Bigelow on 5/5/18.
//  Copyright © 2018 Robert Bigelow. All rights reserved.
//

import Foundation

let nx = 200;
let ny = 100;

print("P3\n\(nx) \(ny)\n255");

for j in stride(from: ny-1, through: 0, by: -1) {
    for i in 0..<nx {
        let col = vec3(Float(i) / Float(nx), Float(j) / Float(ny), 0.2)
        
        let ir = Int(255.99*col[0]);
        let ig = Int(255.99*col[1]);
        let ib = Int(255.99*col[2]);
        
        print("\(ir) \(ig) \(ib)");
    }
}

