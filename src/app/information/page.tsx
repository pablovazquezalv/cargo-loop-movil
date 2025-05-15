
'use client'
import { useRouter } from 'next/navigation'
import { useState, ChangeEvent } from 'react';

export default function CodigoAutenticacion() {

    const router = useRouter();
    const [code, setCode] = useState<string[]>(['', '', '', '']);

    const handleChange = (index: number, value: string) => {
        if (/^\d?$/.test(value)) {
            const newCode = [...code];
            newCode[index] = value;
            setCode(newCode);

            // Auto focus next input
            if (value && index < code.length - 1) {
                const nextInput = document.getElementById(`code-${index + 1}`) as HTMLInputElement;
                if (nextInput) nextInput.focus();
            }
        }
    };

    return (
        <main className="min-h-screen flex flex-col items-center justify-center bg-white px-4">
            <h1 className="text-4xl font-bold text-blue-800 mb-10">Codigo de Autenticación</h1>
            <p className="text-lg text-gray-700 mb-6">Ingresa el codigo que se te mando al telefono.</p>
            <div className="flex gap-4 mb-6">
                {code.map((digit, index) => (
                    <input
                        key={index}
                        id={`code-${index}`}
                        type="text"
                        maxLength={1}
                        value={digit}
                        onChange={(e: ChangeEvent<HTMLInputElement>) => handleChange(index, e.target.value)}
                        className="w-12 h-12 text-center border rounded-md text-2xl"
                    />
                ))}
            </div>
            <p className="text-gray-700 mb-6">No te llego ningun correo? <span className="text-blue-800 cursor-pointer">Reenviar</span></p>
            <button 
            type='button'
            onClick={() => router.push('/login')}
            className="w-full max-w-xs py-3 bg-blue-800 text-white text-lg">Ingresar</button>
        </main>
    );
}
