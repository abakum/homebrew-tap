# typed: false
# frozen_string_literal: true

cask "crocgui" do
  arch arm: "arm64", intel: "amd64"

  version "1.11.33"
  sha256 arm:          "24d494e42c860afccbcaefcf556b197702d2d990fb83bc96858a3349046c8f45",
         intel:        "2737aee6d8a51e9e3b5c1ed3f0af6dd1db0f62fe5f62e13aa9373b0f8217d41f",
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
