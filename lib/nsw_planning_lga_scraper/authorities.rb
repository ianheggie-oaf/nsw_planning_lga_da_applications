# frozen_string_literal: true

module NswPlanningLgaScraper

  AUTHORITIES = {
    gunnedah: {
      code: 'GUNNEDAH',
      name: 'Gunnedah'
    }
  }.freeze

  UNUSED_AUTHORITIES = {
    albury_city: {
      code: 'ALBURY CITY',
      name: 'Albury City'
    },
    armidale_regional: {
      code: 'ARMIDALE REGIONAL',
      name: 'Armidale Regional'
    },
    ballina: {
      code: 'BALLINA',
      name: 'Ballina'
    },
    balranald: {
      code: 'BALRANALD',
      name: 'Balranald'
    },
    bathurst_regional: {
      code: 'BATHURST REGIONAL',
      name: 'Bathurst Regional'
    },
    bayside: {
      code: 'BAYSIDE',
      name: 'Bayside'
    },
    bega_valley: {
      code: 'BEGA VALLEY',
      name: 'Bega Valley'
    },
    bellingen: {
      code: 'BELLINGEN',
      name: 'Bellingen'
    },
    berrigan: {
      code: 'BERRIGAN',
      name: 'Berrigan'
    },
    blacktown: {
      code: 'BLACKTOWN',
      name: 'Blacktown'
    },
    bland: {
      code: 'BLAND',
      name: 'Bland'
    },
    blayney: {
      code: 'BLAYNEY',
      name: 'Blayney'
    },
    blue_mountains: {
      code: 'BLUE MOUNTAINS',
      name: 'Blue Mountains'
    },
    bogan: {
      code: 'BOGAN',
      name: 'Bogan'
    },
    bourke: {
      code: 'BOURKE',
      name: 'Bourke'
    },
    brewarrina: {
      code: 'BREWARRINA',
      name: 'Brewarrina'
    },
    broken_hill: {
      code: 'BROKEN HILL',
      name: 'Broken Hill'
    },
    burwood: {
      code: 'BURWOOD',
      name: 'Burwood'
    },
    byron: {
      code: 'BYRON',
      name: 'Byron'
    },
    cabonne: {
      code: 'CABONNE',
      name: 'Cabonne'
    },
    camden: {
      code: 'CAMDEN',
      name: 'Camden'
    },
    campbelltown: {
      code: 'CAMPBELLTOWN',
      name: 'Campbelltown'
    },
    canada_bay: {
      code: 'CANADA BAY',
      name: 'Canada Bay'
    },
    canterbury_bankstown: {
      code: 'CANTERBURY-BANKSTOWN',
      name: 'Canterbury-bankstown'
    },
    carrathool: {
      code: 'CARRATHOOL',
      name: 'Carrathool'
    },
    central_coast: {
      code: 'CENTRAL COAST',
      name: 'Central Coast'
    },
    central_darling: {
      code: 'CENTRAL DARLING',
      name: 'Central Darling'
    },
    cessnock: {
      code: 'CESSNOCK',
      name: 'Cessnock'
    },
    city_of_parramatta: {
      code: 'CITY OF PARRAMATTA',
      name: 'City Of Parramatta'
    },
    clarence_valley: {
      code: 'CLARENCE VALLEY',
      name: 'Clarence Valley'
    },
    cobar: {
      code: 'COBAR',
      name: 'Cobar'
    },
    coffs_harbour: {
      code: 'COFFS HARBOUR',
      name: 'Coffs Harbour'
    },
    coolamon: {
      code: 'COOLAMON',
      name: 'Coolamon'
    },
    coonamble: {
      code: 'COONAMBLE',
      name: 'Coonamble'
    },
    cootamundra_gundagai_regional: {
      code: 'COOTAMUNDRA-GUNDAGAI REGIONAL',
      name: 'Cootamundra-gundagai Regional'
    },
    cowra: {
      code: 'COWRA',
      name: 'Cowra'
    },
    cumberland: {
      code: 'CUMBERLAND',
      name: 'Cumberland'
    },
    dubbo_regional: {
      code: 'DUBBO REGIONAL',
      name: 'Dubbo Regional'
    },
    dungog: {
      code: 'DUNGOG',
      name: 'Dungog'
    },
    edward_river: {
      code: 'EDWARD RIVER',
      name: 'Edward River'
    },
    eurobodalla: {
      code: 'EUROBODALLA',
      name: 'Eurobodalla'
    },
    fairfield: {
      code: 'FAIRFIELD',
      name: 'Fairfield'
    },
    federation: {
      code: 'FEDERATION',
      name: 'Federation'
    },
    forbes: {
      code: 'FORBES',
      name: 'Forbes'
    },
    georges_river: {
      code: 'GEORGES RIVER',
      name: 'Georges River'
    },
    gilgandra: {
      code: 'GILGANDRA',
      name: 'Gilgandra'
    },
    glen_innes_severn: {
      code: 'GLEN INNES SEVERN',
      name: 'Glen Innes Severn'
    },
    goulburn_mulwaree: {
      code: 'GOULBURN MULWAREE',
      name: 'Goulburn Mulwaree'
    },
    greater_hume_shire: {
      code: 'GREATER HUME SHIRE',
      name: 'Greater Hume Shire'
    },
    griffith: {
      code: 'GRIFFITH',
      name: 'Griffith'
    },
    gwydir: {
      code: 'GWYDIR',
      name: 'Gwydir'
    },
    hawkesbury: {
      code: 'HAWKESBURY',
      name: 'Hawkesbury'
    },
    hay: {
      code: 'HAY',
      name: 'Hay'
    },
    hilltops: {
      code: 'HILLTOPS',
      name: 'Hilltops'
    },
    hornsby: {
      code: 'HORNSBY',
      name: 'Hornsby'
    },
    hunters_hill: {
      code: 'HUNTERS HILL',
      name: 'Hunters Hill'
    },
    inner_west: {
      code: 'INNER WEST',
      name: 'Inner West'
    },
    inverell: {
      code: 'INVERELL',
      name: 'Inverell'
    },
    junee: {
      code: 'JUNEE',
      name: 'Junee'
    },
    kempsey: {
      code: 'KEMPSEY',
      name: 'Kempsey'
    },
    kiama: {
      code: 'KIAMA',
      name: 'Kiama'
    },
    ku_ring_gai: {
      code: 'KU-RING-GAI',
      name: 'Ku-ring-gai'
    },
    kyogle: {
      code: 'KYOGLE',
      name: 'Kyogle'
    },
    lachlan: {
      code: 'LACHLAN',
      name: 'Lachlan'
    },
    lake_macquarie: {
      code: 'LAKE MACQUARIE',
      name: 'Lake Macquarie'
    },
    lane_cove: {
      code: 'LANE COVE',
      name: 'Lane Cove'
    },
    leeton: {
      code: 'LEETON',
      name: 'Leeton'
    },
    lismore: {
      code: 'LISMORE',
      name: 'Lismore'
    },
    lithgow_city: {
      code: 'LITHGOW CITY',
      name: 'Lithgow City'
    },
    liverpool: {
      code: 'LIVERPOOL',
      name: 'Liverpool'
    },
    liverpool_plains: {
      code: 'LIVERPOOL PLAINS',
      name: 'Liverpool Plains'
    },
    lockhart: {
      code: 'LOCKHART',
      name: 'Lockhart'
    },
    lord_howe_island: {
      code: 'LORD HOWE ISLAND - UNINCORPORATED AREA',
      name: 'Lord Howe Island - Unincorporated Area'
    },
    maitland: {
      code: 'MAITLAND',
      name: 'Maitland'
    },
    mid_coast: {
      code: 'MID-COAST',
      name: 'Mid-coast'
    },
    mid_western_regional: {
      code: 'MID-WESTERN REGIONAL',
      name: 'Mid-western Regional'
    },
    moree_plains: {
      code: 'MOREE PLAINS',
      name: 'Moree Plains'
    },
    mosman: {
      code: 'MOSMAN',
      name: 'Mosman'
    },
    murray_river: {
      code: 'MURRAY RIVER',
      name: 'Murray River'
    },
    murrumbidgee: {
      code: 'MURRUMBIDGEE',
      name: 'Murrumbidgee'
    },
    muswellbrook: {
      code: 'MUSWELLBROOK',
      name: 'Muswellbrook'
    },
    nambucca: {
      code: 'NAMBUCCA',
      name: 'Nambucca'
    },
    narrabri: {
      code: 'NARRABRI',
      name: 'Narrabri'
    },
    narrandera: {
      code: 'NARRANDERA',
      name: 'Narrandera'
    },
    narromine: {
      code: 'NARROMINE',
      name: 'Narromine'
    },
    newcastle: {
      code: 'NEWCASTLE',
      name: 'Newcastle'
    },
    north_sydney: {
      code: 'NORTH SYDNEY',
      name: 'North Sydney'
    },
    northern_beaches: {
      code: 'NORTHERN BEACHES',
      name: 'Northern Beaches'
    },
    oberon: {
      code: 'OBERON',
      name: 'Oberon'
    },
    orange: {
      code: 'ORANGE',
      name: 'Orange'
    },
    parkes: {
      code: 'PARKES',
      name: 'Parkes'
    },
    penrith: {
      code: 'PENRITH',
      name: 'Penrith'
    },
    port_macquarie_hastings: {
      code: 'PORT MACQUARIE-HASTINGS',
      name: 'Port Macquarie-hastings'
    },
    port_stephens: {
      code: 'PORT STEPHENS',
      name: 'Port Stephens'
    },
    queanbeyan_palerang_regional: {
      code: 'QUEANBEYAN-PALERANG REGIONAL',
      name: 'Queanbeyan-palerang Regional'
    },
    randwick: {
      code: 'RANDWICK',
      name: 'Randwick'
    },
    richmond_valley: {
      code: 'RICHMOND VALLEY',
      name: 'Richmond Valley'
    },
    ryde: {
      code: 'RYDE',
      name: 'Ryde'
    },
    shellharbour: {
      code: 'SHELLHARBOUR',
      name: 'Shellharbour'
    },
    shoalhaven: {
      code: 'SHOALHAVEN',
      name: 'Shoalhaven'
    },
    singleton: {
      code: 'SINGLETON',
      name: 'Singleton'
    },
    snowy_monaro_regional: {
      code: 'SNOWY MONARO REGIONAL',
      name: 'Snowy Monaro Regional'
    },
    snowy_valleys: {
      code: 'SNOWY VALLEYS',
      name: 'Snowy Valleys'
    },
    strathfield: {
      code: 'STRATHFIELD',
      name: 'Strathfield'
    },
    sutherland_shire: {
      code: 'SUTHERLAND SHIRE',
      name: 'Sutherland Shire'
    },
    sydney: {
      code: 'SYDNEY',
      name: 'Sydney'
    },
    sydney_olympic_park: {
      code: 'sydney_olympic_park',
      name: 'Sydney Olympic Park'
    },
    tamworth_regional: {
      code: 'TAMWORTH REGIONAL',
      name: 'Tamworth Regional'
    },
    temora: {
      code: 'TEMORA',
      name: 'Temora'
    },
    tenterfield: {
      code: 'TENTERFIELD',
      name: 'Tenterfield'
    },
    the_hills_shire: {
      code: 'THE HILLS SHIRE',
      name: 'The Hills Shire'
    },
    tweed: {
      code: 'TWEED',
      name: 'Tweed'
    },
    upper_hunter: {
      code: 'UPPER HUNTER',
      name: 'Upper Hunter'
    },
    upper_lachlan_shire: {
      code: 'UPPER LACHLAN SHIRE',
      name: 'Upper Lachlan Shire'
    },
    uralla: {
      code: 'URALLA',
      name: 'Uralla'
    },
    wagga_wagga: {
      code: 'WAGGA WAGGA',
      name: 'Wagga Wagga'
    },
    walcha: {
      code: 'WALCHA',
      name: 'Walcha'
    },
    walgett: {
      code: 'WALGETT',
      name: 'Walgett'
    },
    warren: {
      code: 'WARREN',
      name: 'Warren'
    },
    warrumbungle: {
      code: 'WARRUMBUNGLE',
      name: 'Warrumbungle'
    },
    waverley: {
      code: 'WAVERLEY',
      name: 'Waverley'
    },
    weddin: {
      code: 'WEDDIN',
      name: 'Weddin'
    },
    wentworth: {
      code: 'WENTWORTH',
      name: 'Wentworth'
    },
    willoughby: {
      code: 'WILLOUGHBY',
      name: 'Willoughby'
    },
    wingecarribee: {
      code: 'WINGECARRIBEE',
      name: 'Wingecarribee'
    },
    wollondilly: {
      code: 'WOLLONDILLY',
      name: 'Wollondilly'
    },
    wollongong: {
      code: 'WOLLONGONG',
      name: 'Wollongong'
    },
    woollahra: {
      code: 'WOOLLAHRA',
      name: 'Woollahra'
    },
    yass_valley: {
      code: 'YASS VALLEY',
      name: 'Yass Valley'
    }
  }.freeze
end
