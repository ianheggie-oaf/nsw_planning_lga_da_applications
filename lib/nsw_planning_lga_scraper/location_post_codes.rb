# frozen_string_literal: true

module NswPlanningLgaScraper
  # Remember to put longer names before shorter, EG "South Geelong" before "Geelong"
  # Each entry is a pair of DOWNCASED location and a post_code
  LOCATION_POST_CODES = [
    %w[mullaley 2379],
    %w[gunnedah 2380],
    %w[piallaway 2342],
    %w[carroll 2340]
  ].freeze
end
