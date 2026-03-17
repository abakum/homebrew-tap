# typed: false
# frozen_string_literal: true

cask "crocgui" do
  arch arm: "arm64", intel: "amd64"

  version "1.11.50"
  sha256 arm:          "68c1025f54cc4c0eebc720e07e5881e34e12a9b8dff508db59bf103d0e15d150",
         intel:        "33b98096b85f79d4aafc4db0694c371158b2a8b0c75c37ca9b328747a54ccbb6",
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
