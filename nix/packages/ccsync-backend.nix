{
  lib,
  buildGoModule,
  inputs,
}:
buildGoModule {
  pname = "ccsync-backend";
  version = "0";
  vendorHash = "sha256-6gJZQHnX9iVGDbkYsPUizyem9TzezJ8O+hT9jOcp7ig=";
  doCheck = false;

  src = inputs.ccsync + "/backend";
}
