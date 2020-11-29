import PlaygroundSupport
import Cocoa
import Greebler

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

let themeColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
let panelGreebles = PanelGreebles(xUnits: 3, themeColor: themeColor.hsbaColor, panelCount: 10, showRivets: true)
// cutawayPanelGreebles
// ^ made of hoses, pipes, interesting backlight, masked to a polygon
let ventGreebles = VentGreebles(xUnits: 3, themeColor: themeColor.hsbaColor, ventCount: 3)
//let wireGreebles = WireGreebles(xUnits: 3, wireCount: 80, endPointPairCount: 2, allowOffSide: false)

let lightColors = [
    CGColor(red: 1.0, green: 0.3, blue: 0.3, alpha: 1.0).hsbaColor,
    CGColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0).hsbaColor,
    CGColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0).hsbaColor
]
let lightPanelGreebles = LightPanelGreebles(xUnits: 3, themeColor: themeColor.hsbaColor, lightColors: lightColors, panelCount: 3)
//let pipeGreebles = PipeGreebles(xUnits: 3, themeColor: themeColor.hsbaColor, pipeCount: 3, allowOffSide: false)
// equipmentGreebles
//let hoseGreebles = HoseGreebles(xUnits: 3, themeColor: themeColor.hsbaColor, hoseCount: 3, allowOffSide: false)

let compositeGreebles = CompositeGreebles(greeblesAssortment: [
    panelGreebles, ventGreebles, lightPanelGreebles
])

context.scaleBy(x: 500, y: 500)
compositeGreebles.draw(on: context)

let cgImage = context.makeImage()!
let image = NSImage(cgImage: cgImage, size: fullRect.size)
