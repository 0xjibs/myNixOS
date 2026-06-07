{ self, inputs, ... }: {
  flake.nixosModules.mango = { pkgs, lib, ... }: {
    programs.mangowc = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myMango;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myMango = inputs.wrapper-modules.wrappers.mangowc.wrap {
      inherit pkgs; # THIS PART IS VERY IMPORTAINT, I FORGOT IT IN THE VIDEO!!!
      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];
        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
        input.keyboard.xkb.layout = "fr,fr";

        layout.gaps = 5;

        binds = {
          "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
          "Mod+Q".close-window = null;
          "Mod+S".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
        };
      };
    };
  };
}
