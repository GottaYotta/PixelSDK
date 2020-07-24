import Foundation

class Log {
    class func warning(_ text: String) {
        NSLog("[GPUImage] WARNING: \(text)")
    }
    
    class func error(_ text: String) {
        NSLog("[GPUImage] ERROR: \(text)")
    }
    
    class func info(_ text: String) {
        NSLog("[GPUImage] INFO: \(text)")
    }
}
