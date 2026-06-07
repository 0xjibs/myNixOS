{ self, inputs, ... }: {
  flake.nixosConfigurations.ms01 = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.ms01Configuration
    ];
  };
}
