// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "PyCoreVideo",
	platforms: [.iOS(.v13)],
	products: [
		.library(name: "PyCoreVideo", targets: ["PyCoreVideo"])
	],
	dependencies: [
		
        .package(url: "https://github.com/KivySwiftLink/PythonSwiftLink", from: .init(311, 0, 0)),
        .package(url: "https://github.com/PythonSwiftLink/SwiftonizePlugin", from: .init(0, 1, 0)),
	],
	targets: [
		.target(
			name: "PyCoreVideo",
			dependencies: [
                .product(name: "SwiftonizeModules", package: "PythonSwiftLink"),
                //.product(name: "PySwiftObject", package: "KivySwiftLink"),
			],
			plugins: [ .plugin(name: "Swiftonize", package: "SwiftonizePlugin") ]
		),

	]
)
