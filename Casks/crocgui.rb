# typed: false
# frozen_string_literal: true

cask "crocgui" do
  arch arm: "arm64", intel: "amd64"

  version "1.11.46"
  sha256 arm:          "9bd69a1541b40941e2935e1ae869b104fa03c45d76b685d18b6c9aaa738aa088",
         intel:        "9858106f4d249144b08be49cbec701de1fba5b8422ce110b3f58fc48b5624804",
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
