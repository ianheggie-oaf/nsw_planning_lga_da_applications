# frozen_string_literal: true

require "scraperwiki"
require "mechanize"

require_relative "nsw_planning_lga_scraper/version"
require_relative "nsw_planning_lga_scraper/authorities"
require_relative "nsw_planning_lga_scraper/location_post_codes"

# Scrape a masterview development application system
module NswPlanningLgaScraper
  BASE_URL = "https://www.planningportal.nsw.gov.au"
  # Max pages for Search "All" types
  MAX_ANY_PAGES = 10

  ANY_STATUS = "All"
  ON_EXHIBITION_STATUS = "On Exhibition"
  UNDER_CONSIDERATION_STATUS = "Under Consideration"
  LEC_CONSIDERATION_STATUS = "LEC Consideration"

  STREET_TYPE_ABBREVIATIONS = {
    "st" => "Street",
    "rd" => "Road",
    "ave" => "Avenue",
    "dr" => "Drive",
    "cres" => "Crescent",
    "pl" => "Place",
    "ln" => "Lane",
    "ct" => "Court",
    "way" => "Way", # Already full form
    "blvd" => "Boulevard",
    "pde" => "Parade",
    "hwy" => "Highway",
    "tce" => "Terrace",
    "cct" => "Circuit",
    "cl" => "Close",
    "esp" => "Esplanade",
    "gr" => "Grove",
    "mews" => "Mews", # Already full form
    "rise" => "Rise", # Already full form
    "square" => "Square", # Already full form
    "mall" => "Mall", # Already full form
    "bypass" => "Bypass", # Already full form
    "loop" => "Loop", # Already full form
    "walk" => "Walk", # Already full form
    "bridge" => "Bridge", # Already full form
    "bvd" => "Boulevard"
  }.freeze

  STREET_TYPES = STREET_TYPE_ABBREVIATIONS.values.map(&:downcase).freeze

  # Define mapping of abbreviated street types to full names
  def expand_street_types(address)
    # Define mapping of abbreviated forms to full names

    # Split the address to find the last word
    parts = address.split
    return address if parts.empty?

    last_word = parts.last.downcase

    # Check if the last word is an abbreviation
    if abbreviation_map.key?(last_word)
      # Replace the last word with its full form
      parts[-1] = abbreviation_map[last_word]
      return parts.join(" ")
    end

    # No replacement needed
    address
  end

  def self.scrape(authority, &block)
    raise "Unexpected authority: #{authority}" unless AUTHORITIES.key?(authority)

    scrape_lga(**AUTHORITIES[authority], &block)
  end

  def self.scrape_lga(code:, name: nil, timeout: nil)
    statuses = [ANY_STATUS]
    visited_urls = Set.new
    visited_cards = Set.new

    agent = Mechanize.new
    # On morph.io set the environment variable MORPH_AUSTRALIAN_PROXY to
    # http://morph:password@au.proxy.oaf.org.au:8888 replacing password with
    # the real password.
    # We're using the proxy for every authority because the problem is becoming common
    # enough that it's easier just to use it for everything
    agent.agent.set_proxy(ENV["MORPH_AUSTRALIAN_PROXY"])
    if timeout
      agent.open_timeout = timeout
      agent.read_timeout = timeout
    end

    while (status = statuses.pop)
      url = url_for(code, status)
      puts "INITIAL URL: #{url}"
      page_num = 0

      while url && !visited_urls.include?(url)
        puts "Scraping page #{page_num + 1} for #{code} - #{status}..."

        visited_urls.add(url)
        page = agent.get(url)

        # Extract all application cards
        page.search(".card").each do |card|
          app_data = parse_application_card(card, name)
          next if app_data.nil? || visited_cards.include?(app_data["council_reference"])

          yield app_data
          visited_cards.add app_data["council_reference"]
        end

        next_link = page.at("li.pager__next a")
        next unless next_link

        url = url_for_href(next_link["href"])
        puts "NEXT URL: #{url}"
        page_num += 1
        next unless status == ANY_STATUS && page_num >= MAX_ANY_PAGES

        statuses = [ON_EXHIBITION_STATUS, UNDER_CONSIDERATION_STATUS, LEC_CONSIDERATION_STATUS]
        puts "Too many ANY pages - restricting to #{statuses.join(', ')}"
        url = nil
      end
    end
  end

  def self.url_for(code, status)
    [
      "#{BASE_URL}/daexhibitions?field_daex_status_value=#{CGI.escape status}",
      "field_local_government_area_value=#{CGI.escape code.to_s}",
      "field_application_type_value=All",
      "field_panel_reference_number_value=",
      "field_council_unique_number_value=",
      "title=",
      "field_exhibition_start_date_value=",
      "field_exhibition_end_date_value="
    ].join("&")
  end

  def self.url_for_href(href)
    if href.start_with?("http")
      href
    elsif href.start_with?("?")
      "#{BASE_URL}/daexhibitions#{href}"
    elsif href.start_with?("/")
      "#{BASE_URL}#{href}"
    else
      URI.join(BASE_URL, href).to_s
    end
  end

  # Parse a single card to extract application details
  def self.parse_application_card(card, council_name)
    title_element = card.at("h3.card__title a")
    return nil unless title_element

    href = title_element["href"]
    full_title = title_element.text.strip

    parts = full_title.split(" - ")
    return nil if parts.size < 2

    council_reference = parts.shift.strip
    address = parts.shift

    address = "#{address} - #{parts.shift}" while parts.size >= 2 && !address.include?(",")
    address = normalize_address(address, council_name)
    description = parts.join(" - ").strip
    {
      "council_reference" => council_reference,
      "address" => address,
      "description" => description,
      "info_url" => url_for_href(href),
      "date_scraped" => Date.today.to_s
    }
  end

  # A lot of messing around with address to normalize to detail page...
  # Saves having to access every detail page!
  def self.normalize_address(address, council_name)
    return "" if address&.blank?

    last_word = address.split.last&.downcase
    if (has_council = (last_word == council_name.downcase))
      address = address.sub(/,? #{council_name}$/i, "")
      last_word = address.split.last&.downcase
    end
    if STREET_TYPES.include?(last_word)
      address = "#{address}, #{council_name}"
    elsif STREET_TYPE_ABBREVIATIONS.key?(last_word)
      address = address.sub(/\s+#{last_word}\s*$/i, " #{STREET_TYPE_ABBREVIATIONS[last_word]}")
      address = "#{address}, #{council_name}"
    end
    address = "#{address} #{council_name}" if has_council && !address.end_with?(" #{council_name}")
    address = address.sub(/,? nsw$/i, " NSW")
    address = "#{address} NSW" unless address.include?("NSW")
    address_downcased = address.downcase
    LOCATION_POST_CODES.each do |location, post_code|
      if address_downcased.end_with?(" #{location} nsw")
        address = "#{address} #{post_code}"
        break
      end
    end
    address
  end

  def self.extract_result_count(code)
    agent = Mechanize.new
    agent.agent.set_proxy(ENV["MORPH_AUSTRALIAN_PROXY"])
    url = url_for(code, ANY_STATUS)
    page = agent.get(url)
    results_meta = page.at("div.form__item--meta div")

    if results_meta
      results_text = results_meta.text.strip
      return ::Regexp.last_match(1).to_i if results_text =~ /Showing: (\d+) results?/i
    end
    nil
  end
end
