class Crocgui < Formula
  desc "GUI for croc — secure file transfer tool"
  homepage "https://github.com/abakum/crocgui"
  url "https://github.com/abakum/crocgui/releases/download/v1.11.46/crocgui.tar.xz"
  sha256 "4b7de3f54012c3be4ffaa7a2ca58cecc6c1bbf76d1a00de1afd6a6a7219a24ac"
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
