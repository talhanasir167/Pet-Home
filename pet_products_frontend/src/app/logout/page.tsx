'use client'

import { useEffect } from 'react'
import { signOut } from '../lib/api'
import { useRouter } from 'next/navigation'

export default function LogoutPage() {
  const router = useRouter()
  useEffect(() => {
    signOut().finally(() => router.replace('/'))
  }, [router])
  return <p style={{ padding: 24 }}>Signing out...</p>
}


