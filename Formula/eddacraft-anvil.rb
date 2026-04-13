class EddacraftAnvil < Formula
  desc "Anvil CLI — structural governance for AI-assisted development"
  homepage "https://github.com/EddaCraft/anvil"
  version "0.3.1-beta"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/EddaCraft/anvil/releases/download/v0.3.1-beta/eddacraft-anvil-aarch64-apple-darwin.tar.xz"
      sha256 "26969d0635c4069d92732590b81bb38164d8153f367f79655a13dce2eda5d38b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EddaCraft/anvil/releases/download/v0.3.1-beta/eddacraft-anvil-x86_64-apple-darwin.tar.xz"
      sha256 "92ba53273caeb746fb1dee3781e2b7437a17868625e44b46e4ea80fcd86b5e83"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/EddaCraft/anvil/releases/download/v0.3.1-beta/eddacraft-anvil-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e7965c38e5affeae1334a71669d68a09fba6abeb683067f8c2a808fdfd3e26b3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EddaCraft/anvil/releases/download/v0.3.1-beta/eddacraft-anvil-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "47b7ba9942e67ad97ca0d9f876836a4fb929fc9dbf7dc1fae24e9f96ee69e9e2"
    end
  end
  license "LicenseRef-Proprietary"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "anvil"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "anvil"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "anvil"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "anvil"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
