export default function Card({ children, className, ...props }: React.HTMLAttributes<HTMLDivElement>) {
    return (
        <div
        className={`bg-white shadow-md rounded-lg p-6 ${className}`}
        {...props}
        >
        {children}
        </div>
    );
    }