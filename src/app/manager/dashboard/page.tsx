'use client'

import Button from "@/components/ui/button";
import Card from "@/components/ui/card";
import CardContent from "@/components/ui/card-content";

import { useRouter } from 'next/navigation'

export default function Dashboard() {

    const router = useRouter();

    return (
        <div className="p-8 bg-gray-100 min-h-screen">
            <div className="flex justify-between items-center mb-8">
                <h1 className="text-4xl font-bold text-gray-900">Hola Manager</h1>
                <Button className="bg-blue-700 text-white">Invitar a transportista</Button>
            </div>

            <div className="grid grid-cols-4 gap-6 mb-8">
            <Card>
                <CardContent className="text-center" onClick={() => router.push('/manager/units')}>
                    <div className="text-4xl mb-2">10</div>
                    <div className="flex justify-center mb-2">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" className="w-16 h-16 text-blue-700">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 18.75a1.5 1.5 0 0 1-3 0m3 0a1.5 1.5 0 0 0-3 0m3 0h6m-9 0H3.375a1.125 1.125 0 0 1-1.125-1.125V14.25m17.25 4.5a1.5 1.5 0 0 1-3 0m3 0a1.5 1.5 0 0 0-3 0m3 0h1.125c.621 0 1.129-.504 1.09-1.124a17.902 17.902 0 0 0-3.213-9.193 2.056 2.056 0 0 0-1.58-.86H14.25M16.5 18.75h-2.25m0-11.177v-.958c0-.568-.422-1.048-.987-1.106a48.554 48.554 0 0 0-10.026 0 1.106 1.106 0 0 0-.987 1.106v7.635m12-6.677v6.677m0 4.5v-4.5m0 0h-12" />
                        </svg>
                    </div>
                    <div className="text-gray-500">Unidades</div>
                </CardContent>
            </Card>

                <Card>
                    <CardContent className="text-center">
                        <div className="text-4xl mb-2">10</div>
                        <div className="flex justify-center mb-2">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" className="w-16 h-16 text-blue-700">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M17.982 18.725A7.488 7.488 0 0 0 12 15.75a7.488 7.488 0 0 0-5.982 2.975m11.963 0a9 9 0 1 0-11.963 0m11.963 0A8.966 8.966 0 0 1 12 21a8.966 8.966 0 0 1-5.982-2.275M15 9.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                        </svg>
                        </div>
                        <div className="text-gray-500">Transportistas</div>
                    </CardContent>
                </Card>

                <Card>
                    <CardContent className="text-center">
                        <div className="text-4xl mb-2">100</div>
                        <div className="flex justify-center mb-2">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" className="w-16 h-16 text-blue-700">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 12c0-1.232-.046-2.453-.138-3.662a4.006 4.006 0 0 0-3.7-3.7 48.678 48.678 0 0 0-7.324 0 4.006 4.006 0 0 0-3.7 3.7c-.017.22-.032.441-.046.662M19.5 12l3-3m-3 3-3-3m-12 3c0 1.232.046 2.453.138 3.662a4.006 4.006 0 0 0 3.7 3.7 48.656 48.656 0 0 0 7.324 0 4.006 4.006 0 0 0 3.7-3.7c.017-.22.032-.441.046-.662M4.5 12l3 3m-3-3-3 3" />
                        </svg>
                        </div>
                        <div className="text-gray-500">Entregas Completas</div>
                    </CardContent>
                </Card>
                <Card>
                    <CardContent className="text-center">
                        <div className="text-4xl mb-2">10</div>
                        <div className="flex justify-center mb-2">

                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" className="w-16 h-16 text-blue-700">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M6.75 2.994v2.25m10.5-2.25v2.25m-14.252 13.5V7.491a2.25 2.25 0 0 1 2.25-2.25h13.5a2.25 2.25 0 0 1 2.25 2.25v11.251m-18 0a2.25 2.25 0 0 0 2.25 2.25h13.5a2.25 2.25 0 0 0 2.25-2.25m-18 0v-7.5a2.25 2.25 0 0 1 2.25-2.25h13.5a2.25 2.25 0 0 1 2.25 2.25v7.5m-6.75-6h2.25m-9 2.25h4.5m.002-2.25h.005v.006H12v-.006Zm-.001 4.5h.006v.006h-.006v-.005Zm-2.25.001h.005v.006H9.75v-.006Zm-2.25 0h.005v.005h-.006v-.005Zm6.75-2.247h.005v.005h-.005v-.005Zm0 2.247h.006v.006h-.006v-.006Zm2.25-2.248h.006V15H16.5v-.005Z" />
                        </svg>
                        </div>

                        <div className="text-gray-500">Entregas en Proceso</div>
                    </CardContent>
                </Card>
            </div>

            <div className="bg-white p-6 rounded-xl shadow-sm mb-8">
                <h2 className="text-2xl font-bold text-gray-900 mb-4">Comportamiento de Entregas</h2>
                {/* Aquí puedes agregar tu gráfico */}
            </div>

            <div className="bg-white p-6 rounded-xl shadow-sm">
                <h2 className="text-2xl font-bold text-gray-900 mb-4">Historial de Órdenes</h2>
                <table className="w-full text-left">
                    <thead>
                        <tr>
                            <th className="border-b p-2">#ID</th>
                            <th className="border-b p-2">Transportista</th>
                            <th className="border-b p-2">Fecha de Creación</th>
                            <th className="border-b p-2">Fecha de Entrega</th>
                            <th className="border-b p-2">Estatus</th>
                            <th className="border-b p-2">Cliente</th>
                            <th className="border-b p-2">Destino</th>
                            <th className="border-b p-2">Origen</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td className="border-b p-2">24324</td>
                            <td className="border-b p-2">Daniel Alvarado</td>
                            <td className="border-b p-2">20 de Marzo, 2025</td>
                            <td className="border-b p-2">20 de Marzo, 2025</td>
                            <td className="border-b p-2 bg-yellow-100 text-yellow-700">En Camino</td>
                            <td className="border-b p-2">Pablo Vazquez</td>
                            <td className="border-b p-2">Ciudad Juarez 344</td>
                            <td className="border-b p-2">Ciudad Juarez 344</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    );
}
