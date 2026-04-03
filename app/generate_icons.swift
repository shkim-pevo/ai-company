import AppKit
import Foundation

struct TeamIcon {
    let key: String
    let name: String
    let emoji: String
    let subIcons: [String]
    let primary: (CGFloat, CGFloat, CGFloat)
    let secondary: (CGFloat, CGFloat, CGFloat)
    let accent: (CGFloat, CGFloat, CGFloat)
}

let teams: [TeamIcon] = [
    TeamIcon(key: "research",         name: "조사팀",       emoji: "🔍", subIcons: ["📡","🌐","📑"], primary: (0.16, 0.50, 0.73), secondary: (0.20, 0.60, 0.86), accent: (0.68, 0.84, 0.95)),
    TeamIcon(key: "debate",           name: "토론팀",       emoji: "💬", subIcons: ["⚡","🗣️","🎯"], primary: (0.56, 0.27, 0.68), secondary: (0.61, 0.35, 0.71), accent: (0.84, 0.74, 0.89)),
    TeamIcon(key: "synthesis",        name: "종합팀",       emoji: "🧩", subIcons: ["📐","🔗","📊"], primary: (0.15, 0.68, 0.38), secondary: (0.18, 0.80, 0.44), accent: (0.67, 0.92, 0.78)),
    TeamIcon(key: "quality",          name: "퀄리티팀",     emoji: "✅", subIcons: ["🔬","🛡️","⭐"], primary: (0.09, 0.63, 0.52), secondary: (0.10, 0.74, 0.61), accent: (0.64, 0.89, 0.84)),
    TeamIcon(key: "planning",         name: "기획팀",       emoji: "📋", subIcons: ["🗓️","🎯","📌"], primary: (0.95, 0.61, 0.07), secondary: (0.95, 0.77, 0.06), accent: (0.98, 0.91, 0.62)),
    TeamIcon(key: "design",           name: "디자인팀",     emoji: "🎨", subIcons: ["✏️","🖌️","💎"], primary: (0.91, 0.30, 0.24), secondary: (0.93, 0.44, 0.39), accent: (0.96, 0.72, 0.69)),
    TeamIcon(key: "development",      name: "개발팀",       emoji: "💻", subIcons: ["🔧","⚡","🚀"], primary: (0.17, 0.24, 0.31), secondary: (0.20, 0.29, 0.37), accent: (0.52, 0.57, 0.62)),
    TeamIcon(key: "devops",           name: "DevOps팀",     emoji: "⚙️", subIcons: ["🐳","☁️","🔄"], primary: (0.38, 0.42, 0.42), secondary: (0.50, 0.55, 0.55), accent: (0.70, 0.73, 0.73)),
    TeamIcon(key: "security",         name: "보안팀",       emoji: "🔒", subIcons: ["🛡️","🔑","🚨"], primary: (0.66, 0.20, 0.15), secondary: (0.75, 0.22, 0.17), accent: (0.90, 0.69, 0.67)),
    TeamIcon(key: "marketing",        name: "마케팅팀",     emoji: "📢", subIcons: ["📈","🎪","🚀"], primary: (0.90, 0.49, 0.13), secondary: (0.95, 0.61, 0.07), accent: (0.97, 0.77, 0.44)),
    TeamIcon(key: "sales",            name: "세일즈팀",     emoji: "🤝", subIcons: ["💼","📞","💎"], primary: (0.15, 0.68, 0.38), secondary: (0.35, 0.84, 0.55), accent: (0.67, 0.92, 0.78)),
    TeamIcon(key: "customer-support", name: "고객지원팀",   emoji: "🎧", subIcons: ["💝","📱","🌟"], primary: (0.20, 0.60, 0.86), secondary: (0.36, 0.68, 0.89), accent: (0.68, 0.84, 0.95)),
    TeamIcon(key: "data-analytics",   name: "데이터분석팀", emoji: "📊", subIcons: ["🧮","📈","🔮"], primary: (0.56, 0.27, 0.68), secondary: (0.69, 0.48, 0.77), accent: (0.84, 0.74, 0.89)),
    TeamIcon(key: "legal",            name: "법무팀",       emoji: "⚖️", subIcons: ["📜","🏛️","🔍"], primary: (0.39, 0.43, 0.45), secondary: (0.50, 0.55, 0.55), accent: (0.70, 0.73, 0.73)),
    TeamIcon(key: "finance",          name: "재무팀",       emoji: "💰", subIcons: ["📉","💳","🏦"], primary: (0.83, 0.67, 0.05), secondary: (0.95, 0.77, 0.06), accent: (0.98, 0.91, 0.62)),
    TeamIcon(key: "leadership",       name: "리더십팀",     emoji: "👔", subIcons: ["⭐","🏆","🎖️"], primary: (0.09, 0.13, 0.16), secondary: (0.17, 0.24, 0.31), accent: (0.36, 0.43, 0.49)),
    TeamIcon(key: "documentation",    name: "문서화팀",     emoji: "📝", subIcons: ["📖","🗂️","✍️"], primary: (0.08, 0.56, 0.47), secondary: (0.10, 0.74, 0.61), accent: (0.64, 0.89, 0.84)),
    TeamIcon(key: "strategy",         name: "전략팀",       emoji: "🎯", subIcons: ["🧭","📐","🚀"], primary: (1.00, 0.42, 0.21), secondary: (1.00, 0.55, 0.35), accent: (1.00, 0.78, 0.67)),
]

