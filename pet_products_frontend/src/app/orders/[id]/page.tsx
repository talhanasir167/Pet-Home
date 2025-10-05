import { API_BASE_URL, getAuthToken } from '../../lib/api'

async function fetchOrder(id: string) {
  const headers: any = { 'Content-Type': 'application/json' }
  const token = typeof window !== 'undefined' ? getAuthToken() : null
  if (token) headers['Authorization'] = `Bearer ${token}`
  const res = await fetch(`${API_BASE_URL}/orders/${id}`, { headers, cache: 'no-store' })
  if (!res.ok) throw new Error('Failed to load order')
  return res.json()
}

export default async function OrderDetailPage({ params }: { params: { id: string } }) {
  const data = await fetchOrder(params.id)
  const order = data.order || data
  return (
    <div className="container mx-auto p-8">
      <h1 className="text-3xl font-bold mb-4">Order #{order.id}</h1>
      <p className="mb-4">Status: {order.status}</p>
      <p className="mb-4">Total: ${order.total_amount}</p>
      <h2 className="text-xl font-semibold mb-2">Items</h2>
      <ul className="space-y-2">
        {order.items?.map((it: any) => (
          <li key={it.id} className="border p-2">
            {it.product?.name} × {it.quantity} — ${it.price}
          </li>
        ))}
      </ul>
    </div>
  )
}


