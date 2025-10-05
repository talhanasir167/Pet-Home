'use client'

import { useEffect, useState } from 'react'
import { listOrders } from '../lib/api'
import Link from 'next/link'

export default function OrdersPage() {
  const [orders, setOrders] = useState<any[]>([])
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    listOrders().then(data => setOrders(data.orders || [])).catch(e => setError(e.message || 'Error'))
  }, [])

  return (
    <div className="container mx-auto p-8">
      <h1 className="text-3xl font-bold mb-4">My Orders</h1>
      {error && <p className="text-red-600">{error}</p>}
      <ul className="space-y-3">
        {orders.map((o) => (
          <li key={o.id} className="border p-3">
            <div className="flex justify-between">
              <div>Order #{o.id} — {o.status} — ${o.total_amount}</div>
              <Link className="underline" href={`/orders/${o.id}`}>View</Link>
            </div>
          </li>
        ))}
      </ul>
    </div>
  )
}


