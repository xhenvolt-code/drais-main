/**
 * Device Adapter Service
 * 
 * Provides abstraction for multiple biometric device types.
 * Supports: Dahua, ZKTeco, HikVision, Generic devices
 * 
 * Phase 4: Multi-device abstraction layer
 */

import { getConnection } from '@/lib/db';

// Device types supported
export type DeviceType = 'dahua' | 'zkteco' | 'hikvision' | 'generic' | 'biometric';

// Device configuration interface
export interface DeviceConfig {
  id?: number;
  device_type: DeviceType;
  ip_address: string;
  port: number;
  api_url?: string;
  username?: string;
  password?: string;
  location?: string;
  school_id?: number;
  [key: string]: any;
}

// Device status interface
export interface DeviceStatus {
  is_online: boolean;
  last_sync: Date | null;
  logs_pending: number;
  firmware_version?: string;
  enrolled_users?: number;
  battery_level?: number;
  memory_usage?: number;
  error_message?: string;
}

// Test connection result
export interface ConnectionTestResult {
  success: boolean;
  latency_ms?: number;
  device_info?: any;
  error_message?: string;
}

// Log entry from device
export interface DeviceLog {
  device_user_id: number;
  scan_timestamp: Date;
  verification_status: 'success' | 'failed' | 'unknown';
  biometric_quality?: number;
  device_log_id?: string;
  raw_payload?: any;
}

/**
 * Base Device Adapter Interface
 * All device adapters must implement this interface
 */
export interface IDeviceAdapter {
  // Test connectivity
  testConnection(config: DeviceConfig): Promise<ConnectionTestResult>;
  
  // Fetch logs from device
  fetchLogs(config: DeviceConfig, since?: Date): Promise<DeviceLog[]>;
  
  // Get device status
  getDeviceStatus(config: DeviceConfig): Promise<DeviceStatus>;
  
  // Get device time
  getDeviceTime(config: DeviceConfig): Promise<Date>;
}

/**
 * Dahua Device Adapter
 */
export class DahuaAdapter implements IDeviceAdapter {
  async testConnection(config: DeviceConfig): Promise<ConnectionTestResult> {
    const startTime = Date.now();
    
    try {
      const protocol = config.api_url?.startsWith('https') ? 'https' : 'http';
      const baseUrl = `${protocol}://${config.ip_address}:${config.port}`;
      
      // Try to get device info
      const response = await fetch(`${baseUrl}/cgi-bin/global.cgi?action=getSystemInfo`, {
        method: 'GET',
        headers: this.getAuthHeaders(config),
        signal: AbortSignal.timeout(5000)
      });
      
      const latency = Date.now() - startTime;
      
      if (response.ok) {
        const data = await response.text();
        return {
          success: true,
          latency_ms: latency,
          device_info: this.parseDeviceInfo(data)
        };
      } else {
        return {
          success: false,
          latency_ms: latency,
          error_message: `HTTP ${response.status}: ${response.statusText}`
        };
      }
    } catch (error: any) {
      return {
        success: false,
        latency_ms: Date.now() - startTime,
        error_message: error.message
      };
    }
  }

  async fetchLogs(config: DeviceConfig, since?: Date): Promise<DeviceLog[]> {
    const protocol = config.api_url?.startsWith('https') ? 'https' : 'http';
    const baseUrl = `${protocol}://${config.ip_address}:${config.port}`;
    
    const params = new URLSearchParams({
      action: 'getRecords',
      channel: '0'
    });
    
    if (since) {
      params.append('startTime', since.toISOString());
    }
    
    const response = await fetch(`${baseUrl}/cgi-bin/attendanceRecord.cgi?${params}`, {
      method: 'GET',
      headers: this.getAuthHeaders(config),
      signal: AbortSignal.timeout(30000)
    });
    
    if (!response.ok) {
      throw new Error(`Failed to fetch logs: ${response.statusText}`);
    }
    
    const text = await response.text();
    return this.parseLogs(text);
  }

  async getDeviceStatus(config: DeviceConfig): Promise<DeviceStatus> {
    try {
      const testResult = await this.testConnection(config);
      
      return {
        is_online: testResult.success,
        last_sync: new Date(),
        logs_pending: 0,
        firmware_version: testResult.device_info?.firmwareVersion,
        error_message: testResult.error_message
      };
    } catch (error: any) {
      return {
        is_online: false,
        last_sync: null,
        logs_pending: 0,
        error_message: error.message
      };
    }
  }

