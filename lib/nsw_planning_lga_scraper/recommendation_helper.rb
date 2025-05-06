# frozen_string_literal: true

module NswPlanningLgaScraper
  # Provide recommendations of councils we could add
  class RecommendationHelper
    def self.recommend
      active_councils = active_nsw_councils
      broken_councils = broken_nsw_councils
      puts "ACTIVE: #{active_councils.to_yaml}"
      NswPlanningLgaScraper::UNUSED_AUTHORITIES.each do |authority_label, details|
        count = NswPlanningLgaScraper.extract_result_count(details[:code])
        if count&.positive?
          if active_councils.any? { |name| name.include?(details[:name]) }
            puts "Already have: #{authority_label} \t#{details[:name].inspect} with #{count} results"
          elsif broken_councils.any? { |name| name.include?(details[:name]) }
            puts "RECOMMEND AS IT FIXES: #{authority_label} \t#{details[:name].inspect} with #{count} results"
          else
            puts "RECOMMEND NEW: #{authority_label} \t#{details[:name].inspect} with #{count} results"
          end
        else
          puts "Ignored: #{authority_label} \t#{details[:name].inspect} with no results"
        end
      end
    end

    # Function to extract NSW councils that aren't marked as "Possibly broken"
    def self.active_nsw_councils
      agent = Mechanize.new
      page = agent.get("https://www.planningalerts.org.au/authorities")

      active_councils = []

      # Process each table row
      page.search("tr").each do |row|
        cells = row.search("td")
        next if cells.size < 3 # Skip rows without enough cells

        state = cells[0].text.strip
        council_cell = cells[1]
        council_link = council_cell.at("a")
        is_broken = council_cell.text.include?("Possibly broken")
        next unless council_link && state == "NSW" && !is_broken

        active_councils << council_link.text.strip
      end

      active_councils
    end

    def self.broken_nsw_councils
      agent = Mechanize.new
      page = agent.get("https://www.planningalerts.org.au/authorities")

      broken_councils = []

      # Process each table row
      page.search("tr").each do |row|
        cells = row.search("td")
        next if cells.size < 3 # Skip rows without enough cells

        state = cells[0].text.strip
        council_cell = cells[1]
        council_link = council_cell.at("a")
        is_broken = council_cell.text.include?("Possibly broken")
        next unless council_link && state == "NSW" && is_broken

        broken_councils << council_link.text.strip
      end

      broken_councils
    end
  end
end
