import axios from 'axios';

const GHL_BASE_URL = 'https://services.leadconnectorhq.com';
const GHL_VERSION = '2021-07-28';

export const ghlClient = axios.create({
  baseURL: GHL_BASE_URL,
  headers: {
    Authorization: `Bearer ${process.env.GHL_API_KEY}`,
    Version: GHL_VERSION,
    'Content-Type': 'application/json',
  },
});

export const LOCATION_ID = process.env.GHL_LOCATION_ID!;
