# typed: false
# frozen_string_literal: true

cask 'crocgui-amd64' do
  version '1.11.31'
  sha256 '4839530f83755f7759fd0de26ca43c6d5b9154e7e2cb8b4f47a6eedc0c8495ed'

  url "https://github.com/abakum/crocgui/releases/download/v#{version}/crocgui-amd64.dmg",
      verified: 'github.com/abakum/crocgui/'
  name 'crocgui (Intel)'
  desc 'GUI for croc (Intel version)'
  homepage 'https://github.com/abakum/crocgui'

  app 'crocgui-amd64.app'

  # depends_on macos: '>= :sierra'
  # zap trash: [
  #
  #            ]
end