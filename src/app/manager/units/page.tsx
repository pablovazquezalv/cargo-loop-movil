'use client';
import React, { useState } from 'react';
import Image from 'next/image';
import Button from '@/components/ui/button';
import Card from '@/components/ui/card';
import CardContent from '@/components/ui/card-content';

export default function UnitsPage() {
    const [unidades] = useState([
        { id: 24324, unidad: 'Camioneta 23', modelo: '234554', marca: 'Ford', placas: '4534DGG', tarjetaCirculacion: true, transportista: 'Pablo Vazquez' },
    ]);

    return (
        <div className="p-10">
            <h1 className="text-3xl font-bold mb-6">Tus unidades</h1>

            <Button className="ml-auto mb-6 bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700">
                Añadir Unidad
            </Button>

            <Card className="overflow-hidden rounded-2xl border-2 border-blue-400 shadow-md">
                <CardContent className="p-6 bg-gray-50 rounded-2xl">
                    <table className="w-full text-left">
                        <thead>
                            <tr>
                                <th className="px-4 py-2 font-semibold">#ID</th>
                                <th className="px-4 py-2 font-semibold">Unidad</th>
                                <th className="px-4 py-2 font-semibold">Modelo</th>
                                <th className="px-4 py-2 font-semibold">Marca</th>
                                <th className="px-4 py-2 font-semibold">Placas</th>
                                <th className="px-4 py-2 font-semibold">Tarjeta de circulación</th>
                                <th className="px-4 py-2 font-semibold">Transportista</th>
                                <th className="px-4 py-2"></th>
                            </tr>
                        </thead>
                        <tbody>
                            {unidades.map((unidad) => (
                                <tr key={unidad.id} className="bg-white border-b-2 last:border-b-0">
                                    <td className="px-4 py-2">{unidad.id}</td>
                                    <td className="px-4 py-2">{unidad.unidad}</td>
                                    <td className="px-4 py-2">{unidad.modelo}</td>
                                    <td className="px-4 py-2">{unidad.marca}</td>
                                    <td className="px-4 py-2">{unidad.placas}</td>
                                    <td className="px-4 py-2">
                                        {unidad.tarjetaCirculacion ? (
                                            <svg
                                                xmlns="http://www.w3.org/2000/svg"
                                                fill="none"
                                                viewBox="0 0 24 24"
                                                strokeWidth="1.5"
                                                stroke="currentColor"
                                                className="w-6 h-6 mx-auto"
                                            >
                                                <path
                                                    strokeLinecap="round"
                                                    strokeLinejoin="round"
                                                    d="M3 5h18M3 5l4.5 14h9L21 5M9 10h6M9 14h6"
                                                />
                                            </svg>
                                        ) : (
                                            <span className="text-gray-500">Sin tarjeta</span>
                                        )}
                                    </td>
                                    <td className="px-4 py-2">{unidad.transportista}</td>
                                    <td className="px-4 py-2">
                                        <Button className="bg-blue-600 text-white rounded-lg px-4 py-2 hover:bg-blue-700">
                                            Ver más
                                        </Button>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </CardContent>
            </Card>
        </div>
    );
}
