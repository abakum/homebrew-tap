# typed: false
# frozen_string_literal: true

cask "crocson" do
  arch arm: "arm64", intel: "amd64"

  version "1.11.54"
  sha256 arm:          "1d2386ec62374c63d69d9f09655c4a3109f0be8c6e1892c340d56c62a6060803",
         intel:        "64bc4279cdf55c83ea1e7743198f8c6b9e226eedbd815ef330e598f5159534c3",
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
