import Link from "next/link";

export default function Nav() {
  return (
    <nav className="sticky top-0 z-50 bg-white border-b border-gray-200">
      <div className="max-w-[1040px] mx-auto px-6 h-16 flex items-center justify-between">
        <Link href="/" className="text-xl font-bold text-ink">
          Pevo
        </Link>
        <div className="flex items-center gap-8">
          <Link
            href="/business"
            className="text-[15px] font-medium text-gray-600 hover:text-ink transition-colors"
          >
            사업소개
          </Link>
          <a
            href="mailto:contact@pevo.care"
            className="text-[15px] font-medium text-gray-600 hover:text-ink transition-colors"
          >
            문의하기
          </a>
        </div>
      </div>
    </nav>
  );
}
