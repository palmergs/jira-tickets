# frozen_string_literal: true

module Sprints
  extend ActiveSupport::Concern

  SPRINTS = {
    2019 => {
      1 => [
        Date.new(2018, 12, 31),
        Date.new(2019, 1, 14),
        Date.new(2019, 2, 4),
        Date.new(2019, 2, 18),
        Date.new(2019, 3, 4),
        Date.new(2019, 3, 18)
      ],
      2 => [
        Date.new(2019, 4, 1),
        Date.new(2019, 4, 15),
        Date.new(2019, 4, 29),
        Date.new(2019, 5, 13),
        Date.new(2019, 5, 27),
        Date.new(2019, 6, 10)
      ], 
      3 => [
        Date.new(2019, 7, 1),
        Date.new(2019, 7, 15),
        Date.new(2019, 7, 29),
        Date.new(2019, 8, 12),
        Date.new(2019, 8, 26),
        Date.new(2019, 9, 9)
      ],
      4 => [
        Date.new(2019, 9, 30),
        Date.new(2019, 10, 14),
        Date.new(2019, 10, 28),
        Date.new(2019, 11, 11),
        Date.new(2019, 11, 25),
        Date.new(2019, 12, 9)
      ]
    },
    2020 => {
      1 => [
        Date.new(2019, 12, 30),
        Date.new(2020, 1, 20),
        Date.new(2020, 2, 3),
        Date.new(2020, 2, 17),
        Date.new(2020, 3, 2),
        Date.new(2020, 3, 16)
      ],
      2 => [
        Date.new(2020, 3, 30),
        Date.new(2020, 4, 13),
        Date.new(2020, 4, 27),
        Date.new(2020, 5, 11),
        Date.new(2020, 5, 25),
        Date.new(2020, 6, 8)
      ], 
      3 => [
        Date.new(2020, 6, 29),
        Date.new(2020, 7, 13),
        Date.new(2020, 7, 27),
        Date.new(2020, 8, 10),
        Date.new(2020, 8, 24),
        Date.new(2020, 9, 7)
      ],
      4 => [
        Date.new(2020, 9, 28),
        Date.new(2020, 10, 12),
        Date.new(2020, 10, 26),
        Date.new(2020, 11, 9),
        Date.new(2020, 11, 23),
        Date.new(2020, 12, 7)
      ]
    }
  }.freeze

end
