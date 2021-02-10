import PlaygroundSupport
import Cocoa
import Greebler

// Prepare a graphics context
func createGraphicsContext() -> CGContext {
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

// Some color constants to use later
let grayThemeColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)


let capitalShipSurfaceGreebles = CapitalShipSurfaceGreebles(xUnits: 3, themeColor: grayThemeColor.hsbaColor)

var context = createGraphicsContext()
capitalShipSurfaceGreebles.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output

let equipmentStripGreebles = EquipmentTrenchGreebles(xUnits: 3, themeColor: grayThemeColor.hsbaColor, trenchWidth: 3)

equipmentStripGreebles.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output
