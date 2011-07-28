module LandingHelper
  def frequency_options
    options_for_select [['I want to blog every...', nil],
      ['Day', 1],
      ['Week', 7],
      ['Month', 30],
    ] 
  end
end