  async getDeviceTime(config: DeviceConfig): Promise<Date> {
    const protocol = config.api_url?.startsWith('https') ? 'https' : 'http';
    const baseUrl = `${protocol}://${config.ip_address}:${config.port}`;
    
    const response = await fetch(`${baseUrl}/cgi-bin/system.cgi?action=getTime`, {
      method: 'GET',
      headers: this.getAuthHeaders(config),
      signal: AbortSignal.timeout(5000)
    });
    
    if (!response.ok) {
      throw new Error('Failed to get device time');
    }
    
    const data = await response.text();
    return this.parseTime(data);
  }

  private getAuthHeaders(config: DeviceConfig): HeadersInit {
    const credentials = Buffer.from(
      `${config.username || 'admin'}:${config.password || 'admin'}`
    ).toString('base64');
    
    return {
      'Authorization': `Basic ${credentials}`,
      'Content-Type': 'application/json'
    };
  }

  private parseDeviceInfo(data: string): any {
    // Parse Dahua device info response
    const lines = data.split('\n');
    const info: any = {};
    
    for (const line of lines) {
      const [key, value] = line.split('=');
      if (key && value) {
        info[key.trim()] = value.trim();
      }
    }
    
    return info;
  }

  private parseLogs(data: string): DeviceLog[] {
    // Parse Dahua attendance log format
    const logs: DeviceLog[] = [];
    const lines = data.split('\n');
    
    for (const line of lines) {
      const match = line.match(/userID=(\d+).*?time=(\S+)/i);
      if (match) {
        logs.push({
          device_user_id: parseInt(match[1]),
          scan_timestamp: new Date(match[2]),
          verification_status: 'success'
        });
      }
    }
    
    return logs;
  }

  private parseTime(data: string): Date {
    // Parse Dahua time response
    const match = data.match(/(\d{4})-(\d{2})-(\d{2})\s+(\d{2}):(\d{2}):(\d{2})/);
    if (match) {
      return new Date(
        parseInt(match[1]),
        parseInt(match[2]) - 1,
        parseInt(match[3]),
        parseInt(match[4]),
        parseInt(match[5]),
        parseInt(match[6])
      );
    }
    return new Date();
  }
}

/**
 * Generic/Standard Device Adapter
 * Works with any device that supports standard REST API
 */
export class GenericAdapter implements IDeviceAdapter {
  async testConnection(config: DeviceConfig): Promise<ConnectionTestResult> {
    const startTime = Date.now();
    
    try {
      const baseUrl = `${config.ip_address}:${config.port}`;
      
      const response = await fetch(baseUrl, {
        method: 'GET',
        signal: AbortSignal.timeout(5000)
      });
      
      return {
        success: response.ok,
        latency_ms: Date.now() - startTime,
        error_message: response.ok ? undefined : `HTTP ${response.status}`
      };
    } catch (error: any) {
      return {
        success: false,
        latency_ms: Date.now() - startTime,
        error_message: error.message
      };
    }
  }

  async fetchLogs(config: DeviceConfig, since?: Date): Promise<DeviceLog[]> {
    // Generic implementation - should be customized per device
    throw new Error('Generic adapter: implement fetchLogs for your specific device');
  }

  async getDeviceStatus(config: DeviceConfig): Promise<DeviceStatus> {
    const testResult = await this.testConnection(config);
    
    return {
      is_online: testResult.success,
      last_sync: testResult.success ? new Date() : null,
      logs_pending: 0,
      error_message: testResult.error_message
    };
  }

  async getDeviceTime(config: DeviceConfig): Promise<Date> {
    return new Date();
  }
}

/**
 * Device Adapter Factory
 * Returns the appropriate adapter based on device type
 */
export class DeviceAdapterFactory {
  private static adapters: Map<DeviceType, IDeviceAdapter> = new Map();
  
