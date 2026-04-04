import Hero from "@/components/Hero";
import BusinessCard from "@/components/BusinessCard";

export default function Home() {
  return (
    <main>
      <Hero />

      <section className="bg-gray-50 py-[120px] px-6">
        <div className="max-w-[1040px] mx-auto">
          <p className="text-toss-blue text-[16px] font-semibold">
            What We Do
          </p>
          <h2 className="mt-3 text-[clamp(28px,4vw,40px)] font-bold text-ink">
            Healthcare AX Platform
          </h2>

          <div className="mt-12 grid grid-cols-1 md:grid-cols-2 gap-6">
            <BusinessCard
              title="크레소티"
              description="약국 16,500곳의 AI 전환 파트너"
              href="/business#cresotti"
            />
            <BusinessCard
              title="하울팟"
              description="펫 케어 플랫폼의 자동화 파트너"
              href="/business#howlpot"
            />
          </div>
        </div>
      </section>
    </main>
  );
}
