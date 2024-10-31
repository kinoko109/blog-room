// type FetcherParam = {
//   url: string
// }
export const fetcher = async (url: string) => {
  return await fetch(url)
    .then((response) => {
      if (!response.ok) {
        console.log(response)
        throw new Error()
      }
      return response.json()
    })
    .catch((error) => {
      console.log(error)
      throw new Error(error)
    })
}
