import RevealOnScroll from "./RevealOnScroll";

interface SectionProps {
  id?: string;
  label: string;
  heading: string;
  body: string;
  bg?: "white" | "gray";
}

export default function Section({
  id,
  label,
  heading,
  body,
  bg = "white",
}: SectionProps) {
  return (
    <section
      id={id}
      className={`py-[200px] px-6 ${
        bg === "gray" ? "bg-gray-50" : "bg-white"
      }`}
    >
      <div className="max-w-[1040px] mx-auto">
        <RevealOnScroll>
          <p className="text-toss-blue text-[16px] font-semibold">{label}</p>
          <h2 className="mt-4 text-[clamp(32px,5vw,48px)] font-bold text-ink leading-[1.3]">
            {heading}
          </h2>
          <p className="mt-6 text-[18px] text-gray-600 leading-[1.7] max-w-[600px]">
            {body}
          </p>
        </RevealOnScroll>
      </div>
    </section>
  );
}
