//
//  material.swift
//  RayTracer
//
//  Created by Robert Bigelow on 8/18/18.
//  Copyright © 2018 Robert Bigelow. All rights reserved.
//

protocol material {
    func scatter(_ r_in: ray, _ rec: hit_record, attenuation: inout vec3, scattered: inout ray) -> Bool
}
