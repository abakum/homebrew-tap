class Crocgui < Formula
  desc "GUI for croc — secure file transfer tool"
  homepage "https://github.com/abakum/crocgui"
  url "https://github.com/abakum/crocgui/releases/download/v1.11.54/crocgui.tar.xz"
  sha256 "1e6260dc8725172e653fee9693c6b7e3d5e6c9e65322a9a19738eae495b0b3ee"
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
    bashrc = Pathname.new(Dir.home)/".bashrc"

    safe_line = 'export XDG_DATA_DIRS="${XDG_DATA_DIRS:+$XDG_DATA_DIRS:}' + "#{HOMEBREW_PREFIX}/share\""

    command = %Q(grep -Fq "#{HOMEBREW_PREFIX}/share" ~/.bashrc || echo '#{safe_line}' >> ~/.bashrc)

    msg = "You can launch the application from your menu or via terminal:\n  gtk-launch #{APP_ID}"

    if bashrc.exist? && bashrc.read.include?("#{HOMEBREW_PREFIX}/share")
      msg
    else
      <<~EOS
        The desktop shortcut was installed, but Homebrew's share directory might not be in your XDG_DATA_DIRS.

        To ensure the application appears in your system menu and can be launched via gtk-launch, run:

          #{command}

        Then refresh your shell environment:
          source ~/.bashrc

        #{msg}
      EOS
    end
  end

  test do
    assert_path_exists bin/"crocgui"
  end
end
