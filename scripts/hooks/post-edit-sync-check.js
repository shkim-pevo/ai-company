#!/usr/bin/env node
/**
 * PostToolUse Hook — Sync validation after editing team/seed/skill files
 *
 * Edit/Write 후 파일이 teams/, seed script, skills/에 해당하면 검증 실행.
 * async=true로 비차단 동작.
 */

const path = require('path');
const { validateSync } = require('../lib/sync-validator');
const { log } = require('../lib/utils');

function main() {
  // PostToolUse 훅은 stdin으로 tool input을 받음
  let input = '';
  process.stdin.setEncoding('utf8');
  process.stdin.on('data', chunk => { input += chunk; });
  process.stdin.on('end', () => {
    try {
      const data = JSON.parse(input);
      const filePath = data.tool_input?.file_path || data.tool_input?.path || '';

      // teams/, seed script, skills/ 관련 파일인지 확인
      const isSyncRelevant =
        filePath.includes('/teams/') ||
        filePath.includes('seed-from-ai-company') ||
        (filePath.includes('/skills/') && filePath.endsWith('.md'));

      if (!isSyncRelevant) {
        process.exit(0);
        return;
      }

      const projectRoot = process.env.CLAUDE_PLUGIN_ROOT || path.resolve(__dirname, '../..');
      const result = validateSync(projectRoot);

      if (!result.ok || result.warnings.length > 0) {
        log(`\n[SyncCheck] ⚠️ Sync issue after editing ${path.basename(filePath)}:`);
        log(result.summary);
      }
    } catch {
      // JSON 파싱 실패 등은 무시
    }

    process.exit(0);
  });
}

main();
