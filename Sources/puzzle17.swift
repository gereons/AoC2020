import Foundation

enum Cube {
    case active
    case inactive
}

struct Universe {
    var cubes = [[[[Cube]]]]()
    let origin: Int

    static func create(size: Int) -> Universe {
        var universe = Universe(origin: size / 2)
        for w in 0 ..< size {
            universe.cubes.append([[[Cube]]]())
            for z in 0..<size {
                universe.cubes[w].append([[Cube]]())
                for y in 0..<size {
                    universe.cubes[w][z].append([Cube]())
                    for _ in 0..<size {
                        universe.cubes[w][z][y].append(.inactive)
                    }
                }
            }
        }

        return universe
    }

    subscript(_ x: Int, _ y: Int, _ z: Int, _ w: Int = 0) -> Cube {
        get {
            return cubes[origin-w][origin-z][origin-y][origin-x]
        }
        set {
            cubes[origin-w][origin-z][origin-y][origin-x] = newValue
        }
    }

    func neighbours(_ x: Int, _ y: Int, _ z: Int, _ w: Int = 0) -> Int {
        var count = 0

        for ww in w-1...w+1 {
            for zz in z-1...z+1 {
                for yy in y-1...y+1 {
                    for xx in x-1...x+1 {
                        if xx==x && yy==y && zz==z && ww==w { continue }
                        if self[xx,yy,zz,ww] == .active {
                            count += 1
                        }
                    }
                }
            }
        }

        return count
    }
}

struct Puzzle17 {

    static func run() {
        var universe = Universe.create(size: 41)

        /*
         .#.
         ..#
         ###

        universe[ 0,-1, 0] = .active

        universe[ 1, 0, 0] = .active

        universe[-1, 1, 0] = .active
        universe[ 0, 1, 0] = .active
        universe[ 1, 1, 0] = .active
        */

        let input = """
         ##.#...#
         #..##...
         ....#..#
         ....####
         #.#....#
         ###.#.#.
         .#.#.#..
         .#.....#
         """.components(separatedBy: "\n")
        for (y, line) in input.enumerated() {
            for (x, ch) in line.enumerated() {
                if ch == "#" {
                    universe[x,y,0] = .active
                }
            }
        }


        for _ in 0..<6 {
            var next = universe

            for x in -universe.origin+1 ... universe.origin-1 {
                for y in -universe.origin+1 ... universe.origin-1 {
                    for z in -universe.origin+1 ... universe.origin-1 {
                        for w in -universe.origin+1 ... universe.origin-1 {
                            let cube = universe[x,y,z,w]
                            let neigbours = universe.neighbours(x,y,z,w)
                            if cube == .active {
                                if neigbours != 2 && neigbours != 3 {
                                    next[x,y,z,w] = .inactive
                                }
                            } else {
                                if neigbours == 3 {
                                    next[x,y,z,w] = .active
                                }
                            }
                        }
                    }
                }
            }

            universe = next
        }

        var active = 0
        for x in -universe.origin ... universe.origin {
            for y in -universe.origin ... universe.origin {
                for z in -universe.origin ... universe.origin {
                    for w in -universe.origin ... universe.origin {
                        if universe[x,y,z,w] == .active {
                            active += 1
                        }
                    }
                }
            }
        }

        print(active)
    }
}
