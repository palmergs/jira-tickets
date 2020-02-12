// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
require.context('../images', true)

import "bootstrap";
import "@fortawesome/fontawesome-free/js/all";
import "../stylesheets/application";
import Chart from "chart.js";

$(function() {
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
});

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

      // The first dataset gets to be the left axis
      if(leftAxis === null) { leftAxis = axis; }
      else if(leftAxis != axis) { rightAxis = axis; }

      var values = sections[2];
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
    })
  });
});

