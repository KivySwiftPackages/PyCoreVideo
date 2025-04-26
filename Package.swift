// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let kivy = true
let local = true

let pykit_package: Package.Dependency = if kivy {
    .package(url: "https://github.com/KivySwiftLink/PySwiftKit", from: .init(311, 0, 0))
} else {
    if local {
        .package(path: "/Users/codebuilder/Documents/GitHub/PySwiftKit")
    } else {
        .package(url: "https://github.com/PythonSwiftLink/PySwiftKit", from: .init(311, 0, 0))
    }
}

let pykit: Target.Dependency = if kivy {
    .product(name: "SwiftonizeModules", package: "PySwiftKit")
} else {
    .product(name: "SwiftonizeModules", package: "PySwiftKit")
}

let package = Package(
	name: "PyCoreVideo",
	platforms: [.iOS(.v13)],
	products: [
		.library(name: "PyCoreVideo", targets: ["PyCoreVideo"])
	],
	dependencies: [
		
        pykit_package,
        .package(url: "https://github.com/PythonSwiftLink/SwiftonizePlugin", from: .init(0, 1, 0)),
	],
	targets: [
		.target(
			name: "PyCoreVideo",
			dependencies: [
                pykit,
                //.product(name: "PySwiftObject", package: "KivySwiftLink"),
			],
			plugins: [ .plugin(name: "Swiftonize", package: "SwiftonizePlugin") ]
		),

	]
)
