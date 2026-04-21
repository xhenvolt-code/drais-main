export const fetcher = async <T = unknown>(url: string): Promise<T> => {
  const response = await fetch(url);
  
  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
  }
  
  const data = await response.json();
  return data as T;
};

export default fetcher;
