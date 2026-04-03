#!/usr/bin/env python3
"""Markdown → styled HTML → PDF (via macOS native WebKit)"""
import subprocess, markdown, tempfile, os

INPUT_MD = "/Users/sanghyunkim/Desktop/ai-company/teams/03-synthesis/약사-AI-Agent-IR자료.md"
OUTPUT_PDF = "/Users/sanghyunkim/Desktop/ai-company/teams/03-synthesis/약사-AI-Agent-IR자료.pdf"
TMP_HTML = tempfile.mktemp(suffix=".html")

with open(INPUT_MD, "r", encoding="utf-8") as f:
    md_text = f.read()

html_body = markdown.markdown(
    md_text,
    extensions=["tables", "fenced_code", "toc", "nl2br"],
)

CSS = """
@page { size: A4; margin: 2cm 1.8cm; }
body {
    font-family: -apple-system, BlinkMacSystemFont, "Apple SD Gothic Neo",
                 "Malgun Gothic", sans-serif;
    font-size: 11pt; line-height: 1.7; color: #1a1a1a;
    max-width: 100%; padding: 0;
}
h1 {
    font-size: 22pt; color: #0d47a1;
    border-bottom: 3px solid #0d47a1;
    padding-bottom: 8px; margin-top: 36px;
    page-break-before: always;
}
h1:first-of-type { page-break-before: avoid; }
h2 {
    font-size: 15pt; color: #1565c0;
    border-bottom: 1px solid #ccc;
    padding-bottom: 4px; margin-top: 24px;
}
h3 { font-size: 12.5pt; color: #1976d2; margin-top: 18px; }
table {
    width: 100%; border-collapse: collapse;
    margin: 12px 0; font-size: 9.5pt;
}
th {
    background: #0d47a1; color: #fff;
    padding: 7px 10px; text-align: left; font-weight: 600;
}
td { padding: 6px 10px; border-bottom: 1px solid #ddd; }
tr:nth-child(even) td { background: #f5f7fa; }
pre {
    background: #f4f6f9; border: 1px solid #dde;
    border-radius: 6px; padding: 12px 14px;
    font-size: 8pt; line-height: 1.45;
    white-space: pre-wrap; word-wrap: break-word;
    font-family: "SF Mono", Menlo, Monaco, monospace;
}
code { font-family: "SF Mono", Menlo, Monaco, monospace; font-size: 9pt; }
blockquote {
    border-left: 4px solid #0d47a1; margin: 10px 0;
    padding: 6px 14px; background: #e8eaf6; color: #333;
}
strong { color: #0d47a1; }
hr { border: none; border-top: 1.5px solid #ccc; margin: 28px 0; }
"""

full_html = f"""<!DOCTYPE html>
<html lang="ko">
<head><meta charset="utf-8"><style>{CSS}</style></head>
<body>{html_body}</body>
</html>"""

with open(TMP_HTML, "w", encoding="utf-8") as f:
    f.write(full_html)

# Use macOS native: open HTML and print to PDF via AppleScript
applescript = f'''
tell application "Safari"
    activate
    open POSIX file "{TMP_HTML}"
    delay 3
end tell

delay 2

tell application "System Events"
    tell process "Safari"
        keystroke "p" using command down
        delay 2
        -- Click PDF dropdown at bottom-left
        click menu button "PDF" of sheet 1 of window 1
        delay 1
        click menu item "Save as PDF…" of menu 1 of menu button "PDF" of sheet 1 of window 1
        delay 2
        -- Type filename
        keystroke "a" using command down
        keystroke "{OUTPUT_PDF}"
        delay 1
        keystroke return
        delay 3
    end tell
end tell

tell application "Safari" to close front document
'''

# Alternative simpler approach: use textutil + cupsfilter or pandoc
# Let's try pandoc first since it's installed
print("Converting with pandoc...")
result = subprocess.run([
    "pandoc", INPUT_MD,
    "-f", "markdown",
    "-t", "html5",
    "--standalone",
    "--css=/dev/null",
    "--metadata", "title=PharmAI IR",
    "-o", TMP_HTML,
], capture_output=True, text=True)

# Write our styled HTML instead
with open(TMP_HTML, "w", encoding="utf-8") as f:
    f.write(full_html)

# Use /usr/sbin/cupsfilter to convert HTML to PDF
result = subprocess.run(
    ["/usr/sbin/cupsfilter", TMP_HTML],
    capture_output=True,
)

if result.returncode == 0 and result.stdout:
    with open(OUTPUT_PDF, "wb") as f:
        f.write(result.stdout)
    print(f"PDF saved: {OUTPUT_PDF}")
    sz = os.path.getsize(OUTPUT_PDF)
    print(f"File size: {sz:,} bytes")
else:
    print("cupsfilter failed, trying alternative...")
    print(result.stderr.decode("utf-8", errors="replace")[:500])

    # Fallback: use pandoc with wkhtmltopdf or basic HTML output
    # Save as HTML for manual PDF conversion
    final_html = OUTPUT_PDF.replace(".pdf", ".html")
    with open(final_html, "w", encoding="utf-8") as f:
        f.write(full_html)
    print(f"HTML saved: {final_html}")
    print("Open in browser and use Cmd+P → Save as PDF")

os.unlink(TMP_HTML) if os.path.exists(TMP_HTML) else None
