#!/usr/bin/env python3
"""각 팀별 고유 디자인 앱 아이콘 생성 (macOS AppKit 활용)"""

import subprocess
import os
import tempfile

DESKTOP = "/Users/sanghyunkim/Desktop"

# Team definitions with unique design parameters
# (key, korean_name, emoji, primary_color, secondary_color, accent_color, sub_icons)
TEAMS = [
    ("research",         "조사팀",       "🔍", (41,128,185),  (52,152,219),  (174,214,241), "📡🌐📑"),
    ("debate",           "토론팀",       "💬", (142,68,173),  (155,89,182),  (215,189,226), "⚡🗣️🎯"),
    ("synthesis",        "종합팀",       "🧩", (39,174,96),   (46,204,113),  (171,235,198), "📐🔗📊"),
    ("quality",          "퀄리티팀",     "✅", (22,160,133),  (26,188,156),  (163,228,215), "🔬🛡️⭐"),
    ("planning",         "기획팀",       "📋", (243,156,18),  (241,196,15),  (249,231,159), "🗓️🎯📌"),
    ("design",           "디자인팀",     "🎨", (231,76,60),   (236,112,99),  (245,183,177), "✏️🖌️💎"),
    ("development",      "개발팀",       "💻", (44,62,80),    (52,73,94),    (133,146,158), "</>🔧⚡"),
    ("devops",           "DevOps팀",     "⚙️", (97,106,107),  (127,140,141), (178,186,187), "🐳☁️🔄"),
    ("security",         "보안팀",       "🔒", (169,50,38),   (192,57,43),   (230,176,170), "🛡️🔑🚨"),
    ("marketing",        "마케팅팀",     "📢", (230,126,34),  (243,156,18),  (248,196,113), "📈🎪🚀"),
    ("sales",            "세일즈팀",     "🤝", (39,174,96),   (88,214,141),  (171,235,198), "💼📞💎"),
    ("customer-support", "고객지원팀",   "🎧", (52,152,219),  (93,173,226),  (174,214,241), "💝📱🌟"),
    ("data-analytics",   "데이터분석팀", "📊", (142,68,173),  (175,122,197), (215,189,226), "🧮📈🔮"),
    ("legal",            "법무팀",       "⚖️", (99,110,114),  (127,140,141), (178,186,187), "📜🏛️🔍"),
    ("finance",          "재무팀",       "💰", (212,172,13),  (241,196,15),  (249,231,159), "📉💳🏦"),
    ("leadership",       "리더십팀",     "👔", (23,32,42),    (44,62,80),    (93,109,126),  "⭐🏆🎖️"),
    ("documentation",    "문서화팀",     "📝", (20,143,119),  (26,188,156),  (163,228,215), "📖🗂️✍️"),
    ("strategy",         "전략팀",       "🎯", (255,107,53),  (255,140,90),  (255,200,170), "🧭📐🚀"),
]


