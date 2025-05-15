// components/QuienesSomos.tsx

import Image from "next/image";

export default function QuienesSomos() {
  return (
    <section className="min-h-screen px-6 py-12 md:px-24 md:py-20 bg-white">
      <div className="grid md:grid-cols-2 gap-12 items-start">
        {/* Text Block */}
        <div className="space-y-10">
          <div className="p-6">
            <h2 className="text-3xl font-bold text-blue-800 mb-4">¿Quienes somos?</h2>
            <p className="text-gray-800 mb-4">
              Somos un grupo de profesionales expertos en logística con más de 20 años de experiencia. Nuestra plataforma te conecta con los generadores de carga, todo esto, dentro de una comunidad segura y cerrada.
            </p>
            <p className="text-gray-800">
              La inteligencia de la plataforma permite generar conexiones automáticas y en tiempo real entre Generadores de Carga y Transportistas con unidades y espacio disponible, geográficamente cercanos.
            </p>
          </div>

          <div className="p-6">
            <h2 className="text-3xl font-bold text-blue-800 mb-4">Misión</h2>
            <p className="text-gray-800">
              Nuestra misión es desarrollar continuamente soluciones tecnológicas de vanguardia para la industria del transporte incluyendo la Inteligencia Artificial, Machine Learning para generar Inteligencia de Negocio.
            </p>
          </div>
        </div>

        {/* Image */}
        <div className="flex justify-center">
          <Image
            src="/logistics-person.jpg" // Cambia por tu imagen
            alt="Trabajador logístico"
            width={500}
            height={350}
            className="rounded shadow-md"
          />
        </div>
      </div>
    </section>
  );
}
