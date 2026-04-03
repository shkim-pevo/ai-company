/**
 * sync-validator.js
 *
 * teams/ ↔ seed script ↔ skills/ 일관성 검증 라이브러리.
 * SessionStart 훅, PostToolUse 훅, CI에서 공통 사용.
 *
 * 직접 실행: node scripts/lib/sync-validator.js
 */

const fs = require('fs');
const path = require('path');

/** 산출물(비멤버) 파일 패턴 — 약사-AI 접두사 산출물 + TEAM.md + .html */
const OUTPUT_FILE_PATTERN = /(^TEAM\.md$|^약사-AI|\.html$)/i;

/**
 * 시드 스크립트에서 DEPARTMENTS 배열 파싱
 * @param {string} seedContent - seed-from-ai-company.ts 파일 내용
 * @returns {Map<string, number>} nameEn → memberDef 횟수
 */
function parseSeedDepartments(seedContent) {
  const departments = new Map();

  // nameEn 값 추출
  const nameEnRegex = /nameEn:\s*"([^"]+)"/g;
  const nameEns = [];
  let match;
  while ((match = nameEnRegex.exec(seedContent)) !== null) {
    nameEns.push({ name: match[1], index: match.index });
  }

  // 각 department 블록에서 memberDef 횟수 카운트
  for (let i = 0; i < nameEns.length; i++) {
    const start = nameEns[i].index;
    const end = i + 1 < nameEns.length ? nameEns[i + 1].index : seedContent.length;
    const block = seedContent.substring(start, end);
    const memberCount = (block.match(/memberDef\(/g) || []).length;
    departments.set(nameEns[i].name, memberCount);
  }

  return departments;
}

/**
 * teams/ 디렉토리 스캔
 * @param {string} teamsDir - teams/ 절대 경로
 * @returns {Map<string, {dirName: string, memberCount: number, memberFiles: string[]}>}
 */
function scanTeamsDirectory(teamsDir) {
  const teams = new Map();

  if (!fs.existsSync(teamsDir)) return teams;

  const dirs = fs.readdirSync(teamsDir, { withFileTypes: true })
    .filter(d => d.isDirectory())
    .map(d => d.name);

  for (const dir of dirs) {
    const nameEn = dir.replace(/^\d+-/, '');
    const dirPath = path.join(teamsDir, dir);
    const allFiles = fs.readdirSync(dirPath);
    const memberFiles = allFiles.filter(f =>
      f.endsWith('.md') && !OUTPUT_FILE_PATTERN.test(f)
    );
    teams.set(nameEn, { dirName: dir, memberCount: memberFiles.length, memberFiles });
  }

  return teams;
}

/**
 * skills/ 디렉토리에서 사용 가능한 스킬 목록
 * @param {string} skillsDir - skills/ 절대 경로
 * @returns {Set<string>}
 */
function getAvailableSkills(skillsDir) {
  if (!fs.existsSync(skillsDir)) return new Set();

  return new Set(
    fs.readdirSync(skillsDir, { withFileTypes: true })
      .filter(d => d.isDirectory())
      .map(d => d.name)
  );
}

/**
 * 팀 멤버 파일에서 참조된 스킬 추출
 * @param {string} teamsDir - teams/ 절대 경로
 * @param {Set<string>} availableSkills - 존재하는 스킬 Set
 * @returns {string[]} 경고 메시지 배열
 */
