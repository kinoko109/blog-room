'use client'

import useSWR from 'swr'
import { fetcher } from '../lib/utils'
import Error from './error'

const url = 'http://localhost:3000/api/v1/health_check'

export default function Home() {
  const { data, error, isLoading } = useSWR(url, fetcher)

  if (error) return <Error />
  if (isLoading) return <div>...loading</div>
  console.log('data', data)

  return (
    <div>
      Rails 疎通確認
      <div>response: {data.message}</div>
    </div>
  )
}
