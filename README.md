#  The Weekend Ray Tracer
This ray tracer is based on the one featured in Peter Shirley's "Ray Tracing in a Weekend", which is a great introduction to this exciting field. I decided that it would be fun to learn Swift while following along in the book. The result is wert.

## Design Decisions
There weren't many decisions to make, but I'll document the major ones that I remember here before I forget them.

* Use of stucts: I pretty much used `struct` for everything by default, with the exception of materials. For most of the types this makes sense, but it made dealing with `hitable` a bit odd when defining the scene. I'll need to revisit this decision if/when I want to treat objects polymorphically in the same list.
* A protocol for `hitable`: This seems right, since it is defined as a pure virtual interface in the book.
* Use of extension for `hitablelist`: I found that I could extend `Array` to implement the `hitablelist` type from the book by using a conditional conformance.
* Use of `Float`: The book uses 32-bit floats and I wanted to follow this decision, even though Swift seems to prefer `Double`. This leads to quite a few places where conversion to `Float` is required, but I like seeing the process memory hover around 1.2 MB when rendering a scene.

## A Brief Tour

### The `vec3` Type

This type defines the needed operations for vector calculations (addition, subtraction, multiplication, division) between vectors and vectors and scalars. It stores the data in an array of `Float`s.

### The `ray` Type

This type defines a ray with two points, `A` and `B`. `A` is the `origin` and `B` is the `direction`. You can calculate a point along the ray by giving it the parameter `t`, which represents the distance from the `origin` along the ray. Negative values of `t` represent the opposite direction.

### The `hitable` Protocol

This is the primary extension point for adding new geometric objects. Currently there is support for `sphere`s and lists of `hitable` things, though the list of things must be of the same concrete type right now.

The protocol tests to see if a ray intersects with the geometry in a certain range, and produces a hit record. This records the point on the geometry (`p`), where that point intersect along the ray (`t`), and the surface normal of the hit. It also contains an optional material reference. It returns `true` if a hit occurs, and `false` otherwise.

### The `material` Protocol

Materials define how the light interacts with an object when a hit occurs. It produces a ray representing which direction the incoming ray will continue, along with an attenuation which represents the intensity of the scattered ray. If the material completely absorbs incoming light this will return `false`. Otherwise, if it produced a scattered ray, it will return `true`.



