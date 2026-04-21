import React from 'react';
import clsx from 'clsx';

const Button = ({ children, onClick, variant = 'primary', icon, loading, ...props }) => {
  const baseStyles =
    'inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-offset-2';
  const variants = {
    primary: 'bg-indigo-600 text-white hover:bg-indigo-700 focus:ring-indigo-500',
    secondary: 'bg-gray-100 text-gray-700 hover:bg-gray-200 focus:ring-gray-500',
    danger: 'bg-red-600 text-white hover:bg-red-700 focus:ring-red-500',
  };

  return (
    <button
      onClick={onClick}
      className={clsx(baseStyles, variants[variant], { 'opacity-50 cursor-not-allowed': loading })}
      {...props}
    >
      {loading ? (
        <span className="loader" />
      ) : (
        <>
          {icon && <span className="mr-2">{icon}</span>}
          {children}
        </>
      )}
    </button>
  );
};

export default Button;