let desktop = "/Users/sanghyunkim/Desktop"
let imgSize: CGFloat = 1024

func generateIcon(team: TeamIcon, outputPath: String) {
    let image = NSImage(size: NSSize(width: imgSize, height: imgSize))
    image.lockFocus()

    let cornerR = imgSize * 0.22

    // 1. Base background
    let bgColor = NSColor(red: team.primary.0, green: team.primary.1, blue: team.primary.2, alpha: 1.0)
    let bgPath = NSBezierPath(roundedRect: NSRect(x: 0, y: 0, width: imgSize, height: imgSize),
                              xRadius: cornerR, yRadius: cornerR)
    bgColor.setFill()
    bgPath.fill()

    // 2. Secondary gradient overlay (top half)
    let secColor = NSColor(red: team.secondary.0, green: team.secondary.1, blue: team.secondary.2, alpha: 0.5)
    let secPath = NSBezierPath(roundedRect: NSRect(x: 0, y: imgSize * 0.4, width: imgSize, height: imgSize * 0.6),
                               xRadius: cornerR, yRadius: cornerR)
    secColor.setFill()
    secPath.fill()

    // 3. Decorative accent circle (top-right)
    let accentColor = NSColor(red: team.accent.0, green: team.accent.1, blue: team.accent.2, alpha: 0.12)
    let circleSize = imgSize * 0.7
    let circlePath = NSBezierPath(ovalIn: NSRect(x: imgSize * 0.45, y: imgSize * 0.35, width: circleSize, height: circleSize))
    accentColor.setFill()
    circlePath.fill()

    // 4. Bottom dark strip
    let stripColor = NSColor(white: 0.0, alpha: 0.2)
    let stripPath = NSBezierPath(roundedRect: NSRect(x: 0, y: 0, width: imgSize, height: imgSize * 0.28),
                                 xRadius: cornerR, yRadius: 0)
    stripColor.setFill()
    stripPath.fill()

    // 5. Sub icons (decorative, semi-transparent)
    let subFont = NSFont.systemFont(ofSize: imgSize * 0.11)
    let subColor = NSColor.white.withAlphaComponent(0.3)
    let subAttrs: [NSAttributedString.Key: Any] = [.font: subFont, .foregroundColor: subColor]
    let positions: [(CGFloat, CGFloat)] = [(0.08, 0.82), (0.83, 0.78), (0.80, 0.42)]
    for (i, sub) in team.subIcons.prefix(3).enumerated() {
        let str = NSAttributedString(string: sub, attributes: subAttrs)
        str.draw(at: NSPoint(x: imgSize * positions[i].0, y: imgSize * positions[i].1))
    }

    // 6. Main emoji (large, centered)
    let emojiFont = NSFont.systemFont(ofSize: imgSize * 0.42)
    let emojiAttrs: [NSAttributedString.Key: Any] = [.font: emojiFont]
    let emojiStr = NSAttributedString(string: team.emoji, attributes: emojiAttrs)
    let emojiStrSize = emojiStr.size()
    emojiStr.draw(at: NSPoint(x: (imgSize - emojiStrSize.width) / 2, y: imgSize * 0.33))

    // 7. Team name with shadow
    let labelFont = NSFont.boldSystemFont(ofSize: imgSize * 0.115)
    let shadow = NSShadow()
    shadow.shadowOffset = NSSize(width: 0, height: -2)
    shadow.shadowBlurRadius = 8
    shadow.shadowColor = NSColor.black.withAlphaComponent(0.7)
    let labelAttrs: [NSAttributedString.Key: Any] = [
        .font: labelFont,
        .foregroundColor: NSColor.white,
        .shadow: shadow
    ]
    let labelStr = NSAttributedString(string: team.name, attributes: labelAttrs)
    let labelSize = labelStr.size()
    labelStr.draw(at: NSPoint(x: (imgSize - labelSize.width) / 2, y: imgSize * 0.08))

    // 8. Thin white border
    let borderColor = NSColor.white.withAlphaComponent(0.12)
    let borderPath = NSBezierPath(roundedRect: NSRect(x: 1, y: 1, width: imgSize - 2, height: imgSize - 2),
                                  xRadius: cornerR, yRadius: cornerR)
    borderPath.lineWidth = 3
    borderColor.setStroke()
    borderPath.stroke()

    image.unlockFocus()

    // Save
    guard let tiffData = image.tiffRepresentation,
          let bitmapRep = NSBitmapImageRep(data: tiffData),
          let pngData = bitmapRep.representation(using: .png, properties: [:]) else {
        print("  ❌ \(team.name) - render failed")
        return
    }
    try! pngData.write(to: URL(fileURLWithPath: outputPath))
}

