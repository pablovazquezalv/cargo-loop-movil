
'use client'
import { useRouter } from 'next/navigation'

export default function Login() {
    const router = useRouter()

  

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-white">
      <h1 className="text-3xl font-bold text-blue-800 mb-10">Iniciar sesión</h1>
      <div className="w-full max-w-sm p-8 bg-white rounded-lg shadow-md">
        <label className="block mb-4">
          <span className="text-gray-700">Correo electronico</span>
          <input
            type="email"
            placeholder="Proporciona el correo que se te dio para ingresar"
            className="w-full mt-2 p-3 border rounded focus:outline-none focus:ring focus:ring-blue-200"
          />
        </label>
        <label className="block mb-6">
          <span className="text-gray-700">Contraseña</span>
          <input
            type="password"
            placeholder="Proporciona la contraseña que se te dio para ingresar"
            className="w-full mt-2 p-3 border rounded focus:outline-none focus:ring focus:ring-blue-200"
          />
        </label>
        <button
            type='button'
            onClick={() => router.push('/manager/dashboard')}
            className="w-full py-3 bg-blue-800 text-white rounded hover:bg-blue-900 transition-all"
        >
            Iniciar sesión
        </button>   <a href="/dashboard" className="block text-center text-blue-700 mt-4 hover:underline">¿Olvidaste tu contraseña?</a>
      </div>
    </div>
  );
}
