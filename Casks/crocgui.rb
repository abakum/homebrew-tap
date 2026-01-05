# typed: false
# frozen_string_literal: true

cask "crocgui" do
  arch arm: "arm64", intel: "amd64"

  version "1.11.32"
  sha256 arm:          "cb8aae92631feae210b8f542db5fe564fa2ec454ee83acc3626a619696c0646c",
         intel:        "908b388826472dd7d944810754f8ad4e136f25edafc9b88a82e677047c6e902a",
         arm64_linux:  "0",
         x86_64_linux: "0"

  url "https://github.com/abakum/crocgui/releases/download/v#{version}/crocgui-#{arch}.dmg"
  name "crocgui"
  desc "GUI for croc — secure file transfer tool"
  homepage "https://github.com/abakum/crocgui"
  license "ISC"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "crocgui.app"

  zap trash: "~/Library/Preferences/fyne/com.github.howeyc.crocgui/preferences.json"
end
