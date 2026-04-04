import Link from "next/link";

interface BusinessCardProps {
  title: string;
  description: string;
  href: string;
}

export default function BusinessCard({
  title,
  description,
  href,
}: BusinessCardProps) {
  return (
    <div className="bg-white rounded-3xl p-10 shadow-[0_2px_8px_rgba(0,0,0,0.04),0_8px_24px_rgba(0,0,0,0.06)]">
      <h3 className="text-2xl font-bold text-ink">{title}</h3>
      <p className="mt-3 text-[17px] text-gray-600 leading-relaxed">
        {description}
      </p>
      <Link
        href={href}
        className="mt-6 inline-flex items-center gap-1 text-toss-blue text-[16px] font-medium hover:underline"
      >
        자세히 보기
        <span aria-hidden="true">→</span>
      </Link>
    </div>
  );
}
