/**
 * Format currency with proper thousand separators and decimal places
 */
export const formatCurrency = (
  amount: number | string, 
  currency: string = 'UGX', 
  locale: string = 'en-UG'
): string => {
  const numericAmount = typeof amount === 'string' ? parseFloat(amount) : amount;
  
  if (isNaN(numericAmount)) {
    return `${currency} 0.00`;
  }

  // For UGX, typically no decimal places are shown
  const decimals = currency === 'UGX' ? 0 : 2;
  
  try {
    return new Intl.NumberFormat(locale, {
      style: 'currency',
      currency: currency === 'UGX' ? 'USD' : currency, // Fallback since UGX might not be supported
      minimumFractionDigits: decimals,
      maximumFractionDigits: decimals
    }).format(numericAmount).replace('$', currency);
  } catch {
    // Fallback formatting
    return `${currency} ${numericAmount.toLocaleString('en-US', {
      minimumFractionDigits: decimals,
      maximumFractionDigits: decimals
    })}`;
  }
};

/**
 * Format number with thousand separators
 */
export const formatNumber = (num: number | string, decimals: number = 0): string => {
  const numericValue = typeof num === 'string' ? parseFloat(num) : num;
  
  if (isNaN(numericValue)) {
    return '0';
  }

  return numericValue.toLocaleString('en-US', {
    minimumFractionDigits: decimals,
    maximumFractionDigits: decimals
  });
};

/**
 * Parse and clean currency input
 */
export const parseCurrency = (value: string): number => {
  // Remove currency symbols, spaces, and commas
  const cleaned = value.replace(/[^\d.-]/g, '');
  const parsed = parseFloat(cleaned);
  return isNaN(parsed) ? 0 : parsed;
};
