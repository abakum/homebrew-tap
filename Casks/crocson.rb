# typed: false
# frozen_string_literal: true

cask "crocson" do
  arch arm: "arm64", intel: "amd64"

  version "1.11.64"
  sha256 arm:          "b984d6cd321dd4b9cb1edfc0c1e91077c67c3b1972ddcaca7c4c0ab19a7cd5ea",
         intel:        "339935b6e76671435507e32f2e0e823329f010ac47ae5818157e41ec590aa8cf",
         arm64_linux:  "0",
         x86_64_linux: "0"

  url "https://github.com/abakum/crocson/releases/download/v#{version}/crocson-#{arch}.dmg"
  name "crocson"
  desc "GUI for croc — secure file transfer tool"
  homepage "https://github.com/abakum/crocson"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "crocson.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-r", "-d", "com.apple.quarantine", staged_path/"crocson.app"]
  end

  zap trash: "~/Library/Preferences/fyne/com.github.abakum.crocson/preferences.json"
end
