//
//  CVPixelBuffer+PyPointer.swift
//


import Foundation
import AVFoundation
import PySwiftKit
import PyUnpack
import PySerializing
import PySwiftWrapper
import PySwiftObject
//import PythonLib

fileprivate extension UnsafeMutablePointer<CChar> {
    static let ubyte_format: Self = makeCString(from: "B")
}


@PyClassByExtension(bases: [.buffer])
extension CVPixelBuffer: PySwiftKit.PyTypeBufferProtocol, PySerializing.PySerialize, PySwiftWrapper.PyClassProtocol {
	
	static var PyBuffer: PyBufferProcs = .init(
		bf_getbuffer: { s, buffer, rw in
			let cls: CVPixelBuffer = UnPackPyPointer(from: s)
			var element_size = MemoryLayout<UInt8>.size
			
			CVPixelBufferLockBaseAddress(cls, [])
			var size = CVPixelBufferGetDataSize(cls)
			guard
				let pixel_buf = CVPixelBufferGetBaseAddress(cls),
				let buffer = buffer
			else {
				PyErr_SetString(PyExc_MemoryError, "CVPixelBuffer has no buffer")
				return -1
			}
			buffer.pointee.obj = s
			buffer.pointee.buf = pixel_buf
			
			buffer.pointee.len = size
			buffer.pointee.readonly = 0
			buffer.pointee.itemsize = element_size
			buffer.pointee.format = .ubyte_format
			buffer.pointee.ndim = 1
            buffer.pointee.shape = .init(&size)
            buffer.pointee.strides = .init(&element_size)
			
			buffer.pointee.suboffsets = nil
			buffer.pointee.internal = nil
			
			CVPixelBufferUnlockBaseAddress(cls, [])
			
			return 0
		},
		bf_releasebuffer: nil
	)
    public static func buffer_procs() -> UnsafeMutablePointer<PyBufferProcs> {
        .init(&PyBuffer)
    }
    
    
    public var pyPointer: PyPointer {
        Self.asPyPointer(self)
    }
}



