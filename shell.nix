{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Ruby and Bundler
    ruby_3_3
    bundler

    # Databases
    sqlite
    postgresql

    # JavaScript Runtime and Package Managers (often needed for Rails)
    nodejs_20
    yarn

    # System dependencies for compiling native extensions
    libyaml
    zlib
    openssl
    pkg-config
    libxml2
    libxslt
  ];

  shellHook = ''
    # Set up a local directory for gems to avoid conflicts with system gems
    # and to ensure gems are installed in a writable location.
    export GEM_HOME=$PWD/.nix-gems
    export GEM_PATH=$GEM_HOME
    export PATH=$GEM_HOME/bin:$PATH

    echo "Welcome to your Ruby on Rails study environment!"
    echo "Ruby version: $(ruby -v)"
    echo "Bundler version: $(bundle -v)"
    echo "SQLite version: $(sqlite3 --version)"
    echo "PostgreSQL version: $(psql --version)"
    echo ""
    echo "To start a new Rails project, run: gem install rails && rails new my_app"
  '';
}
