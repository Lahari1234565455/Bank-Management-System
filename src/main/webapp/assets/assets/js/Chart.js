// Bar Chart
const barCtx = document.getElementById('barChart').getContext('2d');
new Chart(barCtx, {
  type: 'bar',
  data: {
    labels: ['Math', 'Science', 'Java', 'Python'],
    datasets: [{
      label: 'Attendance Per Subject',
      data: [0.9, 0.8, 0.85, 0.88],
      backgroundColor: '#f39c12'
    }]
  },
  options: {
    scales: {
      y: { beginAtZero: true }
    }
  }
});

// Pie Chart
const pieCtx = document.getElementById('pieChart').getContext('2d');
new Chart(pieCtx, {
  type: 'pie',
  data: {
    labels: ['Students', 'Staff'],
    datasets: [{
      data: [50, 50],
      backgroundColor: ['#2980b9', '#e74c3c']
    }]
  }
});
