{ pkgs }:

pkgs.lib.makeScope pkgs.newScope (self:
  let callPackage = self.callPackage;
  in { stablilty-matrix = callPackage ./stability-matrix { }; })
