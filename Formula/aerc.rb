class Aerc < Formula
  desc "a pretty good email client"
  homepage "https://aerc-mail.org"
  url "https://git.sr.ht/~sircmpwn/aerc/archive/0.4.0.tar.gz"
  sha256 "d369462cc0f76c33d804e586463e4d35d81fba9396ec08c3d3d0579e26091e17"
  license "MIT"

  depends_on "go" => :build
  depends_on "scdoc" => :build
  depends_on "notmuch"

  def install
    ENV["GOFLAGS"] = "-tags=notmuch"
    
    # included make install is broken for homebrew
    bin.mkpath
    share.mkpath
    
    aerc_path = share/"aerc"
    filter_path = share/"aerc/filters"
    template_path = share/"aerc/templates"
    
    [aerc_path, filter_path, template_path].each do |path|
      path.mkpath
    end
    
    system "make"
    
    bin.install "aerc"
    man1.install "aerc.1"
    man1.install "aerc-search.1"
    man5.install "aerc-config.5"
    man5.install "aerc-imap.5"
    man5.install "aerc-maildir.5"
    man5.install "aerc-sendmail.5"
    man5.install "aerc-notmuch.5"
    man5.install "aerc-smtp.5"
    man7.install "aerc-tutorial.7"
    man7.install "aerc-templates.7"
    aerc_path.install "config/accounts.conf"
    aerc_path.install "aerc.conf"
    aerc_path.install "config/binds.conf"
    filter_path.install "filters/hldiff"
    filter_path.install "filters/html"
    filter_path.install "filters/plaintext"
    template_path.install "templates/quoted_reply"
    template_path.install "templates/forward_as_body"
  end
  
  test do
    # if anyone has ideas for a better test, feel free to let me know
    # or make a PR
    system "aerc -v"
  end
end
