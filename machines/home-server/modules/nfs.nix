{ config, pkgs, ... }:
{
  services.nfs.server = {
    enable = true;
    exports = ''
      /media/archive        192.168.88.0/24(rw,insecure,nohide,all_squash,anonuid=1050,anongid=1050,no_subtree_check)
      /media/archive        10.100.0.0/24(rw,insecure,nohide,all_squash,anonuid=1050,anongid=1050,no_subtree_check)
      /media/store/media    192.168.88.0/24(rw,insecure,nohide,all_squash,anonuid=1040,anongid=1040,no_subtree_check)
      /media/store/media    10.100.0.0/24(rw,insecure,nohide,all_squash,anonuid=1040,anongid=1040,no_subtree_check)
      /var/lib/hass         192.168.88.0/24(rw,insecure,nohide,all_squash,anonuid=0,anongid=0,no_subtree_check)
      /var/lib/hass         10.100.0.0/24(rw,insecure,nohide,all_squash,anonuid=0,anongid=0,no_subtree_check)
    '';
  };
}
