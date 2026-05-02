cask "agent-sushi" do
  version "0.1.4"
  sha256 "79a697d738c79354b9f1eddd2b88b363f6d4ac30aebda2f39700e70106fc1910"

  url "https://github.com/kmatsushita1012/homebrew-agent-sushi-notifier/releases/download/v#{version}/agent-sushi-#{version}.tar.gz"
  name "Agent Sushi"
  desc "Sushi-themed completion overlay for AI task notifications"
  homepage "https://github.com/kmatsushita1012/homebrew-agent-sushi-notifier"

  app "SushiArrived.app"
  binary "agent-sushi"
end
