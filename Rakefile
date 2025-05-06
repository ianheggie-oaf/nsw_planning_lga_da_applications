# frozen_string_literal: true

$LOAD_PATH << "./lib"

require "rspec/core/rake_task"
require_relative 'lib/nsw_planning_lga_scraper'
require_relative 'lib/nsw_planning_lga_scraper/recommendation_helper'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc "Recommended LGAs to add"
task :recommend do
  NswPlanningLgaScraper::RecommendationHelper.recommend
end
