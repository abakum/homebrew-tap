# typed: false
# frozen_string_literal: true

cask "crocson" do
  arch arm: "arm64", intel: "amd64"

  version "1.11.61"
  sha256 arm:          "c8977293d9f5925ce1cb158bfcbb709f4f809603fda4146be7e6ee14ee5f066f",
         intel:        "fc62cf478276b3ac75d275683bc0e46565645ebb86c843f1df312d3b187536ef",
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
