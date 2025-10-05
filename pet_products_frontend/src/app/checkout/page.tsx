"use client";

import { useState } from "react";
import { createOrder, createCheckoutSession } from "../lib/api";

export default function CheckoutPage() {
  const [items, setItems] = useState<Array<{ product_id: number; quantity: number; price: number }>>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function handleCheckout() {
    setLoading(true);
    setError(null);
    try {
      const { order } = await createOrder(items);
      const session = await createCheckoutSession(order.id);
      if (session.url) {
        window.location.href = session.url;
      }
    } catch (e: any) {
      setError(e.message || "Checkout failed");
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="container mx-auto p-8">
      <h1 className="text-3xl font-bold mb-4">Checkout</h1>
      <p className="mb-4">Add items and proceed to Stripe.</p>
      <button className="px-4 py-2 bg-black text-white" onClick={handleCheckout} disabled={loading}>
        {loading ? "Processing..." : "Checkout"}
      </button>
      {error && <p className="text-red-600 mt-2">{error}</p>}
    </div>
  );
}