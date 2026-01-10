class Crocgui < Formula
  desc "GUI for croc — secure file transfer tool"
  homepage "https://github.com/abakum/crocgui"
  url "https://github.com/abakum/crocgui/releases/download/v1.11.34/crocgui.tar.xz"
  sha256 "b0f13da18ff4339d837d69a83f4fe591e6cd2ee3344c676d2298bf223e5bbdc4"
  license "ISC"

  APP_ID = "com.github.howeyc.crocgui".freeze

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
    local_apps_dir = Pathname(Dir.home)/".local/share/applications"
    local_apps_dir.mkpath

    desktop_file = prefix/"share/applications/#{APP_ID}.desktop"
    if desktop_file.exist?
      (local_apps_dir/"#{APP_ID}.desktop").make_symlink(desktop_file)
      ohai "Desktop entry linked to #{local_apps_dir}"
    end
  end

  def post_uninstall
    local_desktop_file = Pathname(Dir.home)/".local/share/applications/#{APP_ID}.desktop"

    if local_desktop_file.symlink?
      local_desktop_file.delete
      ohai "Removed desktop entry: #{local_desktop_file}"
    end
  end

  test do
    assert_path_exists bin/"crocgui"
  end
end
