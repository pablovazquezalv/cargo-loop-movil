'use client';
import { motion } from "framer-motion";
import Beneficios from "@/components/beneficios";
import Footer from "@/components/footer";
import Formulario from "@/components/formulario";
import QuienesSomos from "@/components/quienesSomos";

export default function Home() {
  return (
    <main className="min-h-screen bg-white text-center px-4">
      <section className="flex flex-col items-center justify-center mt-24">
        <motion.h1
          className="text-4xl md:text-6xl font-bold text-blue-800 mb-6"
          initial={{ opacity: 0, y: -50 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, delay: 0.2 }}
        >
          ¡Haz tus envíos más seguros!
        </motion.h1>

        <motion.p
          className="text-lg text-gray-700 mb-2"
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, delay: 0.4 }}
        >
          Grupo de profesionales expertos en logística con más de 20 años de experiencia.
        </motion.p>

        <motion.p
          className="text-lg text-gray-700"
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, delay: 0.6 }}
        >
          Nuestra plataforma te conecta con los generadores de carga.
        </motion.p>

        <motion.div
          className="flex justify-center mt-8"
          initial={{ opacity: 0, scale: 0.8 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.8, delay: 0.8 }}
        >
          <img
            src="/logistics-person.jpg"
            alt="Trabajador logístico"
            className="rounded shadow-md w-full max-w-lg"
          />
        </motion.div>
      </section>

      <QuienesSomos />
      <Beneficios />
      <Formulario />
      <Footer />
    </main>
  );
}
