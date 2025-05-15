'use client';

import Link from 'next/link';

export default function Navbar() {
  return (
    <nav className="flex items-center justify-between px-6 py-4 shadow-sm">
      <div className="text-2xl font-bold">
        <Link href="/">Logo
          <img src="/logo.png" alt="Logo" className="h-8 inline-block" />
        </Link>
      </div>
      <ul className="flex space-x-6">
        <li><Link href="/">Generador de carga</Link></li>
        <li><Link href="#">Transportista</Link></li>
        <li><Link href="/">¿Quiénes somos?</Link></li>
      </ul>
      <div className="flex space-x-3">
        <Link href="/login" className="px-4 py-1 text-white bg-blue-800 rounded">Iniciar sesión</Link>
        <Link href="/register" className="px-4 py-1 text-white bg-blue-800 rounded">Crear cuenta</Link>
      </div>
    </nav>
  );
}