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

$(document).on('turbolinks:load', function() {
  // console.log("in turbolinks:load...")
  $('[data-chart="bar"]').each(function() {

    // console.log("in canvas each..."+ this);
    const ctx = this.getContext('2d');
    const labels = $(this).data('labels').toString().split(",");
    const values = $(this).data('values').toString().split(",").map(function(val) { return parseInt(val); });
    const title = $(this).attr('title').toString();
    const backgrounds = [
      'rgba(255, 99, 132, 0.2)',
      'rgba(54, 162, 235, 0.2)',
      'rgba(255, 206, 86, 0.2)',
      'rgba(75, 192, 192, 0.2)',
      'rgba(153, 102, 255, 0.2)',
      'rgba(255, 159, 64, 0.2)'
    ].slice(0, values.length);

    const borders = [
      'rgba(255, 99, 132, 1)',
      'rgba(54, 162, 235, 1)',
      'rgba(255, 206, 86, 1)',
      'rgba(75, 192, 192, 1)',
      'rgba(153, 102, 255, 1)',
      'rgba(255, 159, 64, 1)'
    ].slice(0, values.length);


    // console.log(ctx);

    // $(this).addClass('with-border');
    const chart = new Chart(ctx, {
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
        legend: {
          display: false
        },
        scales: {
          yAxes: [{
            ticks: {
              beginAtZero: true
            }
          }]
        }
      }
    });
    console.log(chart);
  });
});

