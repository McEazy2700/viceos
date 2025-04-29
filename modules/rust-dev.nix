{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Rust toolchain with components
    (rust-bin.stable.latest.default.override {
      extensions = [ "rust-src" "rust-analyzer" "rustfmt" "clippy" ];
      targets = [ "wasm32-unknown-unknown" ];
    })

    # Additional Rust tools
    cargo-edit
    cargo-watch
    cargo-audit
    cargo-tauri
  ];

  # Create a special shell environment for Rust development
  programs.fish.shellAliases = {
    # Add this to your existing aliases
    rust-shell = "nix-shell -p rustc cargo rust-analyzer rustfmt clippy --run fish";
  };

  # Essential environment variables for Rust
  home.sessionVariables = {
    # Your existing variables plus:
    CARGO_HOME = "$HOME/.cargo";
    RUSTUP_HOME = "$HOME/.rustup";
    # Critical for rust-analyzer to find standard library types
    RUST_SRC_PATH = "${pkgs.rust-bin.stable.latest.default.override { 
      extensions = [ "rust-src" ]; 
    }}/lib/rustlib/src/rust/library";
  };
}
