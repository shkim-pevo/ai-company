import type { Metadata } from "next";
import Section from "@/components/Section";

export const metadata: Metadata = {
  title: "사업소개 — Pevo",
  description: "Pevo의 Healthcare AX Platform 사업을 소개합니다.",
};

export default function Business() {
  return (
    <main>
      <Section
        label="AX 플랫폼"
        heading="파트너의 시스템을 AI로 전환합니다."
        body="전환 1건이 매출 3배로 돌아옵니다. Pevo는 파트너의 레거시 시스템에 AI 백본을 구축하여 운영 자동화, 데이터 분석, 고객 커뮤니케이션을 통합 제공합니다."
        bg="white"
      />

      <Section
        id="cresotti"
        label="크레소티"
        heading="약국 16,500곳의 AI 전환 파트너"
        body="대한민국 약국 POS 시장점유율 70%. 크레소티의 레거시 POS를 AI 기반 플랫폼으로 전환하는 3년 독점 파트너십."
        bg="gray"
      />

      <Section
        id="howlpot"
        label="하울팟"
        heading="펫 케어의 새로운 표준"
        body="대경펫케어의 수기 운영을 자동화 플랫폼으로 전환. 보호자 앱 · 시터 앱 · 관리 대시보드 · 자동 정산."
        bg="white"
      />
    </main>
  );
}
