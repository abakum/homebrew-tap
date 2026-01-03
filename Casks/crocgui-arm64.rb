# typed: false
# frozen_string_literal: true

cask "crocgui-arm64" do
  version "1.11.31"
  sha256 "b90e67de3413ccbad2624b7b833215233a9ad38c8eaea682c886496e63392865"

  url "https://github.com/abakum/crocgui/releases/download/v#{version}/crocgui-arm64.dmg",
      verified: "github.com/abakum/crocgui/"
  name "crocgui (Apple Silicon)"
  desc "GUI for croc (Apple Silicon version)"
  homepage "https://github.com/abakum/crocgui"

  app "crocgui-arm64.app"

  # depends_on macos: ">= :big_sur"

  # zap trash: [
  #
  #            ]
end