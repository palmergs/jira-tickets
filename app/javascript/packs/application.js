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
import _ from "lodash";

$(function() {
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
});

$(function() {
  $('[data-chart="bar"]').each(function() {

    var ctx = this.getContext('2d');
    var labels = $(this).data('labels').toString().split(',');
    var values = $(this).data('values').toString().split(',').map(function(x) { return parseInt(x);})
    console.log(values);
    var obj = {
      // The type of chart we want to create
      type: 'bar',

      // The data for our dataset
      data: {
          labels: labels,
          datasets: [{
              label: 'Priorities',
              backgroundColor: 'rgb(255, 99, 132)',
              borderColor: 'rgb(255, 99, 132)',
              data: values
          }]
      },

      // Configuration options go here
      options: {}
    };
    console.log(obj);
    new Chart(ctx, obj);
  });
})
