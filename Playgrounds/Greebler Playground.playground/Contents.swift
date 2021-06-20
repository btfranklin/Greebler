import PlaygroundSupport
import Cocoa
import Aesthete
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
let lightColors = [
    CGColor(red: 1.0, green: 0.3, blue: 0.3, alpha: 1.0).hsbaColor,
    CGColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0).hsbaColor,
    CGColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0).hsbaColor
]


// A basic panel
let panelGreeblesNoRivets = PanelGreebles(xUnits: 3, themeColor: grayThemeColor.hsbaColor, panelCount: 10, showRivets: false)

var context = createGraphicsContext()
panelGreeblesNoRivets.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output

// A basic panel, but with rivets
let panelGreebles = PanelGreebles(xUnits: 3, themeColor: grayThemeColor.hsbaColor, panelCount: 10, showRivets: true)

context = createGraphicsContext()
panelGreebles.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output


// Vent greebles in isolation
let ventGreebles = VentGreebles(xUnits: 3, themeColor: grayThemeColor.hsbaColor, ventCount: 3)
context = createGraphicsContext()
ventGreebles.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output


// Light panel greebles in isolation
let lightPanelGreebles = LightPanelGreebles(xUnits: 3, themeColor: grayThemeColor.hsbaColor, lightColors: lightColors, panelCount: 3)

context = createGraphicsContext()
lightPanelGreebles.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output


// Wire greebles in isolation
let wireGreebles = WireGreebles(xUnits: 3, wireCount: 10, endPointPairCount: 2, allowOffSide: false)

context = createGraphicsContext()
wireGreebles.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output


// Wire greebles in isolation, allowing off-side wires
let wireGreeblesOffSide = WireGreebles(xUnits: 3, wireCount: 12, endPointPairCount: 6, allowOffSide: true)

context = createGraphicsContext()
wireGreeblesOffSide.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output


// Pipe greebles in isolation
let pipeGreebles = PipeGreebles(xUnits: 3, themeColor: grayThemeColor.hsbaColor, pipeCount: 3, allowOffSide: false)

context = createGraphicsContext()
pipeGreebles.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output


// Pipe greebles in isolation, allowing off-side pipes
let pipeGreeblesOffSide = PipeGreebles(xUnits: 3, themeColor: grayThemeColor.hsbaColor, pipeCount: 3, allowOffSide: true)

context = createGraphicsContext()
pipeGreeblesOffSide.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output


// Hose greebles in isolation
let hoseGreebles = HoseGreebles(xUnits: 3, themeColor: grayThemeColor.hsbaColor, hoseCount: 3, allowOffSide: false)

context = createGraphicsContext()
hoseGreebles.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output


// Hose greebles in isolation, allowing off-side hoses
let hoseGreeblesOffSide = HoseGreebles(xUnits: 3, themeColor: grayThemeColor.hsbaColor, hoseCount: 3, allowOffSide: true)

context = createGraphicsContext()
hoseGreeblesOffSide.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output


// Equipment greebles in isolation
let equipmentGreebles = EquipmentGreebles(xUnits: 3, themeColor: grayThemeColor.hsbaColor, equipmentCount: 4)

context = createGraphicsContext()
equipmentGreebles.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output


// Cutaway Section greebles in isolation
let cutawaySectionGreebles = CutawaySectionGreebles(xUnits: 3, themeColor: grayThemeColor.hsbaColor, cutawayCount: 4)

context = createGraphicsContext()
cutawaySectionGreebles.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output


// A composite panel with rivets, vents, and lights
let compositeGreebles1 = CompositeDrawable(drawables: [
    panelGreebles, ventGreebles, lightPanelGreebles
])

context = createGraphicsContext()
compositeGreebles1.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output


// A composite panel with rivets, lights, pipes, and hoses
let compositeGreebles2 = CompositeDrawable(drawables: [
    panelGreebles, lightPanelGreebles, pipeGreebles, hoseGreebles
])

context = createGraphicsContext()
compositeGreebles2.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output


// A composite panel with rivets, lights, pipes, and wires
let compositeGreebles3 = CompositeDrawable(drawables: [
    panelGreebles, lightPanelGreebles, pipeGreebles, wireGreebles
])

context = createGraphicsContext()
compositeGreebles3.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output


// A composite panel with rivets, lights, equipment, and pipes
let compositeGreebles4 = CompositeDrawable(drawables: [
    panelGreebles, lightPanelGreebles, equipmentGreebles, pipeGreebles
])

context = createGraphicsContext()
compositeGreebles4.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output


// A composite panel with rivets, cutaway sections, and equipment
let compositeGreebles5 = CompositeDrawable(drawables: [
    panelGreebles, cutawaySectionGreebles, equipmentGreebles
])

context = createGraphicsContext()
compositeGreebles5.draw(on: context)
context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output
