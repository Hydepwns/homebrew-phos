# typed: false
# frozen_string_literal: true

# Homebrew formula for phos - Universal log colorizer
class Phos < Formula
  desc "Universal log colorizer with built-in support for 99 programs"
  homepage "https://github.com/Hydepwns/phos"
  url "https://github.com/Hydepwns/phos/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "fe0fcfaf4a5aff06bfb8750716ff9ad1e5e3445f55738d821c956cd0f059c246"
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
