export default function Formulario() {
    return (
        <section className="min-h-screen px-6 py-12 md:px-24 md:py-20 bg-white">
            <h3 className="text-2xl md:text-4xl font-bold text-blue-800 mb-6">Planea tu siguiente envío!</h3>
            <h2 className="text-3xl font-bold text-blue-800 mb-4">Formulario</h2>
            <form className="space-y-6">
                <div className="grid md:grid-cols-2 gap-6">
                    <input type="text" placeholder="Nombre" className="p-4 border rounded" />
                    <input type="email" placeholder="Email" className="p-4 border rounded" />
                </div>

                <div className="flex flex-col md:flex-row items-center gap-4">
                    <label className="flex items-center gap-2">
                        <input type="radio" name="tipoUsuario" value="cliente" className="cursor-pointer" />
                        Cliente
                    </label>
                    <label className="flex items-center gap-2">
                        <input type="radio" name="tipoUsuario" value="transportista" className="cursor-pointer" />
                        Transportista
                    </label>
                </div>

                <textarea placeholder="Mensaje" className="p-4 border rounded w-full"></textarea>
                <button type="submit" className="px-6 py-2 bg-blue-700 text-white rounded hover:bg-blue-800 transition-all">
                    Enviar
                </button>
            </form>
        </section>
    );
}
