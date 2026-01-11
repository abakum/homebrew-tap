# typed: false
# frozen_string_literal: true

cask "crocgui" do
  arch arm: "arm64", intel: "amd64"

  version "1.11.35"
  sha256 arm:          "9490379e6fff5af8aad9272605301b5684780f730919c98469de4792a27db9a6",
         intel:        "c36c161ca625faa6cb208b5da61b53d27a2ee7e4d0729101493aa0fac0f6aac8",
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
                   args: ["-d", "com.apple.quarantine", staged_path/"crocgui.app"]
  end

  zap trash: "~/Library/Preferences/fyne/com.github.howeyc.crocgui/preferences.json"
end