def create_team_icon(emoji, label, sub_icons, primary, secondary, accent, output_path):
    """Create a visually distinct team icon using macOS AppKit"""
    pr, pg, pb = [c/255 for c in primary]
    sr, sg, sb = [c/255 for c in secondary]
    ar, ag, ab = [c/255 for c in accent]

    # Extract sub icons for decoration
    subs = list(sub_icons.replace("</", "").replace("/>", ""))
    # Filter to actual emoji characters
    sub_emojis = []
    for ch in sub_icons:
        if ord(ch) > 127 and ch not in ('/', '<', '>'):
            sub_emojis.append(ch)
    sub1 = sub_emojis[0] if len(sub_emojis) > 0 else ""
    sub2 = sub_emojis[1] if len(sub_emojis) > 1 else ""
    sub3 = sub_emojis[2] if len(sub_emojis) > 2 else ""

    script = f'''
use framework "AppKit"
use framework "Foundation"
use scripting additions

set imgSize to 1024
set theImage to current application's NSImage's alloc()'s initWithSize:{{imgSize, imgSize}}
theImage's lockFocus()

-- 1. Background rounded rect with gradient effect
set cornerR to imgSize * 0.22

-- Base color
set baseColor to current application's NSColor's colorWithRed:{pr} green:{pg} blue:{pb} alpha:1.0
set basePath to current application's NSBezierPath's bezierPathWithRoundedRect:{{{{0, 0}}, {{imgSize, imgSize}}}} xRadius:cornerR yRadius:cornerR
baseColor's setFill()
basePath's fill()

-- Top gradient overlay (lighter)
set topColor to current application's NSColor's colorWithRed:{sr} green:{sg} blue:{sb} alpha:0.6
set topPath to current application's NSBezierPath's bezierPathWithRoundedRect:{{{{0, imgSize * 0.4}}, {{imgSize, imgSize * 0.6}}}} xRadius:cornerR yRadius:cornerR
topColor's setFill()
topPath's fill()

-- Accent circle decoration (top-right)
set accentColor to current application's NSColor's colorWithRed:{ar} green:{ag} blue:{ab} alpha:0.15
set circleSize to imgSize * 0.7
set circlePath to current application's NSBezierPath's bezierPathWithOvalInRect:{{{{imgSize * 0.45, imgSize * 0.35}}, {{circleSize, circleSize}}}}
accentColor's setFill()
circlePath's fill()

-- Bottom accent strip
set stripColor to current application's NSColor's colorWithWhite:0.0 alpha:0.2
set stripPath to current application's NSBezierPath's bezierPathWithRoundedRect:{{{{0, 0}}, {{imgSize, imgSize * 0.28}}}} xRadius:cornerR yRadius:0
stripColor's setFill()
stripPath's fill()

-- 2. Sub icons (small, decorative - top area)
set subSize to imgSize * 0.12
set subFont to current application's NSFont's systemFontOfSize:subSize
set subColor to current application's NSColor's colorWithWhite:1.0 alpha:0.35
set subAttrs to current application's NSDictionary's dictionaryWithObjects:{{subFont, subColor}} forKeys:{{current application's NSFontAttributeName, current application's NSForegroundColorAttributeName}}

set sub1Str to current application's NSAttributedString's alloc()'s initWithString:"{sub1}" attributes:subAttrs
sub1Str's drawAtPoint:{{imgSize * 0.08, imgSize * 0.82}}

set sub2Str to current application's NSAttributedString's alloc()'s initWithString:"{sub2}" attributes:subAttrs
sub2Str's drawAtPoint:{{imgSize * 0.82, imgSize * 0.78}}

set sub3Str to current application's NSAttributedString's alloc()'s initWithString:"{sub3}" attributes:subAttrs
sub3Str's drawAtPoint:{{imgSize * 0.78, imgSize * 0.42}}

-- 3. Main emoji (large, centered)
set emojiSize to imgSize * 0.42
set emojiFont to current application's NSFont's systemFontOfSize:emojiSize
set emojiAttrs to current application's NSDictionary's dictionaryWithObjects:{{emojiFont}} forKeys:{{current application's NSFontAttributeName}}
set emojiStr to current application's NSAttributedString's alloc()'s initWithString:"{emoji}" attributes:emojiAttrs
set emojiStrSize to emojiStr's |size|()
set emojiX to (imgSize - (emojiStrSize's width)) / 2
set emojiY to imgSize * 0.33
emojiStr's drawAtPoint:{{emojiX, emojiY}}

-- 4. Team name label (bottom area with shadow)
set labelSize to imgSize * 0.115
set labelFont to current application's NSFont's boldSystemFontOfSize:labelSize
set labelColor to current application's NSColor's whiteColor()

set shadowObj to current application's NSShadow's alloc()'s init()
shadowObj's setShadowOffset:{{0, -2}}
shadowObj's setShadowBlurRadius:6
shadowObj's setShadowColor:(current application's NSColor's colorWithWhite:0.0 alpha:0.7)

set labelAttrs to current application's NSDictionary's dictionaryWithObjects:{{labelFont, labelColor, shadowObj}} forKeys:{{current application's NSFontAttributeName, current application's NSForegroundColorAttributeName, current application's NSShadowAttributeName}}
set labelStr to current application's NSAttributedString's alloc()'s initWithString:"{label}" attributes:labelAttrs
set labelStrSize to labelStr's |size|()
set labelX to (imgSize - (labelStrSize's width)) / 2
set labelY to imgSize * 0.08
labelStr's drawAtPoint:{{labelX, labelY}}

-- 5. Thin border
set borderColor to current application's NSColor's colorWithWhite:1.0 alpha:0.12
set borderPath to current application's NSBezierPath's bezierPathWithRoundedRect:{{{{1, 1}}, {{imgSize - 2, imgSize - 2}}}} xRadius:cornerR yRadius:cornerR
borderPath's setLineWidth:3
borderColor's setStroke()
borderPath's stroke()

theImage's unlockFocus()

-- Save as PNG
set tiffData to theImage's TIFFRepresentation()
set bitmapRep to current application's NSBitmapImageRep's imageRepWithData:tiffData
set pngData to bitmapRep's representationUsingType:(current application's NSBitmapImageFileTypePNG) properties:(current application's NSDictionary's dictionary())
pngData's writeToFile:"{output_path}" atomically:true
'''
    try:
        result = subprocess.run(
            ["osascript", "-l", "AppleScript", "-e", script],
            capture_output=True, text=True, timeout=30
        )
        if result.returncode != 0:
            print(f"\n      osascript error: {result.stderr.strip()[:200]}")
        return os.path.exists(output_path)
    except subprocess.TimeoutExpired:
        print(f"\n      osascript timeout (30s)")
        return False
    except Exception as e:
        print(f"\n      osascript exception: {e}")
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
        subprocess.run(
            ["iconutil", "-c", "icns", iconset, "-o", icns_path],
            capture_output=True
        )
    return os.path.exists(icns_path)


