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
      /entameclip\.com/ => "EntameClip",
      /gendai\.ismedia\.jp/ => "GendaiBusiness",
      /girlsnews\.tv/ => "GirlsNews",
      /plus\.google\.com(\/u\/\d+)?\/\d+\/posts\/\w+/ => "GooglePlus",
      /hustlepress\.co\.jp/ => "Hustlepress",
      /imgur\.com\/a\/.*/ => "Imgur",
      /instagram\.com\/p\/[\W\w]+/ => "Instagram",
      /kai-you\.net\/article\/\d+/ => "Kaiyou",
      /keyakizaka46\.com\/s\/k46o\/diary\/detail/ => "Keyakizaka46",
      /lineblog\.me\/\w+\/archives\/\d+\.html/ => "Line",
      /mensfashion\.cc/ => "MensFashion",
      /mdpr\.jp/ => "ModelPress",
      /mantan-web\.jp/ => "MantanWeb",
      /blog\.nanabunnonijyuuni\.com/  => "NanaBunNoNijuuni",
      /7gogo\.jp\/[\W\w]+\/\d+/ => "NanaGoGo",
      /natalie\.mu/ => "Natalie",
      /news\.dwango\.jp/ => "NewsDwango",
      /nikkansports\.com/ => "NikkanSports",
      /okmusic\.jp/ => "OkMusicJP",
      /sirabee\.com/ => "Sirabee",
      /stereosound\.co\.jp\/column\/idollove/ => "StereoSound",
      /tokyoidol\.net\/\?p=\d+/ => "TokyoIdolNet",
      /tumblr\.com\/post\/\d+\/?/ => "Tumblr",
      /tv-tokyo\.co\.jp/ => "TvTokyo",
      /voz48\.xyz\/post\/\d{1,}\/.*/ => "Tumblr",
      /twitter\.com\/\w+\/status\/\d{1,}/ => "Twitter"
    }

    def self.identify(url)
      STRATEGY_MAP.each do |regex, strategy|
        if regex.match?(url)
          return Ocawari::Strategy.const_get(strategy)
        end
      end

      Ocawari::Strategy::NoMatch
    end
  end
end
