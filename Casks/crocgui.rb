# typed: false
# frozen_string_literal: true

cask "crocgui" do
  version "1.11.31"

  if Hardware::CPU.intel?
    sha256 "4839530f83755f7759fd0de26ca43c6d5b9154e7e2cb8b4f47a6eedc0c8495ed"
    url "https://github.com/abakum/crocgui/releases/download/v#{version}/crocgui-amd64.dmg",
        verified: "github.com/abakum/crocgui/"
    app "crocgui-amd64.app"
  else
    sha256 "b90e67de3413ccbad2624b7b833215233a9ad38c8eaea682c886496e63392865"
    url "https://github.com/abakum/crocgui/releases/download/v#{version}/crocgui-arm64.dmg",
        verified: "github.com/abakum/crocgui/"
    app "crocgui-arm64.app"
  end

  name "crocgui"
  desc "GUI for croc — secure file transfer tool"
  homepage "https://github.com/abakum/crocgui"

  depends_on macos: ">= :big_sur"

  zap trash: [
  ]
end