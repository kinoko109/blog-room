// type FetcherParam = {
//   url: string
// }

export const fetcher = (url: string) => {
  fetch(url)
    .then((response) => {
      if (!response.ok) {
        throw new Error()
      }
      return response.json()
    })
    .catch((error) => {
      throw new Error(error)
    })
}
