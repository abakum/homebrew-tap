class Crocgui < Formula
  desc "GUI for croc — secure file transfer tool"
  homepage "https://github.com/abakum/crocgui"
  url "https://github.com/abakum/crocgui/releases/download/v1.11.33/crocgui.tar.xz"
  sha256 "a25b4e873fd93466d7d7d964d530d962ccc213bd105855532561573ca9016f5e"
  license "ISC"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :linux

  def install
    system "tar", "-xf", cached_download

    install_env = {
      "PREFIX"  => prefix.to_s,
      "DESTDIR" => "",
    }

    system install_env, "make", "-f", "Makefile", "install"
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
