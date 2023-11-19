{ lib, namespace, ... }: {
  options.${namespace}.lib = {

    enabled = lib.mkOption {
      type = lib.types.attrs;
      default = { enable = true; };
    };

    disabled = lib.mkOption {
      type = lib.types.attrs;
      default = { enable = false; };
    };

  };
}
