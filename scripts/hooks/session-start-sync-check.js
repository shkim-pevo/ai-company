#!/usr/bin/env node
/**
 * SessionStart Hook — Team/Seed/Skill Sync Validation
 *
 * 세션 시작 시 teams/ ↔ seed script ↔ skills/ 일관성을 자동 검증.
 * 다른 세션(antigravity 등)에서 변경한 내용이 동기화되지 않았으면 경고.
 */

const path = require('path');
const { validateSync } = require('../lib/sync-validator');
const { log, output } = require('../lib/utils');

async function main() {
  const projectRoot = process.env.CLAUDE_PLUGIN_ROOT || path.resolve(__dirname, '../..');

  try {
    const result = validateSync(projectRoot);

    if (!result.ok || result.warnings.length > 0) {
      log('[SyncCheck] ⚠️ Sync issues detected');
      output(result.summary);
    } else {
      log('[SyncCheck] ✅ All synced');
    }
  } catch (err) {
    log(`[SyncCheck] Error: ${err.message}`);
  }
}

main();
