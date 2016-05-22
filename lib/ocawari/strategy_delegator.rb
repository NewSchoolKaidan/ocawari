require "ocawari/strategy/ameblo"
require "ocawari/strategy/google_plus"
require "ocawari/strategy/imgur"
require "ocawari/strategy/instagram"
require "ocawari/strategy/line"
require "ocawari/strategy/nana_go_go"
require "ocawari/strategy/smart_flash"
require "ocawari/strategy/tokyo_idol_net"
require "ocawari/strategy/tumblr"
require "ocawari/strategy/twitter"
require "ocawari/strategy/no_match"

module Ocawari
  class StrategyDelegator
    STRATEGY_MAP = {
      /ameblo\.jp\/[\W\w]+\/entry-\d+\.html/ => "Ameblo",
      /imgur\.com\/a\/.*/ => "Imgur",
      /instagram\.com\/p\/[\W\w]+/ => "Instagram",
      /plus\.google\.com\/\d+\/posts\/\w+/ => "GooglePlus",
      /lineblog\.me\/\w+\/archives\/\d+\.html/ => "Line",
      /7gogo\.jp\/[\W\w]+\/\d+/ => "NanaGoGo",
      /smart-flash\.jp\/\w+(\/\w+)?\/\d+/ => "SmartFlash",
      /tokyoidol\.net\/\?p=\d+/ => "TokyoIdolNet",
      /tumblr\.com\/post\/\d+\/?/ => "Tumblr",
      /voz48\.xyz\/post\/\d{1,}\/.*/ => "Tumblr",
      /twitter\.com\/\w+\/status\/\d{1,}/ => "Twitter"
    }

    def self.identify(url)
      STRATEGY_MAP.each do |regex, strategy|
        if url =~ regex
          return Ocawari::Strategy.const_get(strategy)
        end
      end
      
      Ocawari::Strategy::NoMatch
    end
  end
end
