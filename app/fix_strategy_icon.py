#!/usr/bin/env python3
"""전략팀 아이콘을 다른 팀과 동일한 스타일로 재생성 (JXA 방식 - AppleScript 예약어 충돌 회피)"""

import subprocess
import os
import tempfile

DESKTOP = os.path.expanduser("~/Desktop")


def create_strategy_icon(output_path):
    """JXA(JavaScript for Automation)로 전략팀 아이콘 생성"""

    jxa_script = '''
ObjC.import("AppKit");
ObjC.import("Foundation");

var imgSize = 1024;
var theImage = $.NSImage.alloc.initWithSize({width: imgSize, height: imgSize});
theImage.lockFocus;

var cornerR = imgSize * 0.22;

// 1. Base color (orange)
var baseColor = $.NSColor.colorWithRedGreenBlueAlpha(1.0, 0.42, 0.208, 1.0);
var basePath = $.NSBezierPath.bezierPathWithRoundedRectXRadiusYRadius(
    {x:0, y:0, width:imgSize, height:imgSize}, cornerR, cornerR);
baseColor.setFill;
basePath.fill;

// Top gradient overlay
var topColor = $.NSColor.colorWithRedGreenBlueAlpha(1.0, 0.549, 0.353, 0.6);
var topPath = $.NSBezierPath.bezierPathWithRoundedRectXRadiusYRadius(
    {x:0, y:imgSize*0.4, width:imgSize, height:imgSize*0.6}, cornerR, cornerR);
topColor.setFill;
topPath.fill;

// Accent circle
var accentColor = $.NSColor.colorWithRedGreenBlueAlpha(1.0, 0.784, 0.667, 0.15);
var circleSize = imgSize * 0.7;
var circlePath = $.NSBezierPath.bezierPathWithOvalInRect(
    {x:imgSize*0.45, y:imgSize*0.35, width:circleSize, height:circleSize});
accentColor.setFill;
circlePath.fill;

// Bottom strip
var stripColor = $.NSColor.colorWithWhiteAlpha(0.0, 0.2);
var stripPath = $.NSBezierPath.bezierPathWithRoundedRectXRadiusYRadius(
    {x:0, y:0, width:imgSize, height:imgSize*0.28}, cornerR, 0);
stripColor.setFill;
stripPath.fill;

// 2. Sub icons
var subSize = imgSize * 0.12;
var subFont = $.NSFont.systemFontOfSize(subSize);
var subColor = $.NSColor.colorWithWhiteAlpha(1.0, 0.35);
var subAttrs = $.NSDictionary.dictionaryWithObjectsForKeys(
    [subFont, subColor],
    [$.NSFontAttributeName, $.NSForegroundColorAttributeName]);

var sub1 = $.NSAttributedString.alloc.initWithStringAttributes("\\uD83E\\uDDED", subAttrs);
sub1.drawAtPoint({x: imgSize*0.08, y: imgSize*0.82});

var sub2 = $.NSAttributedString.alloc.initWithStringAttributes("\\uD83D\\uDCD0", subAttrs);
sub2.drawAtPoint({x: imgSize*0.82, y: imgSize*0.78});

var sub3 = $.NSAttributedString.alloc.initWithStringAttributes("\\uD83D\\uDE80", subAttrs);
sub3.drawAtPoint({x: imgSize*0.78, y: imgSize*0.42});

// 3. Main emoji
var emojiSize = imgSize * 0.42;
var emojiFont = $.NSFont.systemFontOfSize(emojiSize);
var emojiAttrs = $.NSDictionary.dictionaryWithObjectsForKeys(
    [emojiFont], [$.NSFontAttributeName]);
var emojiStr = $.NSAttributedString.alloc.initWithStringAttributes("\\uD83C\\uDFAF", emojiAttrs);
var emojiStrSize = emojiStr.size;
var emojiX = (imgSize - emojiStrSize.width) / 2;
emojiStr.drawAtPoint({x: emojiX, y: imgSize * 0.33});

// 4. Team label with shadow
var labelSize = imgSize * 0.115;
var labelFont = $.NSFont.boldSystemFontOfSize(labelSize);
var labelColor = $.NSColor.whiteColor;

var shadowObj = $.NSShadow.alloc.init;
shadowObj.shadowOffset = {width: 0, height: -2};
shadowObj.shadowBlurRadius = 6;
shadowObj.shadowColor = $.NSColor.colorWithWhiteAlpha(0.0, 0.7);

var labelAttrs = $.NSDictionary.dictionaryWithObjectsForKeys(
    [labelFont, labelColor, shadowObj],
    [$.NSFontAttributeName, $.NSForegroundColorAttributeName, $.NSShadowAttributeName]);
var labelStr = $.NSAttributedString.alloc.initWithStringAttributes("\\uC804\\uB7B5\\uD300", labelAttrs);
var labelStrSize = labelStr.size;
var labelX = (imgSize - labelStrSize.width) / 2;
labelStr.drawAtPoint({x: labelX, y: imgSize * 0.08});

// 5. Border
var borderColor = $.NSColor.colorWithWhiteAlpha(1.0, 0.12);
var borderPath = $.NSBezierPath.bezierPathWithRoundedRectXRadiusYRadius(
    {x:1, y:1, width:imgSize-2, height:imgSize-2}, cornerR, cornerR);
borderPath.lineWidth = 3;
borderColor.setStroke;
borderPath.stroke;

theImage.unlockFocus;

// Save as PNG
var tiffData = theImage.TIFFRepresentation;
var bitmapRep = $.NSBitmapImageRep.imageRepWithData(tiffData);
var pngData = bitmapRep.representationUsingTypeProperties($.NSBitmapImageFileTypePNG, $.NSDictionary.dictionary);
pngData.writeToFileAtomically("''' + output_path + '''", true);
'''

    try:
        with tempfile.NamedTemporaryFile(mode='w', suffix='.js', delete=False, encoding='utf-8') as f:
            f.write(jxa_script)
            script_path = f.name

        result = subprocess.run(
            ["osascript", "-l", "JavaScript", script_path],
            capture_output=True, text=True, timeout=30
        )
        os.unlink(script_path)

        if result.returncode != 0:
            print(f"  JXA error: {result.stderr.strip()}")
            return False
        return os.path.exists(output_path)
    except subprocess.TimeoutExpired:
        print("  timeout (30s)")
        return False
    except Exception as e:
        print(f"  Exception: {e}")
        return False


