// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let local = false

let pykit_package: Package.Dependency = if local {
    .package(path: "../PySwiftKit")
} else {
    .package(url: "https://github.com/KivySwiftLink/PySwiftKit", from: .init(311, 0, 0))
}


let package = Package(
	name: "PyCoreVideo",
	platforms: [.iOS(.v13)],
	products: [
		.library(name: "PyCoreVideo", targets: ["PyCoreVideo"])
	],
	dependencies: [
		
        pykit_package,
        //psw
       // .package(url: "https://github.com/PythonSwiftLink/SwiftonizePlugin", from: .init(0, 1, 0)),
	],
	targets: [
		.target(
			name: "PyCoreVideo",
			dependencies: [
                .product(name: "SwiftonizeModules", package: "PySwiftKit")
			]
			//plugins: [ .plugin(name: "Swiftonize", package: "SwiftonizePlugin") ]
		),

	]
)
