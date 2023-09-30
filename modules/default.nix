let
  modules = builtins.map (f: (import (./. + "/${f}"))) (builtins.filter
    (f: f != "default.nix" && f != "programs" && f != "services")
    (builtins.attrNames (builtins.readDir ./.)));
  programs-modules = builtins.map (f: (import (./programs + "/${f}")))
    (builtins.filter (f: f != "cli-apps" && f != "gui-apps")
      (builtins.attrNames (builtins.readDir ./programs)));
  programs-cli-apps-modules =
    builtins.map (f: (import (./programs/cli-apps + "/${f}")))
    (builtins.attrNames (builtins.readDir ./programs/cli-apps));
  programs-gui-apps-modules =
    builtins.map (f: (import (./programs/gui-apps + "/${f}")))
    (builtins.attrNames (builtins.readDir ./programs/gui-apps));
  services = builtins.map (f: (import (./services + "/${f}")))
    (builtins.attrNames (builtins.readDir ./services));
in modules ++ programs-modules ++ programs-cli-apps-modules
++ programs-gui-apps-modules ++ services
