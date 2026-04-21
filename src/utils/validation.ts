export interface ValidationRule {
  required?: boolean;
  minLength?: number;
  maxLength?: number;
  pattern?: RegExp;
  custom?: (value: string) => string | null;
}

export interface ValidationRules {
  [key: string]: ValidationRule;
}

export interface ValidationErrors {
  [key: string]: string;
}

export function validateForm<T extends Record<string, unknown>>(
  data: T,
  rules: ValidationRules
): { isValid: boolean; errors: ValidationErrors } {
  const errors: ValidationErrors = {};

  for (const [field, rule] of Object.entries(rules)) {
    const value = data[field];
    const stringValue = String(value || '').trim();

    // Required validation
    if (rule.required && !stringValue) {
      errors[field] = `${formatFieldName(field)} is required`;
      continue;
    }

    // Skip other validations if field is empty and not required
    if (!stringValue && !rule.required) {
      continue;
    }

    // Min length validation
    if (rule.minLength && stringValue.length < rule.minLength) {
      errors[field] = `${formatFieldName(field)} must be at least ${rule.minLength} characters`;
      continue;
    }

    // Max length validation
    if (rule.maxLength && stringValue.length > rule.maxLength) {
      errors[field] = `${formatFieldName(field)} must be no more than ${rule.maxLength} characters`;
      continue;
    }

    // Pattern validation
    if (rule.pattern && !rule.pattern.test(stringValue)) {
      errors[field] = `${formatFieldName(field)} format is invalid`;
      continue;
    }

    // Custom validation
    if (rule.custom) {
      const customError = rule.custom(stringValue);
      if (customError) {
        errors[field] = customError;
      }
    }
  }

  return {
    isValid: Object.keys(errors).length === 0,
    errors
  };
}

function formatFieldName(field: string): string {
  return field
    .split('_')
    .map(word => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ');
}

// Common validation rules
export const commonValidationRules = {
  email: {
    pattern: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
    custom: (value: string) => {
      if (value && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value)) {
        return 'Please enter a valid email address';
      }
      return null;
    }
  },
  phone: {
    pattern: /^[0-9+\-\s()]+$/,
    custom: (value: string) => {
      if (value && !/^[0-9+\-\s()]+$/.test(value)) {
        return 'Please enter a valid phone number';
      }
      return null;
    }
  },
  name: {
    minLength: 2,
    maxLength: 100,
    pattern: /^[a-zA-Z\s]+$/,
    custom: (value: string) => {
      if (value && !/^[a-zA-Z\s]+$/.test(value)) {
        return 'Name should only contain letters and spaces';
      }
      return null;
    }
  }
};

// Student-specific validation rules
export const studentValidationRules: ValidationRules = {
  first_name: {
    required: true,
    ...commonValidationRules.name
  },
  last_name: {
    required: true,
    ...commonValidationRules.name
  },
  email: {
    ...commonValidationRules.email
  },
  phone: {
    ...commonValidationRules.phone
  },
  admission_no: {
    maxLength: 50,
    pattern: /^[a-zA-Z0-9\-_]+$/,
    custom: (value: string) => {
      if (value && !/^[a-zA-Z0-9\-_]+$/.test(value)) {
        return 'Admission number should only contain letters, numbers, hyphens, and underscores';
      }
      return null;
    }
  },
  notes: {
    maxLength: 500
  }
};