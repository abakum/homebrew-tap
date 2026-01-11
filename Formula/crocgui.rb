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
    quiet_system "update-desktop-database", HOMEBREW_PREFIX/"share/applications" if which("update-desktop-database")
  end

  def caveats
    line_to_add = "export XDG_DATA_DIRS=\"#{HOMEBREW_PREFIX}/share:$XDG_DATA_DIRS\""
    bashrc = Pathname.new(Dir.home)/".bashrc"
    
    # Base message that always shows
    msg = "You can launch the application from your menu or via terminal:\n  gtk-launch #{APP_ID}"

    # Check if we need to add the environment setup instructions
    if bashrc.exist? && bashrc.read.include?(line_to_add)
      msg
    else
      <<~EOS
        The desktop shortcut was installed, but Homebrew's share directory is not in your XDG_DATA_DIRS.
        To see the application in your system menu and use gtk-launch, please run:

        grep -qF '#{line_to_add}' ~/.bashrc || echo '#{line_to_add}' >> ~/.bashrc

        Then, refresh your shell environment:
          source ~/.bashrc

        #{msg}
      EOS
    end
  end

  test do
    assert_path_exists bin/"crocgui"
  end
end
