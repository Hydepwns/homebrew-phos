# typed: false
# frozen_string_literal: true

# Homebrew formula for phos - Universal log colorizer
class Phos < Formula
  desc "Universal log colorizer with built-in support for 59+ programs"
  homepage "https://github.com/Hydepwns/phos"
  url "https://github.com/Hydepwns/phos/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "42fb8c9fec8114b7155344fb47e32b85989213bd1413f950d24a75dd3e326a10"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/Hydepwns/phos.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    # Generate shell completions
    generate_completions_from_executable(bin/"phos", "completions")
  end

  test do
    # Test version output
    assert_match version.to_s, shell_output("#{bin}/phos --version")

    # Test list command
    assert_match "docker", shell_output("#{bin}/phos list")

    # Test colorization via pipe
    output = pipe_output("#{bin}/phos -p cargo", "error[E0382]: borrow of moved value")
    assert_match "error", output
  end
end
