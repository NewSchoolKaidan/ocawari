require "ocawari/strategy/ameblo"
require "ocawari/strategy/google_plus"
require "ocawari/strategy/imgur"
require "ocawari/strategy/instagram"
require "ocawari/strategy/kaiyou"
require "ocawari/strategy/keyakizaka46"
require "ocawari/strategy/line"
require "ocawari/strategy/logirl"
require "ocawari/strategy/modelpress"
require "ocawari/strategy/nana_go_go"
require "ocawari/strategy/natalie"
require "ocawari/strategy/smart_flash"
require "ocawari/strategy/tokyo_idol_net"
require "ocawari/strategy/tumblr"
require "ocawari/strategy/twitter"
require "ocawari/strategy/no_match"

module Ocawari
  class StrategyDelegator
    STRATEGY_MAP = {
      /ameblo\.jp\/[\W\w]+\/entry-\d+\.html/ => "Ameblo",
      /plus\.google\.com\/\d+\/posts\/\w+/ => "GooglePlus",
      /imgur\.com\/a\/.*/ => "Imgur",
      /instagram\.com\/p\/[\W\w]+/ => "Instagram",
      /kai-you\.net\/article\/\d+/ => "Kaiyou",
      /keyakizaka46\.com\/s\/k46o\/diary\/detail/ => "Keyakizaka46",
      /lineblog\.me\/\w+\/archives\/\d+\.html/ => "Line",
      /logirl\.favclip\.com\/article\/detail\/\d+/ => "Logirl",
      /mdpr\.jp\/news\/detail\/\d+/ => "ModelPress",
      /7gogo\.jp\/[\W\w]+\/\d+/ => "NanaGoGo",
      /natalie\.mu\/music\/news\/\d+/ => "Natalie",
      /smart-flash\.jp\/\w+(\/\w+)?\/\d+/ => "SmartFlash",
      /tokyoidol\.net\/\?p=\d+/ => "TokyoIdolNet",
      /tumblr\.com\/post\/\d+\/?/ => "Tumblr",
      /voz48\.xyz\/post\/\d{1,}\/.*/ => "Tumblr",
      /twitter\.com\/\w+\/status\/\d{1,}/ => "Twitter"
    }

    def self.identify(url)
      if RUBY_VERSION >= "2.4.0"
        STRATEGY_MAP.each do |regex, strategy|
          if regex.match?(url)
            return Ocawari::Strategy.const_get(strategy)
          end
        end

        Ocawari::Strategy::NoMatch
      else
        STRATEGY_MAP.each do |regex, strategy|
          if url =~ regex
            return Ocawari::Strategy.const_get(strategy)
          end
        end

        Ocawari::Strategy::NoMatch
      end
    end
  end
end
