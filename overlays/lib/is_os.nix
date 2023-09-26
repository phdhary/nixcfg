{...}: let
  inherit (builtins) readFile filter isString split length head match;
in {
  name = "isOS";
  value = name: let
    os_release = readFile "/etc/os-release";
    os_lines = filter isString (split "\n" os_release);
    safeHead = xs:
      if length xs == 0
      then null
      else head xs;
    get_os_field = key: safeHead (head (filter (x: x != null) (map (match key) os_lines)));
    osId = get_os_field "ID=(.+)";
  in
    osId == name;
}
