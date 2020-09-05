self: super:
{
  mopidy-subidy = super.callPackage ./packages/mopidy-subidy.nix {};
  mopidy-scrobbler = super.callPackage ./packages/mopidy-scrobbler.nix {};
}
