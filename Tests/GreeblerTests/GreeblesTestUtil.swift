//  Created by B.T. Franklin on 12/25/20.

import CoreGraphics

struct GreeblesTestUtil {

    static func createGraphicsContext() -> CGContext {
        let fullRect = CGRect(origin: .zero, size: CGSize(width: 1500, height: 500))
        guard let context = CGContext(data: nil,
                                      width: Int(fullRect.width),
                                      height: Int(fullRect.height),
                                      bitsPerComponent: 8,
                                      bytesPerRow: 0,
                                      space: CGColorSpaceCreateDeviceRGB(),
                                      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            fatalError("Could not create graphics context")
        }
        context.scaleBy(x: 500, y: 500)
        return context
    }

}