def main():
    print("=" * 55)
    print("  팀별 고유 앱 아이콘 생성")
    print("=" * 55)
    print()

    success = 0
    fail = 0

    for key, kr_name, emoji, primary, secondary, accent, sub_icons in TEAMS:
        # Find .app on desktop
        app_path = None
        for entry in os.listdir(DESKTOP):
            if entry.endswith(".app") and kr_name in entry and os.path.isdir(os.path.join(DESKTOP, entry)):
                app_path = os.path.join(DESKTOP, entry)
                break

        if not app_path:
            print(f"  ❌ {kr_name} - .app not found")
            fail += 1
            continue

        icns_path = os.path.join(app_path, "Contents", "Resources", "AppIcon.icns")
        os.makedirs(os.path.dirname(icns_path), exist_ok=True)

        print(f"  🎨 {emoji} {kr_name}...", end=" ", flush=True)

        with tempfile.TemporaryDirectory() as tmpdir:
            master_png = os.path.join(tmpdir, "master.png")

            # Clean emoji for AppleScript
            clean_emoji = emoji.replace('\ufe0f', '')

            ok = create_team_icon(
                clean_emoji, kr_name, sub_icons,
                primary, secondary, accent, master_png
            )

            if ok and png_to_icns(master_png, icns_path):
                sz = os.path.getsize(icns_path)
                print(f"✅ ({sz:,} bytes)")
                success += 1
            else:
                print("❌ failed")
                fail += 1

    # Touch apps to refresh icons
    print()
    print("  🔄 아이콘 캐시 갱신 중...")
    for key, kr_name, *_ in TEAMS:
        for entry in os.listdir(DESKTOP):
            if entry.endswith(".app") and kr_name in entry:
                app_full = os.path.join(DESKTOP, entry)
                subprocess.run(["touch", app_full], capture_output=True)

    # Clear icon cache
    subprocess.run(
        ["sudo", "killall", "Dock"],
        capture_output=True
    )

    print()
    print("=" * 55)
    print(f"  완료: {success}개 성공 / {fail}개 실패")
    print("=" * 55)


if __name__ == "__main__":
    main()
