require "test_helper"
require "ocawari/strategy_delegator"
require "ocawari/strategy/no_match"

class StrategyDelegatorTest < Minitest::Test
  def test_it_handles_ameblo_posts
    url = "http://ameblo.jp/pidl-nagoya/entry-12157434206.html"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::Ameblo, strategy
  end

  def test_it_handles_girls_news_posts
    url = "http://girlsnews.tv/akb/286302"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::GirlsNews, strategy
  end

  def test_it_handles_google_plus_posts
    url = "https://plus.google.com/105835152133357364264/posts/DnCtSqZEkSh"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::GooglePlus, strategy
  end

  def test_it_handles_hustlepress_posts
    url = "https://hustlepress.co.jp/keyakizaka46_72/"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::Hustlepress, strategy
  end

  def test_it_handles_imgur_albums
    url = "http://imgur.com/a/Xx5JN"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::Imgur, strategy
  end

  def test_it_handles_instagram_posts
    url = "https://www.instagram.com/p/BFAY_eWGWfB"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::Instagram, strategy
  end

  def test_it_handles_kaiyou_posts
    url = "http://kai-you.net/article/28983"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::Kaiyou, strategy
  end

  def test_it_handles_keyakizaka46_posts
    url = "http://www.keyakizaka46.com/s/k46o/diary/detail/7352?ima=0000&cd=member"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::Keyakizaka46, strategy
  end

  def test_it_handles_line_posts
    url = "http://lineblog.me/kimuramisa/archives/5858555.html"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::Line, strategy
  end

  def test_it_handles_logirl_posts
    url = "https://logirl.favclip.com/article/detail/5146591566495744"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::Logirl, strategy
  end

  def test_it_handles_mantan_web_posts
    url = "http://mantan-web.jp/2017/01/29/20170129dog00m200019000c.html"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::MantanWeb, strategy
  end

  def test_it_handles_mensfashion_posts
    url = "http://mensfashion.cc/interviews/morikanon/"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::MensFashion, strategy
  end

  def test_it_handles_modelpress_posts
    url = "https://mdpr.jp/news/detail/1647057"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::ModelPress, strategy
  end

  def test_it_handles_nanagogo_posts
    url = "https://7gogo.jp/kizaki-yuria/4095"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::NanaGoGo, strategy
  end

  def test_it_handles_natalie_posts
    url = "http://natalie.mu/music/news/213794"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::Natalie, strategy
  end

  def test_it_handles_smartflash_posts
    url = "http://smart-flash.jp/entame/idol/7288"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::SmartFlash, strategy
  end

  def test_it_handles_stereo_sound_online_posts
    url = "http://www.stereosound.co.jp/column/idollove/article/2017/01/23/53214.html"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::StereoSound, strategy
  end

  def test_it_handles_tokyo_idol_net_posts
    url = "http://www.tokyoidol.net/?p=4848"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::TokyoIdolNet, strategy
  end

  def test_it_handles_tumblr_posts_without_tumblr_in_url
    url = "http://www.voz48.xyz/post/143373333526/young-magazine-no21-22-2016"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::Tumblr, strategy
  end

  def test_it_handles_tumblr_posts_with_tumblr_in_url
    url = "http://tokyo-akb48.tumblr.com/post/140480736666"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::Tumblr, strategy
  end

  def test_it_handles_tumblr_hosted_blog
    # goddamit voz48
    url = "http://www.i.voz48.xyz/post/144125258480/young-champion-no11-2016"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::Tumblr, strategy
  end

  def test_it_handles_twitter_posts
    url = "https://twitter.com/Kotone_LTS/status/728252241270857728"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::Twitter, strategy
  end

  def test_it_returns_no_match_strategy_if_strategy_matches_found
    url = "https://twitter.com"
    strategy = Ocawari::StrategyDelegator.identify(url)

    assert_equal Ocawari::Strategy::NoMatch, strategy
  end
end
