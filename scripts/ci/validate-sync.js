#!/usr/bin/env node
/**
 * CI Validation — Team/Seed/Skill Sync Check
 *
 * 기존 validate-agents.js, validate-skills.js와 동일 패턴.
 * teams/ ↔ seed script ↔ skills/ 일관성 검증.
 */

const path = require('path');
const { validateSync } = require('../lib/sync-validator');

const projectRoot = path.resolve(__dirname, '../..');
const result = validateSync(projectRoot);

console.log(result.summary);

if (!result.ok) {
  console.error(`\n❌ Sync validation failed with ${result.errors.length} error(s)`);
  process.exit(1);
}

if (result.warnings.length > 0) {
  console.log(`\n⚠️ Sync validation passed with ${result.warnings.length} warning(s)`);
} else {
  console.log('\n✅ Sync validation passed');
}
