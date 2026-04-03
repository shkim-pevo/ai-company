#!/usr/bin/env python3
"""각 팀별 아이콘 이미지 생성 (PNG → ICNS 변환)"""

import subprocess
import os
import tempfile
import struct
import zlib

DESKTOP = "/Users/sanghyunkim/Desktop"

TEAMS = [
    ("research",         "조사팀",       "🔍", (41, 128, 185)),
    ("debate",           "토론팀",       "💬", (142, 68, 173)),
    ("synthesis",        "종합팀",       "🧩", (39, 174, 96)),
    ("quality",          "퀄리티팀",     "✅", (22, 160, 133)),
    ("planning",         "기획팀",       "📋", (243, 156, 18)),
    ("design",           "디자인팀",     "🎨", (231, 76, 60)),
    ("development",      "개발팀",       "💻", (52, 73, 94)),
    ("devops",           "DevOps팀",     "⚙️", (127, 140, 141)),
    ("security",         "보안팀",       "🔒", (192, 57, 43)),
    ("marketing",        "마케팅팀",     "📢", (230, 126, 34)),
    ("sales",            "세일즈팀",     "🤝", (46, 204, 113)),
    ("customer-support", "고객지원팀",   "🎧", (52, 152, 219)),
    ("data-analytics",   "데이터분석팀", "📊", (155, 89, 182)),
    ("legal",            "법무팀",       "⚖️", (149, 165, 166)),
    ("finance",          "재무팀",       "💰", (241, 196, 15)),
    ("leadership",       "리더십팀",     "👔", (44, 62, 80)),
    ("documentation",    "문서화팀",     "📝", (26, 188, 156)),
    ("strategy",         "전략팀",       "🎯", (255, 107, 53)),
]


def create_png(width, height, emoji, label, bg_color):
    """Create a simple PNG icon using pure Python (no PIL needed)"""

    def make_png(w, h, pixels):
        """Generate PNG binary data from RGBA pixel array"""
        def chunk(chunk_type, data):
            c = chunk_type + data
            crc = struct.pack('>I', zlib.crc32(c) & 0xffffffff)
            return struct.pack('>I', len(data)) + c + crc

        header = b'\x89PNG\r\n\x1a\n'
        ihdr = chunk(b'IHDR', struct.pack('>IIBBBBB', w, h, 8, 6, 0, 0, 0))

        raw = b''
        for y in range(h):
            raw += b'\x00'  # filter byte
            for x in range(w):
                raw += bytes(pixels[y][x])

        idat = chunk(b'IDAT', zlib.compress(raw))
        iend = chunk(b'IEND', b'')
        return header + ihdr + idat + iend

    pixels = []
    r, g, b = bg_color
    corner_radius = width // 5

    for y in range(height):
        row = []
        for x in range(width):
            # Rounded rectangle
            in_rect = True
            alpha = 255

            # Check corners
            corners = [
                (corner_radius, corner_radius),
                (width - corner_radius - 1, corner_radius),
                (corner_radius, height - corner_radius - 1),
                (width - corner_radius - 1, height - corner_radius - 1),
            ]
            for cx, cy in corners:
                if ((x < corner_radius or x > width - corner_radius - 1) and
                    (y < corner_radius or y > height - corner_radius - 1)):
                    dx = x - cx
                    dy = y - cy
                    dist = (dx*dx + dy*dy) ** 0.5
                    if dist > corner_radius:
                        in_rect = False
                    elif dist > corner_radius - 1.5:
                        alpha = int(255 * (corner_radius - dist) / 1.5)

            if not in_rect:
                row.append((0, 0, 0, 0))
            else:
                # Gradient: lighter at top
                factor = 1.0 + 0.15 * (1.0 - y / height)
                pr = min(255, int(r * factor))
                pg = min(255, int(g * factor))
                pb = min(255, int(b * factor))
                row.append((pr, pg, pb, alpha))
        pixels.append(row)

    return make_png(width, height, pixels)


def create_iconset(emoji, label, bg_color, output_icns):
    """Create .icns file using iconutil"""
    with tempfile.TemporaryDirectory() as tmpdir:
        iconset_dir = os.path.join(tmpdir, "icon.iconset")
        os.makedirs(iconset_dir)

        sizes = {
            "icon_16x16.png": 16,
            "icon_16x16@2x.png": 32,
            "icon_32x32.png": 32,
            "icon_32x32@2x.png": 64,
            "icon_128x128.png": 128,
            "icon_128x128@2x.png": 256,
            "icon_256x256.png": 256,
            "icon_256x256@2x.png": 512,
            "icon_512x512.png": 512,
            "icon_512x512@2x.png": 1024,
        }

        for filename, size in sizes.items():
            png_data = create_png(size, size, emoji, label, bg_color)
            png_path = os.path.join(iconset_dir, filename)
            with open(png_path, 'wb') as f:
                f.write(png_data)

        # Use sips + iconutil to create proper icon with text overlay
        # First create a master 1024px PNG with text using Core Graphics via osascript
        master_png = os.path.join(tmpdir, "master.png")
        create_icon_with_text(1024, emoji, label, bg_color, master_png)

        if os.path.exists(master_png):
            # Replace all sizes with properly rendered versions
            for filename, size in sizes.items():
                sized_png = os.path.join(iconset_dir, filename)
                subprocess.run([
                    "sips", "-z", str(size), str(size),
                    master_png, "--out", sized_png
                ], capture_output=True)

        subprocess.run(["iconutil", "-c", "icns", iconset_dir, "-o", output_icns],
                       capture_output=True)


