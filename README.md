# Ocawari [![Build Status](https://travis-ci.org/NewSchoolKaidan/ocawari.svg?branch=master)](https://travis-ci.org/NewSchoolKaidan/ocawari)

Fetches the images from supported domains, primarily where images of [Japanese idols](http://newschoolkaidan.com/daes-idol-101/) can be found such as Twitter or Instagram and less commonly social media sites like 755 and Google Plus. Since this was developed for personal scripting use, features are added sporadically and may not be suitable for production.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ocawari'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ocawari

## Usage

Ocawari accepts either an array of urls or a string through a public #parse class method through the top level `Ocawari` module. The #parse method can take either an array of urls or a single string. In the case that it receives no valid arguments (empty Array, empty String, nil, invalid string url, failed network requests), it will return an empty Array.


```ruby
require "ocawari"

# With url as argument
urls = [
  "https://twitter.com/kayoyon213/status/853480124875919360",
  "https://plus.google.com/105835152133357364264/posts/dc3mX2seBbP",
  "https://www.instagram.com/p/BTbNyYFlUqK/?taken-by=katorena_ktrn&hl=ja",
]

Ocawari.parse(urls)

# => [
#  "https://scontent.cdninstagram.com/t51.2885-15/e35/18096115_259830451156318_7337145356775325696_n.jpg",
#  "https://pbs.twimg.com/media/C9grpPYVwAAf6tO.jpg:large",
#  "https://pbs.twimg.com/media/C9grpPaUwAAUMa9.jpg:large",
#  "https://lh3.googleusercontent.com/-Sbo9d0O1Y-Y/WQs4L1DTytI/AAAAAAAKPJ8/1lt7eO9qQVkJkmki95CPkN3kp9RSFiutwCHM/s0/04%2B-%2B1"
# ]

# With single string as an argument
Ocawari.parse("http://lineblog.me/2zicon/archives/1062410837.html")

# => [
#  "https://obs.line-scdn.net/0m0ed7108ce84d280e363e6015367c677c327b1f3c64312d1d11035f5d2a5a4055307735714a765e0f7c27533345581e3e66635a25731668003539326f64777b1424646b252c152f55622e6f734c603c3d223f",
#  "https://obs.line-scdn.net/0m0ed71085e84d280e363e6015367c677c327b290b5e304a126424787e4b287a4501485775724368697a7a37685a622f2047675a25731668003539316665777b1424616f732c152f55632e6f734c603c3d2360",
#  "https://obs.line-scdn.net/0m0ed710bde84d280e363e6015367c677c327b090f7c2b2e1d713c6f654f73407317604b4549523a794358704e525a213565515a2573166800353931676b777b14246b69747f167e08332e6f734c603c3d2469",
#  "https://obs.line-scdn.net/0m0ed710b6e84d280e363e6015367c677c327b1f2f74026c0b742767502e6f6f38206870357e4a6d0e6c673f525a483a3932645a2573166800353931646b777b1424656f787a152f55602e6f734c603c3d2438",
#  "https://obs.line-scdn.net/0m0ed710afe84d280e363e6015367c677c327b1f10584b7b3e6f216b44216f68542c5351324350485d7d584873467d213a62545a25731668003539316568777b1424356b257d152f55612e6f734c603c3d256a"
# ]

# With invalid arguments
Ocawari.parse("")
# => []
Ocawari.parse([])
# => []
Ocawari.parse(nil)
# => []
Ocawari.parse("ASAMINはおれの嫁")
# => []
```

Ocawari also comes with a command line interface via the `oca` command. It takes any number of arguments and then outputs the urls to the images to STDOUT. 

```
oca http://ameblo.jp/saho-iwatate/entry-12270820699.html

// Outputs the following
https://stat.ameba.jp/user_images/20170502/00/saho-iwatate/09/1f/j/o0480036013926951597.jpg
https://stat.ameba.jp/user_images/20170502/00/saho-iwatate/b2/8c/j/o0480036013926951622.jpg
https://stat.ameba.jp/user_images/20170502/00/saho-iwatate/7b/68/j/o0480036013926951627.jpg
https://stat.ameba.jp/user_images/20170502/00/saho-iwatate/c6/7a/j/o0480036013926951642.jpg
https://stat.ameba.jp/user_images/20170502/00/saho-iwatate/46/9f/j/o0480036013926951647.jpg
https://stat.ameba.jp/user_images/20170502/00/saho-iwatate/4d/36/j/o0480036013926951655.jpg
https://stat.ameba.jp/user_images/20170502/00/saho-iwatate/72/c7/j/o0480036013926951662.jpg
```

By doing this, I am usually running the following commands or something similar at least several times a days

```
oca https://twitter.com/CP_asami_ist/status/859057692140224514 | xargs wget -P $HOME/Pictures/渡辺亜沙美
```


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
