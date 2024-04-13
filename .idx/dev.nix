# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "unstable"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.flutter319
    pkgs.nodePackages.firebase-tools
    pkgs.jdk17
    pkgs.dart
    pkgs.gradle
    pkgs.android-tools
  ];
  # Sets environment variables in the workspace
  env = { };
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      # "vscodevim.vim"
    ];
    # Enable previews and customize configuration
    previews = {
      enable = true;
      previews = [
        {
          command = [ "flutter" "run" "--machine" "-d" "web-server" "--web-hostname" "0.0.0.0" "--web-port" "$PORT" ];
          id = "web";
          manager = "flutter";
        }
        {
          command = [ "flutter" "run" "--machine" "-d" "android" "-d" "localhost:5555" ];
          id = "android";
          manager = "flutter";
        }
      ];
    };
  };
}
