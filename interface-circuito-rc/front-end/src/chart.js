const ctx = document.getElementById('draw-on-me').getContext('2d')
  let arr = []
  let timeArray = []
  const myChart = new Chart(ctx, {
    type: 'line', 
    data: {
      labels: timeArray,      // Dados no eixo x
        datasets: [{
            label: 'Tensão',
            data: arr,        // Dados no eixo y
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)'
            ],
            borderWidth: 1,
            fill: false,
            borderColor: '#0000D1',
            pointRadius: 0,
        }]
    },
})

const updateChart = (tensao) => {
  const time = (Math.abs(new Date() - compareDate) / 1000)
  timeArray.push(time)
  arr.push(tensao)
  myChart.update()
}
