export default function Footer() {
  return (
    <footer className="bg-black py-20">
      <div className="max-w-[1040px] mx-auto px-6">
        <p className="text-gray-400 text-[15px]">
          © 2026 Pevo. All rights reserved.
        </p>
        <a
          href="mailto:contact@pevo.care"
          className="text-gray-400 text-[15px] hover:text-gray-300 transition-colors mt-2 inline-block"
        >
          contact@pevo.care
        </a>
      </div>
    </footer>
  );
}