func pngToIcns(masterPng: String, icnsPath: String) -> Bool {
    let tmpDir = NSTemporaryDirectory() + "iconset_\(UUID().uuidString)"
    let iconsetDir = tmpDir + "/icon.iconset"

    try! FileManager.default.createDirectory(atPath: iconsetDir, withIntermediateDirectories: true)

    let sizes: [(String, Int)] = [
        ("icon_16x16.png", 16), ("icon_16x16@2x.png", 32),
        ("icon_32x32.png", 32), ("icon_32x32@2x.png", 64),
        ("icon_128x128.png", 128), ("icon_128x128@2x.png", 256),
        ("icon_256x256.png", 256), ("icon_256x256@2x.png", 512),
        ("icon_512x512.png", 512), ("icon_512x512@2x.png", 1024),
    ]

    for (fname, sz) in sizes {
        let outPath = iconsetDir + "/" + fname
        let p = Process()
        p.executableURL = URL(fileURLWithPath: "/usr/bin/sips")
        p.arguments = ["-z", "\(sz)", "\(sz)", masterPng, "--out", outPath]
        p.standardOutput = FileHandle.nullDevice
        p.standardError = FileHandle.nullDevice
        try! p.run()
        p.waitUntilExit()
    }

    let p2 = Process()
    p2.executableURL = URL(fileURLWithPath: "/usr/bin/iconutil")
    p2.arguments = ["-c", "icns", iconsetDir, "-o", icnsPath]
    p2.standardOutput = FileHandle.nullDevice
    p2.standardError = FileHandle.nullDevice
    try! p2.run()
    p2.waitUntilExit()

    try? FileManager.default.removeItem(atPath: tmpDir)
    return FileManager.default.fileExists(atPath: icnsPath)
}

// Main
print("=======================================================")
print("  팀별 고유 앱 아이콘 생성 (Swift)")
print("=======================================================")
print()

var success = 0
var fail = 0

for team in teams {
    // Find .app
    let contents = try! FileManager.default.contentsOfDirectory(atPath: desktop)
    guard let appEntry = contents.first(where: { $0.hasSuffix(".app") && $0.contains(team.name) }) else {
        print("  ❌ \(team.name) - .app not found")
        fail += 1
        continue
    }
    let appPath = desktop + "/" + appEntry
    let icnsPath = appPath + "/Contents/Resources/AppIcon.icns"

    print("  🎨 \(team.emoji) \(team.name)...", terminator: " ")
    fflush(stdout)

    let tmpPng = NSTemporaryDirectory() + "team_icon_\(team.key).png"
    generateIcon(team: team, outputPath: tmpPng)

    if FileManager.default.fileExists(atPath: tmpPng) && pngToIcns(masterPng: tmpPng, icnsPath: icnsPath) {
        let attrs = try! FileManager.default.attributesOfItem(atPath: icnsPath)
        let size = attrs[.size] as! Int
        print("✅ (\(size.formatted()) bytes)")
        success += 1
    } else {
        print("❌ failed")
        fail += 1
    }

    try? FileManager.default.removeItem(atPath: tmpPng)
}

// Refresh
print()
print("  🔄 아이콘 캐시 갱신...")
for team in teams {
    let contents = try! FileManager.default.contentsOfDirectory(atPath: desktop)
    if let appEntry = contents.first(where: { $0.hasSuffix(".app") && $0.contains(team.name) }) {
        let p = Process()
        p.executableURL = URL(fileURLWithPath: "/usr/bin/touch")
        p.arguments = [desktop + "/" + appEntry]
        try! p.run()
        p.waitUntilExit()
    }
}

print()
print("=======================================================")
print("  결과: \(success)개 성공 / \(fail)개 실패")
print("=======================================================")
