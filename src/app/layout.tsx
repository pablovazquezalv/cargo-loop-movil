
import Navbar from '@/components/navbar';
import './globals.css';


export const metadata = {
  title: 'Cargo-loop',
  description: 'Envía con seguridad',
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="es">
      <body>
        <Navbar />
        {children}
      </body>
    </html>
  );
}