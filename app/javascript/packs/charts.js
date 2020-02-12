import Chart from "chart.js";

const BACKGROUNDS = [
  'rgba(255, 99, 132, 0.2)',
  'rgba(54, 162, 235, 0.2)',
  'rgba(255, 206, 86, 0.2)',
  'rgba(75, 192, 192, 0.2)',
  'rgba(153, 102, 255, 0.2)',
  'rgba(255, 159, 64, 0.2)'
];

const BORDERS = [
  'rgba(255, 99, 132, 1)',
  'rgba(54, 162, 235, 1)',
  'rgba(255, 206, 86, 1)',
  'rgba(75, 192, 192, 1)',
  'rgba(153, 102, 255, 1)',
  'rgba(255, 159, 64, 1)'
];

$(document).on('turbolinks:load', function() {
  $('[data-chart="bar"]').each(function() {
    const ctx = this.getContext('2d');
    const labels = $(this).data('labels').toString().split(",");
    const values = $(this).data('values').toString().split(",").map(function(val) { return parseInt(val); });
    const title = $(this).attr('title').toString();
    const backgrounds = BACKGROUNDS.slice(0, values.length);
    const borders = BORDERS.slice(0, values.length);

    new Chart(ctx, {
      type: 'bar',
      data: {
        labels: labels,
        datasets: [{
          data: values,
          backgroundColor: backgrounds,
          borderColor: borders,
          borderWidth: 1
        }]
      },
      options: {
        title: {
          display: true,
          text: title
        },
        legend: { display: false },
        scales: {
          yAxes: [{
            ticks: { beginAtZero: true }
          }]
        }
      }
    });
  });

  $('[data-chart="pie"]').each(function() {
    const ctx = this.getContext('2d');
    const labels = $(this).data('labels').toString().split(",");
    const values = $(this).data('values').toString().split(",").map(function(val) { return parseInt(val); });
    const title = $(this).attr('title').toString();
    const backgrounds = BACKGROUNDS.slice(0, values.length);
    const borders = BORDERS.slice(0, values.length);

    new Chart(ctx, {
      type: 'pie',
      data: {
        labels: labels,
        datasets: [{
          data: values,
          backgroundColor: backgrounds,
          borderColor: borders,
          borderWidth: 1
        }]
      },
      options: {
        title: {
          display: true,
          text: title
        },
        legend: { display: true }
      }
    });
  });

  // <canvas title="test"
  //     data-chart="stacked" data-labels="a,b"
  //     data-count="2" data-set0="Label:1,2,3" data-set1="Label:1,2,3">
  $('[data-chart="stacked"]').each(function() {
    const ctx = this.getContext('2d');
    const labels = $(this).data('labels').toString().split(",");
    const count = parseInt($(this).data('count'));
    const title = $(this).attr('title').toString();
    const datasets = new Array(count);

    for(let i = 0; i < count; ++i) {
      var data = $(this).data('set'+ i);
      var sections = data.split(':');
      var label = sections[0];
      var values = sections[1];
      datasets[i] = {
        label: label,
        borderColor: BORDERS[i],
        backgroundColor: BACKGROUNDS[i],
        borderWidth: 1,
        data: values.split(',').map(function(val) { return parseInt(val); })
      }
    }

    new Chart(ctx, {
      type: 'bar',
      data: {
        labels: labels,
        datasets: datasets
      },
      options: {
        maintainAspectRatio: false,
        title: {
          display: true,
          text: title
        },
        scales: {
          xAxes: [{ stacked: true }],
          yAxes: [{ stacked: true }]
        }
      }
    });
  });

  // <canvas title="test"
  //     data-chart="multi-axis" data-labels="a,b"
  //     data-count="2" data-set0="Label:axis1:1,2,3" data-set1="Label:axis2:3,2,1">
  $('[data-chart="multi-axis"]').each(function() {
    const ctx = this.getContext('2d');
    const labels = $(this).data('labels').toString().split(",");
    const count = parseInt($(this).data('count'));
    const title = $(this).attr('title').toString();
    const datasets = new Array(count);

    let leftAxis = null;
    let rightAxis = null;
    for(let i = 0; i < count; ++i) {
      var data = $(this).data('set'+ i);
      var sections = data.split(':');
      var label = sections[0];
      var axis = sections[1];
      var values = sections[2];

      // The first dataset gets to be the left axis
      if(leftAxis === null) { leftAxis = axis; }
      else if(leftAxis != axis) { rightAxis = axis; }

      datasets[i] = {
        label: label,
        borderColor: BORDERS[i],
        backgroundColor: BACKGROUNDS[i],
        fill: false,
        data: values.split(',').map(function(val) { return parseInt(val); }),
        yAxisID: axis
      }

      // To distinguish the lines; the datasets for the left axis
      // use the default line smoothing; the other datasets
      // use straight lines
      if(axis != leftAxis) { datasets[i].lineTension = 0; }
    }

    new Chart.Line(ctx, {
      data: {
        labels: labels,
        datasets: datasets
      },
      options: {
        maintainAspectRatio: false,
        title: {
          display: true,
          text: title
        },
        stacked: false,
        scales: {
          yAxes: [
            {
              type: 'linear',
              display: true,
              position: 'left',
              id: leftAxis
            },
            {
              type: 'linear',
              display: true,
              position: 'right',
              id: rightAxis,
              gridLines: { drawOnChartArea: false }
            },
          ]
        }
      }
    });
  });
});
