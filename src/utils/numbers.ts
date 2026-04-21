export function formatToWords(num: number): string {
  const ones = ['', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'];
  const tens = ['', '', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety'];
  const teens = ['ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen'];

  function convertLessThanThousand(n: number): string {
    if (n === 0) return '';
    
    if (n < 10) return ones[n];
    if (n < 20) return teens[n - 10];
    if (n < 100) {
      return tens[Math.floor(n / 10)] + (n % 10 ? '-' + ones[n % 10] : '');
    }
    return ones[Math.floor(n / 100)] + ' hundred' + (n % 100 ? ' and ' + convertLessThanThousand(n % 100) : '');
  }

  if (num === 0) return 'zero';

  const [whole, decimal] = num.toFixed(2).split('.');
  let result = '';
  
  const billions = Math.floor(parseInt(whole) / 1000000000);
  const millions = Math.floor((parseInt(whole) % 1000000000) / 1000000);
  const thousands = Math.floor((parseInt(whole) % 1000000) / 1000);
  const remainder = parseInt(whole) % 1000;

  if (billions) result += convertLessThanThousand(billions) + ' billion ';
  if (millions) result += convertLessThanThousand(millions) + ' million ';
  if (thousands) result += convertLessThanThousand(thousands) + ' thousand ';
  if (remainder) result += convertLessThanThousand(remainder);

  result = result.trim() + ' shillings';
  if (decimal !== '00') {
    result += ' and ' + decimal + ' cents';
  }

  return result.charAt(0).toUpperCase() + result.slice(1);
}
