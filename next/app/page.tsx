import useSWR from 'swr'
import { fetcher } from '../lib/utils'
import Error from './error'

const url = 'http://localhost:3000/api/v1/health_check'

export default function Home() {
  const { data, error } = useSWR(url, fetcher)

  if (!data) return <Error />

  return (
    <div>
      Rails 疎通確認
      <div>response: {data.message}</div>
    </div>
  )
}
