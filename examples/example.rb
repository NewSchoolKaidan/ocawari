require "ocawari"

# List of urls

post_urls = %w(
  https://www.instagram.com/p/BFY1Y5ozTK-/?taken-by=hirari_official
  ameblo.jp/kusunoki-mayu/entry-12159760806.html
  https://twitter.com/Emika_Kamieda/status/731673032939294720
  https://twitter.com/ayaka1o11/status/731674755422543872
  http://www.tokyoidol.net/?p=4080
  https://twitter.com/Kotone_LTS/status/729673476735295490
  http://lineblog.me/kimuramisa/archives/6352820.html
)

images = Ocawari.parse(post_urls)


Ocawari.parse("")
