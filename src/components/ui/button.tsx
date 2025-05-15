export default function Button({ children, className, ...props }: React.ButtonHTMLAttributes<HTMLButtonElement>) {
  return (
    <button
      className={`px-4 py-2 rounded-md font-semibold text-white bg-blue-700 hover:bg-blue-800 transition duration-200 ${className}`}
      {...props}
    >
      {children}
    </button>
  );
}