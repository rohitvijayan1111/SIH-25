// services/api.js
import axios from 'axios';

// Create a configured axios instance
const api = axios.create({
  baseURL: 'http://localhost:5000', // Base URL used in every request
  headers: {
    'Content-Type': 'application/json',
  },
});

// Optional: handle common error messages
api.interceptors.response.use(
  (response) => response,
  (error) => {
    console.error('API error:', error.message);
    return Promise.reject(error);
  }
);

export default api;
