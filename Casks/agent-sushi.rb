cask "agent-sushi" do
  version "0.1.2"
  sha256 "c09b5b10cbe47e59305ec2dd63ae78b550b48f40ed29a4718dfbaca8ebc9813c"

  url "https://github.com/kmatsushita1012/homebrew-agent-sushi-notifier/releases/download/v#{version}/agent-sushi-#{version}.tar.gz"
  name "Agent Sushi"
  desc "Sushi-themed completion overlay for AI task notifications"
  homepage "https://github.com/kmatsushita1012/homebrew-agent-sushi-notifier"

  app "SushiArrived.app"
  binary "agent-sushi"
end
