const medidas = [0, 0, 0, 0, 0]
let indice = 0;
const compareDate = new Date()

setInterval(async () => {
  const response = await requestSerialData()
  const { leitura } = await response.json()
  medidas[indice] = parseInt(leitura)
  indice++
  if (indice > 4) {
    indice = 0
  }
  const mediaMovel = (medidas.reduce((acc, el) => acc + el)) / medidas.length
  const tensao = (((mediaMovel / 1023.0) * 5))
  updateChart(tensao)
}, 20)

function requestSerialData() {
  return fetch('http://localhost:3030/leitura-ad')
}