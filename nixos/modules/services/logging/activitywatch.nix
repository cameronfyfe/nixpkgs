{ config, lib, pkgs, ... }:

let

  inherit (builtins)
    attrNames
    foldl'
    ;
  inherit (lib)
    literalExpression
    mkIf
    # mkMerge
    mkOption
    types
    ;

  cfg = config.services.activitywatch;

  config-server = {
    systemd.user.services.aw-server = {
      description = "ActivityWatch Server";
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${cfg.server}/bin/aw-server";
        Restart = "always";
      };
    };
  };

  configs-watchers = #[
  #   ({
  #     systemd.user.services.aw-watcher-afk = {
  #       description = "ActivityWatch Watcher (aw-watcher-afk)";
  #       wantedBy = [ "graphical-session.target" ];
  #       after = [ "aw-server.service" ];
  #       serviceConfig = {
  #         ExecStart = "${cfg.watchers.aw-watcher-afk}/bin/aw-watcher-afk";
  #         Restart = "always";
  #       };
  #     };
  #   })
  #   ({
  #     systemd.user.services.aw-watcher-window = {
  #       description = "ActivityWatch Watcher (aw-watcher-window)";
  #       wantedBy = [ "graphical-session.target" ];
  #       after = [ "aw-server.service" ];
  #       serviceConfig = {
  #         ExecStart = "${cfg.watchers.aw-watcher-window}/bin/aw-watcher-window";
  #         Restart = "always";
  #       };
  #     };
  #   })
  # ];
  map
    (watcher:
      let
        watcher-pkg = builtins.trace "${cfg.watchers}" cfg.watchers.${watcher};
      in
      {
        systemd.user.services.${watcher} = {
          description = "ActivityWatch Watcher (${watcher})";
          wantedBy = [ "graphical-session.target" ];
          after = [ "aw-server.service" ];
          serviceConfig = {
            ExecStart = "${watcher-pkg}/bin/${watcher}";
            Restart = "always";
          };
        };
      }
    )
    (attrNames cfg.watchers);
    # [ "aw-watcher-afk" "aw-watcher-window" ];

in

{

  options = {

    services.activitywatch = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to enable ActivityWatch.";
      };

      server = mkOption {
        type = types.path;
        default = pkgs.activitywatch.aw-server;
        defaultText = literalExpression "pkgs.activitywatch.aw-server";
        description = "The ActivityWatch server to use.";
      };

      watchers = mkOption {
        type = types.attrs;
        default = {
          aw-watcher-afk = pkgs.activitywatch.aw-watcher-afk;
          aw-watcher-window = pkgs.activitywatch.aw-watcher-window;
        };
        defaultText = literalExpression ''{
          aw-watcher-afk = pkgs.activitywatch.aw-watcher-afk;
          aw-watcher-window = pkgs.activitywatch.aw-watcher-window;
        }'';
        description = ''The ActivityWatch watchers to use. Of the form:
          {
            "name" = "pkg";
            ...
          }
          "name": Name of watcher systemd service ("name".service).
          "pkg": Package to run as watcher service (must contain binary called "name").
        '';
      };

    };
  };

  config = mkIf cfg.enable (
    foldl' (set: x: set // x) { } ([ config-server ] ++ configs-watchers)
  );
}
