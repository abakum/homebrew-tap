class Crocgui < Formula
  desc "GUI for croc — secure file transfer tool"
  homepage "https://github.com/abakum/crocgui"
  url "https://github.com/abakum/crocgui/releases/download/v1.11.34/crocgui.tar.xz"
  sha256 "b0f13da18ff4339d837d69a83f4fe591e6cd2ee3344c676d2298bf223e5bbdc4"
  license "ISC"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :linux

  def install
    ENV["PREFIX"] = prefix.to_s
    ENV["DESTDIR"] = ""

    system "make", "install"
  end

  def post_install
    if (HOMEBREW_PREFIX/"share/applications").exist?
      system "update-desktop-database", HOMEBREW_PREFIX/"share/applications"
    end
  end

  test do
    assert_path_exists bin/"crocgui"
  end
end
