export const API_BASE_URL = process.env.NEXT_PUBLIC_API_BASE_URL || 'http://localhost:3000';

export function getAuthToken(): string | null {
  if (typeof window === 'undefined') return null;
  return localStorage.getItem('auth_token');
}

export function setAuth(token: string, user: { id: number; email: string }) {
  if (typeof window === 'undefined') return;
  localStorage.setItem('auth_token', token);
  localStorage.setItem('auth_user', JSON.stringify(user));
}

export function clearAuth() {
  if (typeof window === 'undefined') return;
  localStorage.removeItem('auth_token');
  localStorage.removeItem('auth_user');
}

export async function apiFetch(path: string, options: RequestInit = {}) {
  const headers = new Headers(options.headers);
  headers.set('Content-Type', 'application/json');
  const token = getAuthToken();
  if (token) headers.set('Authorization', `Bearer ${token}`);

  const res = await fetch(`${API_BASE_URL}${path}`, {
    ...options,
    headers,
    cache: 'no-store',
  });

  return res;
}

export async function signIn(email: string, password: string) {
  const res = await fetch(`${API_BASE_URL}/users/sign_in`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ user: { email, password } }),
  });
  if (!res.ok) {
    const data = await res.json().catch(() => ({}));
    throw new Error(data?.error || data?.errors?.join(', ') || 'Failed to sign in');
  }
  const authHeader = res.headers.get('Authorization');
  const data = await res.json();
  if (!authHeader) throw new Error('Missing token');
  const token = authHeader.replace('Bearer ', '');
  setAuth(token, data.user);
  return data.user as { id: number; email: string };
}

export async function register(email: string, password: string) {
  const res = await fetch(`${API_BASE_URL}/users`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ user: { email, password } }),
  });
  if (!res.ok) {
    const data = await res.json().catch(() => ({}));
    throw new Error(data?.error || data?.errors?.join(', ') || 'Failed to register');
  }
  const authHeader = res.headers.get('Authorization');
  const data = await res.json();
  if (!authHeader) throw new Error('Missing token');
  const token = authHeader.replace('Bearer ', '');
  setAuth(token, data.user);
  return data.user as { id: number; email: string };
}

export async function signOut() {
  const token = getAuthToken();
  await fetch(`${API_BASE_URL}/users/sign_out`, {
    method: 'DELETE',
    headers: { 'Authorization': token ? `Bearer ${token}` : '' },
  });
  clearAuth();
}

export async function createOrder(items: { product_id: number; quantity: number; price: number }[]) {
  const res = await apiFetch('/orders', {
    method: 'POST',
    body: JSON.stringify({ order: { order_items_attributes: items } }),
  });
  if (!res.ok) throw new Error('Failed to create order');
  return res.json();
}

export async function listOrders() {
  const res = await apiFetch('/orders');
  if (!res.ok) throw new Error('Failed to load orders');
  return res.json();
}

export async function getOrder(id: string) {
  const res = await apiFetch(`/orders/${id}`);
  if (!res.ok) throw new Error('Failed to load order');
  return res.json();
}

export async function createCheckoutSession(orderId: number) {
  const res = await apiFetch('/payments/checkout_session', {
    method: 'POST',
    body: JSON.stringify({ order_id: orderId }),
  });
  if (!res.ok) throw new Error('Failed to start checkout');
  return res.json();
}


