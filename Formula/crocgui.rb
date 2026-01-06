class Crocgui < Formula
  desc "GUI for croc — secure file transfer tool"
  homepage "https://github.com/abakum/crocgui"
  url "https://github.com/abakum/crocgui/releases/download/v1.11.31/crocgui.tar.xz"
  sha256 "95bf3111512903185bd9d8216bc99bc100c43a9ae47a4ad2f21d53a23a22859c"
  license "ISC"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :linux

  def install
    system "tar", "-xf", cached_download

    bin.install "usr/local/bin/crocgui"
    (share/"applications").install "usr/local/share/applications/com.github.howeyc.crocgui.desktop"
    (share/"pixmaps").install "usr/local/share/pixmaps/com.github.howeyc.crocgui.png"
  end

  def post_install
    system "update-desktop-database", "#{HOMEBREW_PREFIX}/share/applications"
  end

  test do
    assert_path_exists bin/"crocgui"
  end
end
