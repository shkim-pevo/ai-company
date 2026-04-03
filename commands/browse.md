---
description: Headless browser for QA testing, dogfooding, and site verification (~100ms per command)
---

# /browse

Fast headless Chromium browser for QA testing and dogfooding.

Load the `skills/browse/SKILL.md` skill for the full command reference and QA workflow patterns.

## Quick Start

```bash
B=$(skills/browse/browse/bin/find-browse 2>/dev/null)
$B goto https://yourapp.com
$B snapshot -i          # see interactive elements
$B text                 # read page content
$B console              # check for JS errors
$B screenshot /tmp/check.png
```
