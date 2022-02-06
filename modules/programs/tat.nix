{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.tat;
in
{
  options.programs.tat = {
    enable = mkEnableOption "Enable tat";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.tat ];
  };
}
