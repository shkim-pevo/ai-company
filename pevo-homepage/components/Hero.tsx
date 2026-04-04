import Link from "next/link";

export default function Hero() {
  return (
    <section className="bg-white py-[200px] flex flex-col items-center text-center px-6">
      <h1 className="text-[clamp(36px,6vw,56px)] font-bold leading-[1.2] text-ink">
        헬스케어의 AI 전환을
        <br />
        설계합니다.
      </h1>
      <p className="mt-6 text-lg text-gray-600 leading-relaxed max-w-[480px]">
        파트너의 레거시 시스템을 AI로 전환하여
        <br />
        새로운 성장을 만듭니다.
      </p>
      <Link
        href="/business"
        className="mt-10 inline-flex items-center gap-2 bg-toss-blue hover:bg-toss-blue-hover active:bg-toss-blue-active text-white px-8 py-4 rounded-xl text-[17px] font-semibold transition-colors"
      >
        사업소개 보기
        <span aria-hidden="true">→</span>
      </Link>
    </section>
  );
}