def png_to_icns(master_png, icns_path):
    """Convert master PNG to .icns via iconset"""
    with tempfile.TemporaryDirectory() as tmpdir:
        iconset = os.path.join(tmpdir, "icon.iconset")
        os.makedirs(iconset)
        sizes = {
            "icon_16x16.png": 16, "icon_16x16@2x.png": 32,
            "icon_32x32.png": 32, "icon_32x32@2x.png": 64,
            "icon_128x128.png": 128, "icon_128x128@2x.png": 256,
            "icon_256x256.png": 256, "icon_256x256@2x.png": 512,
            "icon_512x512.png": 512, "icon_512x512@2x.png": 1024,
        }
        for fname, sz in sizes.items():
            out = os.path.join(iconset, fname)
            subprocess.run(
                ["sips", "-z", str(sz), str(sz), master_png, "--out", out],
                capture_output=True
            )
        result = subprocess.run(
            ["iconutil", "-c", "icns", iconset, "-o", icns_path],
            capture_output=True, text=True
        )
        if result.returncode != 0:
            print(f"  iconutil error: {result.stderr.strip()}")
    return os.path.exists(icns_path)


def main():
    print("=" * 50)
    print("  전략팀 아이콘 재생성 (JXA 방식)")
    print("=" * 50)
    print()

    app_path = None
    for entry in os.listdir(DESKTOP):
        if entry.endswith(".app") and "전략팀" in entry:
            app_path = os.path.join(DESKTOP, entry)
            break

    if not app_path:
        print("  ❌ 전략팀 .app을 바탕화면에서 찾을 수 없습니다.")
        return

    print(f"  앱 경로: {app_path}")
    icns_path = os.path.join(app_path, "Contents", "Resources", "AppIcon.icns")

    with tempfile.TemporaryDirectory() as tmpdir:
        master_png = os.path.join(tmpdir, "master.png")

        print("  🎨 아이콘 생성 중...", end=" ", flush=True)
        ok = create_strategy_icon(master_png)

        if ok:
            print("PNG ✅")
            print("  📦 .icns 변환 중...", end=" ", flush=True)
            if png_to_icns(master_png, icns_path):
                sz = os.path.getsize(icns_path)
                print(f"✅ ({sz:,} bytes)")
            else:
                print("❌ icns 변환 실패")
        else:
            print("❌ PNG 생성 실패")
            return

    print("  🔄 아이콘 캐시 갱신...")
    subprocess.run(["touch", app_path], capture_output=True)
    subprocess.run(["killall", "Dock"], capture_output=True)

    print()
    print("  ✅ 전략팀 아이콘이 다른 팀과 동일한 스타일로 업데이트되었습니다!")


if __name__ == "__main__":
    main()
