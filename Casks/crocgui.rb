# typed: false
# frozen_string_literal: true

cask "crocgui" do
  arch arm: "arm64", intel: "amd64"

  version "1.11.49"
  sha256 arm:          "b7aefb17ecfd15a6824ac983a34420da9c4cbe97afc64f2003ba4af73bab4c64",
         intel:        "dada8aa4bd99cf4724bb62a1a8899e385ec02569502f60a6ae5beeabda844139",
         arm64_linux:  "0",
         x86_64_linux: "0"

  url "https://github.com/abakum/crocgui/releases/download/v#{version}/crocgui-#{arch}.dmg"
  name "crocgui"
  desc "GUI for croc — secure file transfer tool"
  homepage "https://github.com/abakum/crocgui"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "crocgui.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-r", "-d", "com.apple.quarantine", staged_path/"crocgui.app"]
  end

  zap trash: "~/Library/Preferences/fyne/com.github.howeyc.crocgui/preferences.json"
end
