export async function fetchData(query) {
  const response = await fetch('http://localhost:8000/api/query',
    {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ query: query })
    }
  )
  const data = await response.json()
  return data.results
}