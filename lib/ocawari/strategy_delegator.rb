# Require all strategies
Dir[
  File.join(
    File.expand_path(File.dirname(__FILE__)), 
    "strategy", 
    "*"
  )
].each { |strategy| require strategy }

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