  static getAdapter(deviceType: DeviceType): IDeviceAdapter {
    // Return cached adapter or create new one
    switch (deviceType) {
      case 'dahua':
        if (!this.adapters.has('dahua')) {
          this.adapters.set('dahua', new DahuaAdapter());
        }
        return this.adapters.get('dahua')!;
        
      case 'zkteco':
      case 'hikvision':
      case 'generic':
      case 'biometric':
      default:
        if (!this.adapters.has('generic')) {
          this.adapters.set('generic', new GenericAdapter());
        }
        return this.adapters.get('generic')!;
    }
  }
  
  // Get all supported device types
  static getSupportedTypes(): DeviceType[] {
    return ['dahua', 'zkteco', 'hikvision', 'generic', 'biometric'];
  }
}

/**
 * Device Service - High-level operations
 * Manages device registry and coordinates operations
 */
export class DeviceService {
  /**
   * Test connection to a device
   */
  static async testDevice(config: DeviceConfig): Promise<ConnectionTestResult> {
    const adapter = DeviceAdapterFactory.getAdapter(config.device_type);
    return adapter.testConnection(config);
  }
  
  /**
   * Get device status
   */
  static async getDeviceStatus(deviceId: number): Promise<DeviceStatus> {
    const config = await this.getDeviceConfig(deviceId);
    if (!config) {
      throw new Error(`Device ${deviceId} not found`);
    }
    
    const adapter = DeviceAdapterFactory.getAdapter(config.device_type);
    return adapter.getDeviceStatus(config);
  }
  
  /**
   * Fetch and process logs from a device
   */
  static async syncDeviceLogs(deviceId: number): Promise<number> {
    const config = await this.getDeviceConfig(deviceId);
    if (!config) {
      throw new Error(`Device ${deviceId} not found`);
    }
    
    const adapter = DeviceAdapterFactory.getAdapter(config.device_type);
    const logs = await adapter.fetchLogs(config);
    
    // Process and store logs
    let processed = 0;
    const connection = await getConnection();
    
    try {
      for (const log of logs) {
        await this.processLog(connection, config, log);
        processed++;
      }
      
      // Update sync checkpoint
      await this.updateCheckpoint(connection, deviceId);
      
      return processed;
    } finally {
      await connection.end();
    }
  }
  
  /**
   * Get device configuration from database
   */
  private static async getDeviceConfig(deviceId: number): Promise<DeviceConfig | null> {
    const connection = await getConnection();
    
    try {
      const [rows] = await connection.execute(
        `SELECT * FROM biometric_devices WHERE id = ?`,
        [deviceId]
      );
      
      const devices = rows as any[];
      if (devices.length === 0) {
        return null;
      }
      
      const device = devices[0];
      return {
        id: device.id,
        device_type: device.device_type as DeviceType,
        ip_address: device.ip_address,
        port: device.port,
        api_url: device.api_url,
        username: device.username,
        password: device.password,
        location: device.location,
        school_id: device.school_id
      };
    } finally {
      await connection.end();
    }
  }
  
  /**
   * Process a single log entry
   */
  private static async processLog(
    connection: any, 
    config: DeviceConfig, 
    log: DeviceLog
  ): Promise<void> {
    // Check for duplicate (idempotency)
    const [existing] = await connection.execute(
      `SELECT id FROM attendance_logs 
       WHERE device_id = ? AND user_id = ? AND event_time = ? 
       LIMIT 1`,
      [config.id, log.device_user_id, log.scan_timestamp]
    );
    
    if (existing && (existing as any[]).length > 0) {
      return; // Skip duplicate
    }
    
    // Insert log
    await connection.execute(
      `INSERT INTO attendance_logs 
       (student_id, device_id, event_type, event_time, verification_status, raw_data)
       VALUES (?, ?, 'check_in', ?, ?, ?)`,
      [
        log.device_user_id,
        config.id,
        log.scan_timestamp,
        log.verification_status,
        JSON.stringify(log.raw_payload)
      ]
    );
  }
  
  /**
   * Update sync checkpoint
   */
  private static async updateCheckpoint(connection: any, deviceId: number): Promise<void> {
    await connection.execute(
      `INSERT INTO device_sync_checkpoints (device_id, last_sync_time, records_synced)
       VALUES (?, NOW(), 1)
       ON DUPLICATE KEY UPDATE last_sync_time = NOW()`,
      [deviceId]
    );
  }
}

export default DeviceService;
