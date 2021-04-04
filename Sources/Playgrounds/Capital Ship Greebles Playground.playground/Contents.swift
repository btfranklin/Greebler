import PlaygroundSupport
import Cocoa
import Greebler

// Prepare a graphics context
func makeGraphicsContext() -> CGContext {
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
let grayThemeColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
let blueThemeColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)


let capitalShipSurfaceGreebles = CapitalShipSurfaceGreebles(xUnits: 3, themeColor: grayThemeColor.hsbaColor)

var context = makeGraphicsContext()
capitalShipSurfaceGreebles.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output



let capitalShipWindowsGreebles = CapitalShipWindowsGreebles(xUnits: 3, themeColor: grayThemeColor.hsbaColor)

capitalShipWindowsGreebles.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output



let capitalShipBlueThemedWindowsGreebles = CapitalShipWindowsGreebles(xUnits: 3,
                                                                      themeColor: blueThemeColor.hsbaColor,
                                                                      windowZoneCount: 1,
                                                                      windowColor: CapitalShipWindowsGreebles.AMBER_INTERIOR_LIGHT_COLOR)

capitalShipBlueThemedWindowsGreebles.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output



let equipmentTrenchGreebles = EquipmentTrenchGreebles(xUnits: 3, themeColor: grayThemeColor.hsbaColor, trenchWidth: 3)

equipmentTrenchGreebles.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output
