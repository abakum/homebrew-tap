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
