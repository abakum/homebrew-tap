# typed: false
# frozen_string_literal: true

cask "crocgui" do
  arch arm: "arm64", intel: "amd64"

  version "1.11.31"
  sha256 arm:   "b90e67de3413ccbad2624b7b833215233a9ad38c8eaea682c886496e63392865",
         intel: "4839530f83755f7759fd0de26ca43c6d5b9154e7e2cb8b4f47a6eedc0c8495ed"

  url "https://github.com/abakum/crocgui/releases/download/v#{version}/crocgui-#{arch}.dmg"
  name "crocgui"
  desc "GUI for croc — secure file transfer tool"
  homepage "https://github.com/abakum/crocgui"

  depends_on macos: ">= :big_sur"
  depends_on arch: :arm64
  depends_on arch: :intel

  app "crocgui-#{arch}.app"

  zap trash: "~/Library/Application Support/crocgui"
end
