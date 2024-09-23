from swift_tools.swift_types import * # type: ignore

"import AVFoundation"

@bases(Buffer)
@wrapper(py_init=False)
class CVPixelBuffer: ...
