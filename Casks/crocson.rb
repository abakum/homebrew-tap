# typed: false
# frozen_string_literal: true

cask "crocson" do
  arch arm: "arm64", intel: "amd64"

  version "1.11.61"
  sha256 arm:          "db30b97c265fbf6cfbed2dfbc26caf54a4a9cbf665ed26196325a470da9bd219",
         intel:        "aec5948fd4307f40773126c114ae9eb4ffac0b5fed51c28908cc9f33e4f8d31d",
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
