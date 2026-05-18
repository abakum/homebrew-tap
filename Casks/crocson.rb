# typed: false
# frozen_string_literal: true

cask "crocson" do
  arch arm: "arm64", intel: "amd64"

  version "1.11.57"
  sha256 arm:          "76df99829591c8ae3b0c93e4130ca0c7e21db74d054473e671feee0bb79b231c",
         intel:        "e1b8037f5e608fd4e9f94d14c4ea5d420a13b74043565daa7ea88241c6ddb902",
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