function checkSkillReferences(teamsDir, availableSkills) {
  const warnings = [];
  const missingSkills = new Map(); // skillName → [참조 파일 목록]

  if (!fs.existsSync(teamsDir)) return warnings;

  const dirs = fs.readdirSync(teamsDir, { withFileTypes: true })
    .filter(d => d.isDirectory());

  for (const dir of dirs) {
    const dirPath = path.join(teamsDir, dir.name);
    const mdFiles = fs.readdirSync(dirPath).filter(f => f.endsWith('.md') && !OUTPUT_FILE_PATTERN.test(f));

    for (const mdFile of mdFiles) {
      const content = fs.readFileSync(path.join(dirPath, mdFile), 'utf8');

      // "필수 참조 스킬" 또는 "활용 스킬" 또는 "팀 공통 활용 스킬" 섹션 찾기
      const skillSectionMatch = content.match(/##\s*(필수 참조 스킬|활용 스킬|팀 공통 활용 스킬)([\s\S]*?)(?=\n##\s|\n$|$)/);
      if (!skillSectionMatch) continue;

      const skillSection = skillSectionMatch[2];
      const skillRefs = skillSection.match(/`([a-z][a-z0-9-]*)`/g);
      if (!skillRefs) continue;

      for (const ref of skillRefs) {
        const skillName = ref.replace(/`/g, '');
        if (!availableSkills.has(skillName)) {
          if (!missingSkills.has(skillName)) {
            missingSkills.set(skillName, []);
          }
          missingSkills.get(skillName).push(`${dir.name}/${mdFile}`);
        }
      }
    }
  }

  for (const [skill, files] of missingSkills) {
    warnings.push(`PHANTOM SKILL: '${skill}' referenced in ${files.length} file(s) but skills/${skill}/ not found`);
  }

  return warnings;
}

/**
 * 전체 동기화 검증 실행
 * @param {string} projectRoot - 프로젝트 루트 경로
 * @returns {{ ok: boolean, errors: string[], warnings: string[], summary: string }}
 */
function validateSync(projectRoot) {
  const errors = [];
  const warnings = [];

  const seedPath = path.join(projectRoot, 'paperclip/scripts/seed-from-ai-company.ts');
  const teamsDir = path.join(projectRoot, 'teams');
  const skillsDir = path.join(projectRoot, 'skills');

  // 1. 시드 스크립트 파싱
  if (!fs.existsSync(seedPath)) {
    errors.push('MISSING FILE: paperclip/scripts/seed-from-ai-company.ts not found');
    return buildResult(errors, warnings);
  }

  const seedContent = fs.readFileSync(seedPath, 'utf8');
  const seedTeams = parseSeedDepartments(seedContent);

  // 2. teams/ 디렉토리 스캔
  const fsTeams = scanTeamsDirectory(teamsDir);

  // 3. 크로스체크: seed → teams/
  for (const [nameEn, memberCount] of seedTeams) {
    if (!fsTeams.has(nameEn)) {
      errors.push(`MISSING DIR: DEPARTMENTS has '${nameEn}' but no teams/*-${nameEn}/ directory`);
    } else {
      const fsMemberCount = fsTeams.get(nameEn).memberCount;
      if (fsMemberCount !== memberCount) {
        warnings.push(`COUNT MISMATCH: '${nameEn}' — seed: ${memberCount}, teams/: ${fsMemberCount} member files`);
      }
    }
  }

  // 4. 크로스체크: teams/ → seed
  for (const [nameEn, info] of fsTeams) {
    if (!seedTeams.has(nameEn)) {
      errors.push(`MISSING SEED: teams/${info.dirName}/ exists but no DEPARTMENTS entry for '${nameEn}'`);
    }
  }

  // 5. 스킬 참조 검증
  const availableSkills = getAvailableSkills(skillsDir);
  const skillWarnings = checkSkillReferences(teamsDir, availableSkills);
  warnings.push(...skillWarnings);

  return buildResult(errors, warnings);
}

/**
 * 결과 객체 빌드
 */
function buildResult(errors, warnings) {
  const ok = errors.length === 0;
  const lines = ['=== Team/Seed/Skill Sync Check ==='];

  if (ok && warnings.length === 0) {
    lines.push('Status: ✅ All synced');
  } else if (!ok) {
    lines.push(`Status: ❌ ${errors.length} error(s), ${warnings.length} warning(s)`);
  } else {
    lines.push(`Status: ⚠️ ${warnings.length} warning(s)`);
  }

  if (errors.length > 0) {
    lines.push('', 'ERRORS:');
    errors.forEach((e, i) => lines.push(`  [E${i + 1}] ${e}`));
  }

  if (warnings.length > 0) {
    lines.push('', 'WARNINGS:');
    warnings.forEach((w, i) => lines.push(`  [W${i + 1}] ${w}`));
  }

  if (!ok) {
    lines.push('', '→ CLAUDE.md "3곳 동기화 규칙" 참고');
  }

  lines.push('=====================================');

  return { ok, errors, warnings, summary: lines.join('\n') };
}

// 직접 실행 시 검증 수행
if (require.main === module) {
  const projectRoot = path.resolve(__dirname, '../..');
  const result = validateSync(projectRoot);
  console.log(result.summary);
  process.exit(result.ok ? 0 : 1);
}

module.exports = { validateSync, parseSeedDepartments, scanTeamsDirectory, getAvailableSkills };