def create_icon_with_text(size, emoji, label, bg_color, output_path):
    """Use macOS native tools to create icon with emoji and text"""
    r, g, b = bg_color
    rf, gf, bf = r/255, g/255, b/255

    # Use Objective-C via Python to render
    script = f'''
    tell application "System Events"
    end tell

    use framework "AppKit"
    use framework "Foundation"
    use scripting additions

    set imgSize to {size}
    set theImage to current application's NSImage's alloc()'s initWithSize:{{imgSize, imgSize}}
    theImage's lockFocus()

    -- Background rounded rect
    set bgColor to current application's NSColor's colorWithRed:{rf} green:{gf} blue:{bf} alpha:1.0
    set bgPath to current application's NSBezierPath's bezierPathWithRoundedRect:{{{{0, 0}}, {{imgSize, imgSize}}}} xRadius:(imgSize * 0.2) yRadius:(imgSize * 0.2)
    bgColor's setFill()
    bgPath's fill()

    -- Lighter overlay at top
    set gradColor to current application's NSColor's colorWithWhite:1.0 alpha:0.15
    set gradRect to current application's NSBezierPath's bezierPathWithRect:{{{{0, imgSize * 0.5}}, {{imgSize, imgSize * 0.5}}}}
    gradColor's setFill()
    gradRect's fill()

    -- Emoji text
    set emojiSize to imgSize * 0.45
    set emojiFont to current application's NSFont's systemFontOfSize:emojiSize
    set emojiAttrs to current application's NSDictionary's dictionaryWithObjects:{{emojiFont}} forKeys:{{current application's NSFontAttributeName}}
    set emojiStr to current application's NSAttributedString's alloc()'s initWithString:"{emoji}" attributes:emojiAttrs
    set emojiStrSize to emojiStr's |size|()
    set emojiX to (imgSize - (emojiStrSize's width)) / 2
    set emojiY to imgSize * 0.35
    emojiStr's drawAtPoint:{{emojiX, emojiY}}

    -- Label text
    set labelSize to imgSize * 0.13
    set labelFont to current application's NSFont's boldSystemFontOfSize:labelSize
    set labelColor to current application's NSColor's whiteColor()
    set shadowObj to current application's NSShadow's alloc()'s init()
    shadowObj's setShadowOffset:{{0, -1}}
    shadowObj's setShadowBlurRadius:3
    shadowObj's setShadowColor:(current application's NSColor's colorWithWhite:0.0 alpha:0.5)
    set labelAttrs to current application's NSDictionary's dictionaryWithObjects:{{labelFont, labelColor, shadowObj}} forKeys:{{current application's NSFontAttributeName, current application's NSForegroundColorAttributeName, current application's NSShadowAttributeName}}
    set labelStr to current application's NSAttributedString's alloc()'s initWithString:"{label}" attributes:labelAttrs
    set labelStrSize to labelStr's |size|()
    set labelX to (imgSize - (labelStrSize's width)) / 2
    set labelY to imgSize * 0.12
    labelStr's drawAtPoint:{{labelX, labelY}}

    theImage's unlockFocus()

    -- Save as PNG
    set tiffData to theImage's TIFFRepresentation()
    set bitmapRep to current application's NSBitmapImageRep's imageRepWithData:tiffData
    set pngData to bitmapRep's representationUsingType:(current application's NSBitmapImageFileTypePNG) properties:(current application's NSDictionary's dictionary())
    pngData's writeToFile:"{output_path}" atomically:true
    '''

    subprocess.run(["osascript", "-l", "AppleScript", "-e", script],
                   capture_output=True, timeout=30)


def main():
    for key, kr_name, emoji, color in TEAMS:
        clean_emoji = emoji.replace('\ufe0f', '')  # remove variation selector
        app_name = f"{clean_emoji} {kr_name}"
        app_path = os.path.join(DESKTOP, f"{app_name}.app")
        icns_path = os.path.join(app_path, "Contents", "Resources", "AppIcon.icns")

        if not os.path.isdir(app_path):
            print(f"⚠️  {app_name}.app not found, skipping")
            continue

        print(f"🎨 Generating icon for {kr_name}...", end=" ", flush=True)
        create_iconset(clean_emoji, kr_name, color, icns_path)

        if os.path.exists(icns_path):
            print("✅")
        else:
            # Fallback: use the pure Python PNG-based icon
            print("(fallback) ", end="", flush=True)
            with tempfile.TemporaryDirectory() as tmpdir:
                iconset_dir = os.path.join(tmpdir, "icon.iconset")
                os.makedirs(iconset_dir)
                sizes = {
                    "icon_16x16.png": 16, "icon_16x16@2x.png": 32,
                    "icon_32x32.png": 32, "icon_32x32@2x.png": 64,
                    "icon_128x128.png": 128, "icon_128x128@2x.png": 256,
                    "icon_256x256.png": 256, "icon_256x256@2x.png": 512,
                    "icon_512x512.png": 512, "icon_512x512@2x.png": 1024,
                }
                for fname, sz in sizes.items():
                    png_data = create_png(sz, sz, clean_emoji, kr_name, color)
                    with open(os.path.join(iconset_dir, fname), 'wb') as f:
                        f.write(png_data)
                subprocess.run(["iconutil", "-c", "icns", iconset_dir, "-o", icns_path],
                               capture_output=True)
            print("✅" if os.path.exists(icns_path) else "❌")

    # Clear icon cache
    print("\n🔄 Refreshing icon cache...")
    subprocess.run(["touch", *[
        os.path.join(DESKTOP, f"{e.replace(chr(0xfe0f),'')} {n}.app")
        for _, n, e, _ in TEAMS
    ]], capture_output=True)

    print("\n✨ 모든 팀 아이콘 생성 완료!")


if __name__ == "__main__":
    main()
